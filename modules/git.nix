{ ... }:

#########
# -GIT- #
#########
# git config, this is for managing the dotfiles

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        Name = "tristan";
        Email = "tristan.m.peterson@gmail.com";
      };
      init.defaultBranch = "main";
      pull.rebase = false; # plain merge on git pull
    };
  };
}
