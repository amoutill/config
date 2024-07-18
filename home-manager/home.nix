{ config, pkgs, ... }:

{
  xdg.enable = true;
  #home.packages = with pkgs; [
  #];
  programs = {
    bash = {
      enable = true;
      historyFile = "${config.xdg.dataHome}/bash/history";
      enableVteIntegration = true;
    };
    zsh = {
      enable = true;
      dotDir = ".config/zsh";
      history.path = "${config.xdg.dataHome}/zsh/history";
      autosuggestion.enable = true;
      enableVteIntegration = true;
    };
    starship.enable = true;
    gpg = {
      enable = true;
      homedir = "${config.xdg.dataHome}/gnupg";
    };
    git = {
      enable = true;
      userName = "amoutill";
      userEmail = "amoutill@student.42lehavre.fr";
      signing = {
        key = "9F12E898453A8058";
        signByDefault = true;
      };
      extraConfig = {
        color.pager = false;
      };
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };
  };
  home.stateVersion = "23.11";
}
