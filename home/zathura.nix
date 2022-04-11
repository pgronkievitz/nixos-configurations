{ theme, config, pkgs, ... }: {
  programs.zathura = {
    enable = false;
    options = {
      default-bg = theme.colors.bg;
      default-fg = theme.colors.fg;

      statusbar-bg = theme.colors.bg-alt;
      statusbar-fg = theme.colors.fg-alt;

      inputbar-bg = theme.colors.bg-alt;
      inputbar-fg = theme.colors.fg-alt;

      notification-bg = theme.colors.teal;
      notification-fg = theme.colors.fg-alt;

      notification-error-bg = theme.colors.red;
      notification-error-fg = theme.colors.fg-alt;

      notification-warning-bg = theme.colors.yellow;
      notification-warning-fg = theme.colors.fg-alt;

      highlight-color = theme.colors.blue;
      highlight-active-color = theme.colors.yellow;

      completion-bg = theme.colors.bg-alt;
      completion-fg = theme.colors.fg-alt;

      completion-highlight-bg = theme.colors.base8;
      completion-highlight-fg = theme.colors.cyan;

      recolor-lightcolor = theme.colors.base8;
      recolor-darkcolor = theme.colors.base0;
      recolor = true;
      recolor-keephue = true;
    };
  };
}
