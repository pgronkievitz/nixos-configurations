{ ... }: {
  programs.git.userEmail = "patryk@gronkiewicz.dev";
  programs.git.signing = {
    key = "AFE7E2FEE443F184";
    signByDefault = true;
  };
}
