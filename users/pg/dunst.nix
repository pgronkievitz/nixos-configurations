{ config, pkgs, ... }:
let colors = import ./colors.nix;
in {

  services.dunst = {
    enable = true;
    settings = {
      global = {
        follow = "keyboard";
        geometry = "400x100-10+10";
        progress_bar = true;
        progress_bar_height = 5;
        progress_bar_min_width = 200;
        progress_bar_max_width = 200;
        padding = 10;
        separator_color = "auto";
        font = "FantasqueSansMono NF 14";
        markup = "full";
        format = ''
          <b>%s</b>
          %s'';
        corner_radius = 3;
      };
      urgency_low = {
        backround = colors.light.base0;
        foreground = colors.light.base8;
      };
      urgency_normal = {
        backround = colors.light.dark-blue;
        foreground = colors.light.bg;
      };
      urgency_critical = {
        backround = colors.light.red;
        foreground = colors.light.bg;
      };
    };
  };
}
