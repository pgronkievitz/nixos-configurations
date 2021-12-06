{ config, ... }:

{
  services.restic.backups = {
    b2 = {
      user = "pg";
      repository = "rclone:b2:artemis-backup";
      initialize = true;
      passwordFile = config.age.secrets.artemisbkp.path;
      paths = [ "/home/pg" ];
      extraBackupArgs = [
        "--exclude-caches"
        "--exclude=/home/pg/VM"
        "--exclude=/home/pg/Videos"
        "--exclude=/home/pg/Music"
      ];
      pruneOpts = [
        "--keep-daily 4"
        "--keep-weekly 3"
        "--keep-monthly 12"
        "--keep-yearly 10"
      ];
      timerConfig = { OnCalendar = "0/4:00"; };
      rcloneConfig = {
        type = "b2";
        hard_delete = "false";
        account = "000f596f152d8670000000007";
        key = "K000f1v8IGnD01VoVcJiNut7MuKP9Kw";
      };
    };
    local = {
      user = "pg";
      repository = "/media/pg/ext";
      initialize = true;
      passwordFile = "/home/pg/.cache/bkp_pass";
      paths = [ "/home/pg" ];
      extraBackupArgs = [
        "--exclude-caches"
        "--exclude=/home/pg/VM"
        "--exclude=/home/pg/Videos"
        "--exclude=/home/pg/Music"
      ];
      pruneOpts = [
        "--keep-daily 24"
        "--keep-weekly 3"
        "--keep-monthly 12"
        "--keep-yearly 10"
      ];
      timerConfig = { OnCalendar = "hourly"; };
    };
  };
}
