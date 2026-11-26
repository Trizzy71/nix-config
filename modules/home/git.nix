{ pkgs, ... }:
# -GIT-
# both the  program and it's configuration
{
  home.packages = with pkgs; [
    gh # github cli - PRs, issues, CI status, separate from git itself
  ];

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "tristan"; # username
        email = "tristan.m.peterson@gmail.com"; # email
      };
      init.defaultBranch = "main"; # default branch
      pull.rebase = false; # plain merge on git pull
    };
  };
}
