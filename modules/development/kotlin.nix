{ pkgs, ... }: {
  environment.systemPackages =
    [ pkgs.kotlin pkgs.ktlint pkgs.kotlin-language-server ];
}
