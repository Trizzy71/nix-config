{ config, ... }:

{
  # nix-config really lives in ~/repos/nix-config; nrs/hms still point at
  # ~/.config/nix-config, so keep that path aimed at the real thing
  home.file.".config/nix-config".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/repos/nix-config";
}
