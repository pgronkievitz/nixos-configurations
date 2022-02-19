{ pkgs, ... }: {
  fonts.fonts = [
    (pkgs.nerdfonts.override {
      fonts = [ "UbuntuMono" "FiraCode" "VictorMono" ];
    })
    pkgs.merriweather
    pkgs.merriweather-sans
  ];
}
