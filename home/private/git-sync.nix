{
  services.git-sync = {
    enable = true;
    repositories = {
      "notes" = {
        path = "/home/pg/Documents/notes";
        uri = "git@git.lab.home:pg/notes.git";
      };
    };
  };
}
