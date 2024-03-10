{ config, pkgs, ... }:

{
  xdg.enable = true;
  #home.packages = with pkgs; [
  #];
  programs.bash = {
    enable = true;
    historyFile = "${config.xdg.dataHome}/bash/history";
  };
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    history.path = "${config.xdg.dataHome}/zsh/history";
  };
  programs.git = {
    enable = true;
    userName = "amoutill";
    userEmail = "amoutill@student.42lehavre.fr";
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
  home.stateVersion = "23.11";
}
