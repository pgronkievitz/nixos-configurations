{ pkgs, ... }: {
  fonts = {
    fonts = [
      (pkgs.nerdfonts.override {
        fonts = [ "Ubuntu" "UbuntuMono" "FiraCode" "VictorMono" ];
      })
      pkgs.merriweather
      pkgs.merriweather-sans
    ];
    fontconfig = {
      defaultFonts = {
        serif = [ "Merriweather" ];
        emoji = [ "Noto Color Emoji" ];
        monospace = [ "VictorMono Nerd Font" ];
        sansSerif = [ "Ubuntu Nerd Font" ];
      };
    };
  };
}
