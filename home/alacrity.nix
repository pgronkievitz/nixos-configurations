{ theme, config, pkgs, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      window = {
        opacity = 0.9;
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
        norma.family = theme.font;
        bold = {
          family = theme.font;
          style = "Medium";
        };
        italic = {
          family = theme.font;
          style = "Light Italic";
        };
        size = 10.0;
        use_thin_strokes = true;
      };
      draw_bold_text_with_bright_colors = false;

      colors = {
        primary = {
          background = theme.colors.bg;
          foreground = theme.colors.fg;
          dim_foreground = theme.colors.fg-alt;
        };
        cursor = {
          text = theme.colors.grey;
          cursor = theme.colors.blue;
        };
        vi_mode_cursor = {
          text = theme.colors.grey;
          cursor = theme.colors.yellow;
        };
        selection = {
          text = "CellForeground";
          background = theme.colors.base4;
        };
        search = {
          matches = {
            foreground = "CellBackground";
            background = theme.colors.dark-cyan;
          };
          bar = {
            background = theme.colors.blue;
            foreground = theme.colors.blue;
          };
        };
        normal = {
          black = theme.colors.fg;
          red = theme.colors.red;
          green = theme.colors.green;
          yellow = theme.colors.yellow;
          blue = theme.colors.blue;
          magenta = theme.colors.magenta;
          cyan = theme.colors.cyan;
          white = theme.colors.bg;
        };
        bright = {
          black = theme.colors.base6;
          red = theme.colors.orange;
          green = theme.colors.teal;
          yellow = theme.colors.yellow;
          blue = theme.colors.blue;
          magenta = theme.colors.magenta;
          cyan = theme.colors.cyan;
          white = theme.colors.base0;
        };
        dim = {
          black = theme.colors.base1;
          red = theme.colors.red;
          green = theme.colors.green;
          yellow = theme.colors.yellow;
          blue = theme.colors.dark-blue;
          magenta = theme.colors.violet;
          cyan = theme.colors.dark-cyan;
          white = theme.colors.base6;
        };
      };
      bell = {
        animation = "EaseOutExpo";
        color = "0xffffff";
        duration = 0;
      };
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
