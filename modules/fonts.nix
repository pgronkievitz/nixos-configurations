{ pkgs, ... }: {
  fonts = {
    fonts = [
      (pkgs.nerdfonts.override {
        fonts = [ "Ubuntu" "UbuntuMono" "FiraCode" "VictorMono" ];
      })
      pkgs.merriweather
      pkgs.merriweather-sans
      pkgs.victor-mono
      pkgs.ubuntu_font_family
    ];
    fontconfig = {
      defaultFonts = {
        serif = [ "Merriweather" ];
        emoji = [ "Noto Color Emoji" ];
        monospace = [ "Victor Mono" ];
        sansSerif = [ "Ubuntu" ];
      };
    };
  };
}
