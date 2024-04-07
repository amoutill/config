{ config, pkgs, ... }:

{
  xdg.enable = true;
  #home.packages = with pkgs; [
  #];
  programs.bash = {
    enable = true;
    historyFile = "${config.xdg.dataHome}/bash/history";
    enableVteIntegration = true;
  };
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    history.path = "${config.xdg.dataHome}/zsh/history";
    autosuggestion.enable = true;
    enableVteIntegration = true;
    initExtra = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';
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
  programs.emacs = {
    enable = true;
    package = pkgs.emacsMacport;
  };
  home.stateVersion = "23.11";
}
