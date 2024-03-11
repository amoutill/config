{ config, lib, pkgs, ... }:

{
  imports = [
    ./disk-config.nix
    ./hardware-configuration.nix
  ];
  boot = {
    loader.grub = {
      # no need to set devices, disko will add all devices that have a EF02 partition to the list already
      # devices = [ ];
      efiSupport = true;
      efiInstallAsRemovable = true;
    };
    initrd = {
      network = {
        enable = true;
        ssh = {
          enable = true;
          port = 1337;
          hostKeys = [ "/nix/secret/initrd/ssh_host_ed25519_key" ];
        };
      };
    };
    kernelParams = [ "ip=94.130.33.36::94.130.33.1:255.255.255.192:trantor:enp3s0:off" ];
  };

  networking = {
    hostName = "trantor";
    useDHCP = false;
    interfaces."enp3s0" = {
      ipv4.addresses = [{ address = "94.130.33.36"; prefixLength = 26; }];
      ipv6.addresses = [{ address = "2a01:4f8:10b:1e5c::1"; prefixLength = 64; }];
    };
    defaultGateway = "94.130.33.1";
    defaultGateway6 = { address = "fe80::1"; interface = "enp3s0"; };
  };

  time.timeZone = "Europe/Paris";

  services.openssh = {
    enable = true;
    ports = [ 1337 ];
    settings.PermitRootLogin = "prohibit-password";
  };

  environment.systemPackages = with pkgs; [
    neovim
  ];

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHdjxQ8D2dZbtsGPtf7WSFzM2cWy6txPFhu2CmT8nGz2 amoutill@student.42lehavre.fr"
  ];

  system.stateVersion = "23.11";
}
