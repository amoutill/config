{ config, pkgs, ... }:

{
  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    extraOptions = ''
      use-xdg-base-directories = true
    '';
  };
  nixpkgs = {
    config.allowUnfree = true;
  };
}
