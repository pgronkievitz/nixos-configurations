{ colors, config, pkgs, ... }:
let colors = import ./colors.nix;
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
        size = 12.0;
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
          yellow = colors.light.yellow;
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
      backround_opacity = 1.0;
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
