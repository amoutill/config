{ config, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Setting XDG dirs because macOS
  environment.variables = {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
    CARGO_HOME = "$HOME/.local/state/cargo";
    RUSTUP_HOME = "$HOME/.local/state/rustup";
    LESSHISTFILE="$HOME/.local/state/less/history";
    MANPATH = "$MANPATH:/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/share/man";
  };

  environment.shellAliases = {
    nrs = "darwin-rebuild switch --flake ~/.config/nix/#Axels-MacBook-Pro";
  };

  environment.pathsToLink = [ "/share/qemu" ];
  networking = {
    computerName = "Axel's MacBook Pro";
    hostName = "Axels-MacBook-Pro";
    knownNetworkServices = [
      "Wi-Fi"
      "Thunderbolt Bridge"
    ];
    # dns = [ "100.100.100.100" "9.9.9.9" ];
  };

  users.users.amoutill = {
  name = "amoutill";
  home = "/Users/amoutill/";
  };

  nix.linux-builder = {
    enable = true;
    ephemeral = true;
    maxJobs = 4;
    config = {
      virtualisation = {
        darwin-builder = {
          diskSize = 40 * 1024;
          memorySize = 8 * 1024;
        };
        cores = 6;
      };
    };
  };
  nix.settings.trusted-users = [ "@admin" ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin";
  environment.systemPackages = with pkgs; [
    wget
    nodePackages.npm
    discord
    neovim
    ripgrep
    norminette
    rustup
    xdg-ninja
    htop
    sshfs
    tigervnc
    qemu
    podman
    podman-compose
    podman-tui
    butane
    virt-viewer
    fd
  ];
    homebrew = {
      enable = true;
      casks = [
        "iterm2"
        "rectangle"
        "mos"
        "utm"
        "firefox"
        "tailscale"
        "eloston-chromium"
      ];
    };


  fonts = {
    fontDir.enable = true;
    fonts = [
      pkgs.nerdfonts
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.amoutill = import ../../home-manager/home.nix;
  };

  #services.tailscale = {
  #  enable = true;
  #  overrideLocalDns = true;
  #};

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  security.pam.enableSudoTouchIdAuth = true;

  nix.extraOptions = ''
    use-xdg-base-directories = true
    '';

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;
  programs.bash.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
