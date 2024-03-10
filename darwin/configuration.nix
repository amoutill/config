{ config, pkgs, ... }:

{
  # Setting XDG dirs because macOS
  environment.variables = {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
    CARGO_HOME = "$HOME/.local/state/cargo";
    RUSTUP_HOME = "$HOME/.local/state/rustup";
    LESSHISTFILE="$HOME/.local/state/less/history";
  };

  # Importing home-manager
  imports = [ <home-manager/nix-darwin> ];
  users.users.amoutill = {
  name = "amoutill";
  home = "/Users/amoutill/";
  };

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.users.amoutill = { config, pkgs, ... }: {
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
  };

  #Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    iterm2
    rectangle
    mos
    utm
    discord
    neovim
    ripgrep
    norminette
    rustup
    clang
    xdg-ninja
  ];

  fonts = {
    fontDir.enable = true;
    fonts = [
      pkgs.nerdfonts
    ];
  };

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Enable sudo authentication with Touch ID
  security.pam.enableSudoTouchIdAuth = true;

  # Set nix to use XDG dirs
  nix.extraOptions = ''
    use-xdg-base-directories = true
    '';

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh = {
    enable = true;
    variables = {
      ZDOTDIR = "$HOME/.config/zsh";
    };
  };

  programs.bash.enable = true;
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
