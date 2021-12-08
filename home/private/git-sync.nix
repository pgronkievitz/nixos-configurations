{
  services.git-sync = {
    enable = true;
    repositories = {
      "notes" = {
        path = "/home/pg/Documents/notes";
        uri = "git@gitlab.com:pgronkievitz/notes.git";
      };
    };
  };
}
