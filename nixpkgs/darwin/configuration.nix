{ config, pkgs, ... }:

{
  # Setting XDG dirs because macOS
  environment.variables = {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
  };

  # Importing home-manager
  imports = [ <home-manager/nix-darwin> ];
  users.users.amoutill = {
  name = "amoutill";
  home = "/Users/amoutill/";
  };

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.users.amoutill = { pkgs, ... }: {
    #home.packages = with pkgs; [
    #];
    programs.bash.enable = true;
    programs.zsh.enable = true;
    programs.git = {
      enable = true;
      userName = "amoutill";
      userEmail = "amoutill@student.42lehavre.fr";
    };
    home.stateVersion = "23.11";
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    neovim
    ripgrep
    nerdfonts
    norminette
    rustup
  ];

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
  programs.zsh.enable = true;  # default shell on catalina
  programs.bash.enable = true;
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
