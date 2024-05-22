{ config, pkgs, ... }:

{
  # Setting XDG dirs because macOS
  environment = {
    variables = {
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";
      CARGO_HOME = "$HOME/.local/state/cargo";
      RUSTUP_HOME = "$HOME/.local/state/rustup";
      LESSHISTFILE="$HOME/.local/state/less/history";
      MANPATH = "$MANPATH:/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/share/man";
    };
    shells = [ pkgs.nushell ];
    shellAliases = {
      nrs = "darwin-rebuild switch --flake ~/.config/nix/#Axels-MacBook-Pro";
      tailscale = "/Applications/Tailscale.app/Contents/MacOS/Tailscale";
    };
    pathsToLink = [ "/share/qemu" ];
    systemPackages = with pkgs; [
      wget
      nodePackages.npm
      discord
      neovim
      ripgrep
      norminette
      rustup
      xdg-ninja
      htop
      fd
      kubernetes-helm
    ];
  };
  
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

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    linux-builder = {
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
    settings.trusted-users = [ "@admin" ];
    extraOptions = ''
      use-xdg-base-directories = true
    '';
  };

  nixpkgs = {
    config.allowUnfree = true;
    hostPlatform = "aarch64-darwin";
  };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
    brews = [
      "incus"
    ];
    casks = [
      "iterm2"
      "rectangle"
      "mos"
      "utm"
      "tailscale"
      "steam"
      "firefox"
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

  security.pam.enableSudoTouchIdAuth = true;

  programs = {
    zsh.enable = true;
    bash.enable = true;
    tmux = {
      enable = true;
      enableMouse = true;
      enableSensible = true;
      enableVim = true;
      extraConfig = ''
        setw -g aggressive-resize off
      '';
    };
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
