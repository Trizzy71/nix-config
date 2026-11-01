{ ... }:
# -GIT-
# both the  program and it's configuration
{
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        Name = "tristan";                         # username
        Email = "tristan.m.peterson@gmail.com";   # email
      };
      init.defaultBranch = "main";                # default branch
      pull.rebase = false;                        # plain merge on git pull
    };
  };
}
