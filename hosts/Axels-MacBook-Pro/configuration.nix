{ config, pkgs, ... }:

{
  imports =
    [
      ../common.nix
    ];
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
      MANPATH = "$MANPATH:/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/share/man:$HOME/.local/share/man/";
      PAGER = "page";
      MANPAGER = "page -t man";
      GIT_PAGER = "page -t git";
    };
    shellAliases = {
      nrs = "darwin-rebuild switch --flake ~/.config/nix/#Axels-MacBook-Pro";
      tailscale = "/Applications/Tailscale.app/Contents/MacOS/Tailscale";
      z = "zed";
    };
    systemPath = [ "/usr/local/MacGPG2/bin/" ];
    pathsToLink = [ "/share/qemu" ];
    systemPackages = with pkgs; [
      wget
      nodePackages.npm
      neovim
      page
      ripgrep
      norminette
      rustup
      xdg-ninja
      htop
      fd
      kubectl
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
  home = "/Users/amoutill";
  };

  nix = {
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
    taps = [ "railwaycat/emacsmacport" ];
    masApps = {
      "Prime Video" = 545519333;
      "Microsoft Remote Desktop" = 1295203466;
      "Parcel" = 639968404;
      "Pages" = 409201541;
      "WhatsApp" = 310633997;
      "Keynote" = 409183694;
      "The Unarchiver" = 425424353;
      "Slack" = 803453959;
      "Numbers" = 409203825;
      "TestFlight" = 899247664;
      "Apple Developper" = 640199958;
    };
    brews = [
      "incus"
      "xcodes"
      {
        name = "emacs-mac";
        args = [ "with-modules" ];
      }
    ];
    casks = [
      {
        name = "iterm2";
        greedy = true;
      }
#      {
#        name = "rectangle";
#        greedy = true;
#      }
      {
        name = "mos";
        greedy = true;
      }
      {
        name = "utm";
        greedy = true;
      }
      {
        name = "tailscale";
        greedy = true;
      }
      {
        name = "steam";
        greedy = true;
      }
      {
        name = "firefox";
        greedy = true;
      }
      {
        name = "proton-mail";
        greedy = true;
      }
      {
        name = "element";
        greedy = true;
      }
      {
        name = "logi-options-plus";
        greedy = true;
      }
      {
        name = "zed";
        greedy = true;
      }
      {
        name = "chatgpt";
        greedy = true;
      }
      {
        name = "clion";
        greedy = true;
      }
      {
        name = "rustrover";
        greedy = true;
      }
      {
        name = "discord";
        greedy = true;
      }
      {
        name = "balenaetcher";
        greedy = true;
      }
      {
        name = "vmware-fusion";
        greedy = true;
      }
      {
        name = "gpg-suite-no-mail";
        greedy = true;
      }
      {
        name = "free-gpgmail";
        greedy = true;
      }
    ];
  };

  fonts.packages = [
    pkgs.nerdfonts
  ];

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
