{ config, pkgs, ... }:
let
  colors = {
    light = {
      bg = "#fafafa";
      bg-alt = "#f0f0f0";
      base0 = "#f0f0f0";
      base1 = "#e7e7e7";
      base2 = "#dfdfdf";
      base3 = "#c6c7c7";
      base4 = "#9ca0a4";
      base5 = "#383a42";
      base6 = "#202328";
      base7 = "#1c1f24";
      base8 = "#1b2229";
      fg = "#383a42";
      fg-alt = "#c6c7c7";
      grey = "#383a42";
      red = "#e45649";
      orange = "#8a3b3c";
      green = "#556b2f";
      teal = "#4db5bd";
      yellow = "#986801";
      yellow-alt = "#fafadd";
      blue = "#014980";
      dark-blue = "#030f64";
      magenta = "#a626a4";
      violet = "#b751b6";
      cyan = "#0184bc";
      dark-cyan = "#005478";
    };
    dark = {
      bg = "#000000";
      bg-alt = "#000000";
      base0 = "#1B2229";
      base1 = "#1c1f24";
      base2 = "#202328";
      base3 = "#23272e";
      base4 = "#3f444a";
      base5 = "#5B6268";
      base6 = "#73797e";
      base7 = "#9ca0a4";
      base8 = "#DFDFDF";
      fg = "#bbc2cf";
      fg-alt = "#5B6268";
      grey = "#5B6268";
      red = "#ff6c6b";
      orange = "#b4916d";
      green = "#98be65";
      teal = "#4db5bd";
      yellow = "#ECBE7B";
      blue = "#0170bf";
      dark-blue = "#003c64";
      magenta = "#c678dd";
      violet = "#a9a1e1";
      cyan = "#46D9FF";
      dark-cyan = "#5699AF";
    };
  };
in {

  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      window = {
        scale_with_dpi = true;
        dimensions = {
          columns = 100;
          lines = 85;
          padding = {
            x = 5;
            y = 5;
          };
          dynamic_padding = true;
          decorations = "none";
          startup_mode = "Maximized";
        };
      };
      scrolling = {
        history = 10000;
        miltiplier = 3;
      };
      font = {
        normal = { family = "FantasqueSansMono Nerd Font Mono"; };
        bold = {
          family = "FantasqueSansMono Nerd Font Mono";
          style = "Medium";
        };
        italic = {
          family = "FantasqueSansMono Nerd Font Mono";
          style = "Light Italic";
        };
        size = 14.0;
        use_thin_strokes = true;
      };
      draw_bold_text_with_bright_colors = false;

      colors = {
        primary = {
          background = colors.light.bg;
          foreground = colors.light.fg;
          dim_foreground = colors.light.bg-alt;
        };
        cursor = {
          text = colors.light.grey;
          cursor = colors.light.blue;
        };
        vi_mode_cursor = {
          text = colors.light.grey;
          cursor = colors.light.yellow;
        };
        selection = {
          text = "CellForeground";
          background = colors.light.base4;
        };
        search = {
          matches = {
            foreground = "CellBackground";
            background = colors.light.dark-cyan;
          };
          bar = {
            background = colors.light.blue;
            foreground = colors.light.blue;
          };
        };
        normal = {
          black = colors.light.base0;
          red = colors.light.red;
          green = colors.light.green;
          yellow = colors.light.yellow;
          blue = colors.light.blue;
          magenta = colors.light.magenta;
          cyan = colors.light.cyan;
          white = colors.light.base8;
        };
        bright = {
          black = colors.light.base1;
          red = colors.light.orange;
          green = colors.light.teal;
          yellow = colors.light.yellow-alt;
          blue = colors.light.blue;
          magenta = colors.light.magenta;
          cyan = colors.light.cyan;
          white = colors.light.base8;
        };
        dim = {
          black = colors.light.base1;
          red = colors.light.red;
          green = colors.light.green;
          yellow = colors.light.yellow;
          blue = colors.light.dark-blue;
          magenta = colors.light.violet;
          cyan = colors.light.dark-cyan;
          white = colors.light.base6;
        };
      };
      bell = {
        animation = "EaseOutExpo";
        color = "0xffffff";
        duration = 0;
      };
      backround_opacity = 0.9;
      key_bindings = [
        {
          key = "J";
          mods = "Alt";
          action = "ScrollLineDown";
        }
        {
          key = "K";
          mods = "Alt";
          action = "ScrollLineUp";
        }
        {
          key = "J";
          mods = "Control|Alt";
          action = "ScrollPageDown";
        }
        {
          key = "K";
          mods = "Control|Alt";
          action = "ScrollPageUp";
        }
      ];
      cursor.style = "Block";
    };
  };
}
