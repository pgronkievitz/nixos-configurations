{ config, pkgs, ... }:
let colors = import ./colors.nix;
in {
  programs.zathura = {
    enable = true;
    options = {
      default-bg = colors.light.bg;
      default-fg = colors.light.fg;

      statusbar-bg = colors.light.bg-alt;
      statusbar-fg = colors.light.fg-alt;

      inputbar-bg = colors.light.bg-alt;
      inputbar-fg = colors.light.fg-alt;

      notification-bg = colors.light.teal;
      notification-fg = colors.light.fg-alt;

      notification-error-bg = colors.light.red;
      notification-error-fg = colors.light.fg-alt;

      notification-warning-bg = colors.light.yellow;
      notification-warning-fg = colors.light.fg-alt;

      highlight-color = colors.light.blue;
      highlight-active-color = colors.light.yellow;

      completion-bg = colors.light.bg-alt;
      completion-fg = colors.light.fg-alt;

      completion-highlight-bg = colors.light.base8;
      completion-highlight-fg = colors.light.cyan;

      recolor-lightcolor = colors.light.base8;
      recolor-darkcolor = colors.light.base0;
      recolor = true;
      recolor-keephue = true;
    };
  };
}
