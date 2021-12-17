{ ... }: {
  programs.git.userEmail = "patryk.gronkiewicz@omnilogy.pl";
  programs.git.signing = {
    key = "4F6A2A67E2EC8FD7A9BC20101BB5666B36D8CD93";
    signByDefault = true;
  };
}
