{ ... }:

# -SSH-
# config for remote management
# The public key here will be imported by all exit nodes
{
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  users.users.tristan = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDZVLStwmxT0sVSFSt745kD9XbW0NFrxUxWPDOpdsdIQ tristan.m.peterson@gmail.com"
    ];
  };
}
