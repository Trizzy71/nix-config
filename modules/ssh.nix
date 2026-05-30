{ ... }:

# -SSH-
# config for remote management
# The public key here will be imported by all exit nodes
{
  service.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  users.users.tristan = {
    openssh.authorizedKeys.keys = [
      "replace with my SSH key"
    ];
  };
}
