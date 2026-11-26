{ ... }:

# -SSH-
# config for secure shell access. keys live in each user's module
{
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };
}
