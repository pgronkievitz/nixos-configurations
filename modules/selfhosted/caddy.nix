{
  services.caddy = {
    enable = true;
    email = "caddy@gronkiewicz.xyz";
    config = ''
      {
        acme_dns cloudflare aaaaaaa
      }
    '';
    virtualHosts = {
      "vault.gronkiewicz.xyz" = {
        serverAliases = [ "www.vault.gronkiewicz.xyz" ];
        extraConfig = ''
          reverse_proxy 9001
        '';
      };
    };
  };
}
