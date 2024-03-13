{ config, pkgs, ... }:

{
  imports = [
    ../../home-manager/home.nix
  ];
  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };
  home.username = "amoutill";
  home.homeDirectory = "/home/amoutill";
  home.stateVersion = "23.11"; # Please read the comment before changing.
  targets.genericLinux.enable = true;
  home.packages = [
    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.shellAliases = {
    nrs = "home-manager switch --flake ~/.config/nix/#42lehavre";
  };

  programs.zsh = {
    envExtra = ''
      . ~/.nix-profile/etc/profile.d/nix.sh
    '';
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
