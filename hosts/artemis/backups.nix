{ config, ... }:

{
  services.restic.backups = {
    b2 = {
      user = "pg";
      repository = "b2:artemis-backup:/";
      initialize = true;
      passwordFile = config.age.secrets.artemisbkp.path;
      paths = [ "/home/pg" ];
      extraBackupArgs = [
        "--exclude-caches"
        "--exclude=/home/pg/VM"
        "--exclude=/home/pg/Videos"
        "--exclude=/home/pg/Music"
        "--exclude=/home/pg/Downloads"
        "--exclude=/home/pg/.local/share"
        "--exclude=/home/pg/.cache"
      ];
      pruneOpts = [
        "--keep-daily 1"
        "--keep-weekly 1"
        "--keep-monthly 3"
        "--keep-yearly 10"
      ];
      timerConfig = {
        OnCalendar = "0/4:00";
        RandomizedDelaySec = "30m";
      };
      environmentFile = config.age.secrets.artemisbkp-env.path;
    };
    rest = {
      user = "pg";
      repository = "rest:https://restic.lab.home/pg";
      initialize = true;
      passwordFile = config.age.secrets.artemisbkp.path;
      paths = [ "/home/pg" ];
      extraBackupArgs = [
        "--exclude-caches"
        "--exclude=/home/pg/VM"
        "--exclude=/home/pg/Videos"
        "--exclude=/home/pg/Music"
        "--exclude=/home/pg/Downloads"
        "--exclude=/home/pg/.local/share"
        "--exclude=/home/pg/.cache"
      ];
      pruneOpts = [
        "--keep-daily 4"
        "--keep-weekly 3"
        "--keep-monthly 12"
        "--keep-yearly 10"
      ];
      timerConfig = {
        OnCalendar = "0/2:00";
        RandomizedDelaySec = "30m";
      };
    };
  };
}
