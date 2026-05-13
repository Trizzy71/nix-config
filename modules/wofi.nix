{ ... }:

{
  programs.wofi = {
    enable = true;
    settings = {
      width = 500;
      height = 300;
      location = "center";
      show = "drun";
      allow_markup = true;
      allow_images = true;
    };
  };
}
