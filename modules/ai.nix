{ pkgs, ... }:

let
  whisperModel = pkgs.fetchurl {
    url = "https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-base.en.bin";
    hash = "sha256-oDd5yG3zMjB19eeWyyzlAp8A7Ihp7uP9+4l6/jbG0AI=";
  };

  claudeVoice = pkgs.writeShellScriptBin "claude-voice" ''
    set -euo pipefail

    tmpfile=$(mktemp --suffix=.wav)
    trap 'rm -f "$tmpfile"' EXIT

    echo "recording... press enter to stop"
    ${pkgs.pipewire}/bin/pw-record --rate 16000 --channels 1 "$tmpfile" &
    rec_pid=$!
    read -r
    kill "$rec_pid" 2>/dev/null || true
    wait "$rec_pid" 2>/dev/null || true

    echo "transcribing..."
    text=$(${pkgs.whisper-cpp}/bin/whisper-cli -m ${whisperModel} -f "$tmpfile" -nt --no-prints)

    echo "$text"
    exec ${pkgs.claude-code}/bin/claude "$text"
  '';

  voiceType = pkgs.writeShellScriptBin "voice-type" ''
    set -euo pipefail

    runtime_dir="''${XDG_RUNTIME_DIR:-/tmp}"
    pidfile="$runtime_dir/voice-type.pid"
    wavfile="$runtime_dir/voice-type.wav"

    if [[ -f "$pidfile" ]]; then
      pid=$(cat "$pidfile")
      kill "$pid" 2>/dev/null || true
      wait "$pid" 2>/dev/null || true
      rm -f "$pidfile"

      ${pkgs.libnotify}/bin/notify-send "voice-type" "transcribing..."
      text=$(${pkgs.whisper-cpp}/bin/whisper-cli -m ${whisperModel} -f "$wavfile" -nt --no-prints)
      rm -f "$wavfile"

      ${pkgs.ydotool}/bin/ydotool type -- "$text"
    else
      ${pkgs.libnotify}/bin/notify-send "voice-type" "recording..."
      ${pkgs.pipewire}/bin/pw-record --rate 16000 --channels 1 "$wavfile" &
      echo $! > "$pidfile"
    fi
  '';
in
{
  home.packages = with pkgs; [
    whisper-cpp
    ollama-cuda
    pipewire
    libnotify
    claudeVoice
    voiceType
  ];

  systemd.user.services.ollama = {
    Unit = {
      Description = "ollama server for local large language models";
    };
    Service = {
      ExecStart = "${pkgs.ollama-cuda}/bin/ollama serve";
      Environment = [ "OLLAMA_FLASH_ATTENTION=1" ];
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
