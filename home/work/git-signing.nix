{ ... }: {
  programs.git.signing = {
    key = "AFE7E2FEE443F184"; # this has to be changed as it's my private GPG key
    signByDefault = true;
  };
}
