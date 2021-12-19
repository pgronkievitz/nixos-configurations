{ pkgs, config, age, ... }:
let maildir = "/home/pg/.local/mail";
in {
  accounts.email = {
    maildirBasePath = maildir;
    accounts = {
      private = {
        address = "patryk@gronkiewi.cz";
        userName = "patryk@gronkiewi.cz";
        primary = true;
        realName = "Patryk Gronkiewicz";
        flavor = "plain";
        passwordCommand = "rbw get private-mu4e";
        aliases = [
          "patryk@gronkiewicz.dev"
          "patryk@gronkiewicz.xyz"
          "patryk@gronkiewicz.eu"
          "accounts@gronkiewi.cz"
          "accounts@gronkiewicz.dev"
          "accounts@gronkiewicz.xyz"
          "accounts@gronkiewicz.eu"
        ];
        gpg = {
          key = "29E8005AD590BF4064785C49AFE7E2FEE443F184";
          signByDefault = true;
        };
        imap = {
          host = "imap.purelymail.com";
          port = 993;
          tls.enable = true;
        };
        mbsync = {
          enable = true;
          create = "both";
          expunge = "both";
          patterns = [ "*" ];
        };
        imapnotify = {
          enable = true;
          boxes = [ "Inbox" ];
          onNotifyPost =
            "${pkgs.libnotify}/bin/notify-send 'New mail!' 'Private'";
        };
        msmtp.enable = true;
        smtp = {
          host = "smtp.purelymail.com";
          port = 587;
          tls.useStartTls = true;
        };
      };
      university = {
        realName = "Patryk Gronkiewicz";
        address = "164157@stud.prz.edu.pl";
        userName = "164157@stud.prz.edu.pl";
        passwordCommand = "${pkgs.rbw}/bin/rbw get PRz";
        gpg = {
          key = "29E8005AD590BF4064785C49AFE7E2FEE443F184";
          signByDefault = true;
        };
        imap = {
          host = "stud.prz.edu.pl";
          port = 993;
          tls.enable = true;
        };
        mbsync = {
          enable = true;
          create = "both";
          expunge = "both";
          patterns = [ "*" ];
        };
        imapnotify = {
          enable = true;
          boxes = [ "Inbox" ];
          onNotifyPost =
            "${pkgs.libnotify}/bin/notify-send 'New mail!' 'University'";
        };
        msmtp.enable = true;
        smtp = {
          host = "stud.prz.edu.pl";
          port = 587;
          tls.useStartTls = true;
        };
      };
    };
  };
  programs = {
    msmtp.enable = true;
    mbsync.enable = true;
  };
  services.mbsync = {
    enable = true;
    frequency = "*:0/15";
    preExec = "${pkgs.isync}/bin/mbsync -Ha";
    postExec = "${pkgs.mu}/bin/mu index -m ${maildir}";
  };
  home.packages = [ pkgs.libnotify pkgs.mu pkgs.isync ];
}
