{
  services.caddy = {
    enable = true;
    email = "caddy@gronkiewicz.xyz";
    config = builtins.readFile ./Caddyfile;
  };
}
