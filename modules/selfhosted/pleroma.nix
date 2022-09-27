{ config, lib, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.hexdump ];
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_14;
  };
  services.pleroma = {
    enable = true;
    secretConfigFile = config.age.secrets.pleroma.path;
    configs = [
      ''
      import Config

      config :pleroma, Pleroma.Web.Endpoint,
        url: [host: "pleroma.gronkiewicz.dev", scheme: "https", port: 443],
        http: [ip: {127, 0, 0, 1}, port: 4000]

      config :pleroma, :instance,
        name: "Gronkiewicz's pleroma",
        email: "admin@gronkiewicz.dev",
        notify_email: "pleroma@gronkiewicz.dev",
        limit: 5000,
        registrations_open: false

      config :pleroma, Pleroma.Captcha, enabled: false

      config :pleroma, :media_proxy,
        enabled: false,
        redirect_on_failure: true
        #base_url: "https://cache.pleroma.social"

      config :pleroma, Pleroma.Repo,
        adapter: Ecto.Adapters.Postgres,
        username: "pleroma",
        database: "pleroma",
        hostname: "localhost"

      # Configure web push notifications
      config :web_push_encryption, :vapid_details,
        public_key: "BGt7208IfkN0npAwSmKQCJKURtgi-KK8AxL-uSQIyAMAIXxtSM2Lsb0RuhMgDA7NPaug2TYynVQodhYxJI3Ce9A"

      config :pleroma, :database, rum_enabled: false
      config :pleroma, :instance, static_dir: "/media/data/pleroma/public"
      config :pleroma, Pleroma.Uploaders.Local, uploads: "/media/data/pleroma/uploads"

      # Enable Strict-Transport-Security once SSL is working:
      # config :pleroma, :http_security,
      #  sts: true

      config :pleroma, configurable_from_database: true

      config :pleroma, Pleroma.Upload, filters: [Pleroma.Upload.Filter.AnonymizeFilename, Pleroma.Upload.Filter.Dedupe]
    ''
    ];
  };
  services.traefik.dynamicConfigOptions = {
    http = {
      routers = {
        pleroma = {
          rule = "Host(`pleroma.gronkiewicz.dev`)";
          service = "pleroma";
        };
      };
      services = {
        pleroma = {
          loadBalancer.servers = [{ url = "http://127.0.0.1:4000"; }];
        };
      };
    };
  };

}
