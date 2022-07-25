# Configuration file for ahorn
{ options, config, ... }: {

  imports = [
    ./hardware-configuration.nix
    ./retiolum.nix
  ];

  # often hangs
  systemd.services.systemd-networkd-wait-online.enable = false;
  systemd.services.NetworkManager-wait-online.enable = false;

  # documentation.nixos.includeAllModules = true;
  # documentation.nixos.options.splitBuild = false;

  lollypops = {

    secrets = {

      files = {

        secret1 = {
          cmd = "pass test-password";
          # path = "/tmp/testfile5";
        };


        copy-of-secret-1 = {
          cmd = "pass test-password";
          path = "/home/pinpox/test-secret1";
          owner = "pinpox";
          group-name = "users";
        };

        # "nixos-secrets/ahorn/ssh/borg/public" = {
        #   owner = "pinpox";
        #   group-name = "users";
        # };
      };
    };
  };


  hardware.sane.enable = true;
  users.users.pinpox.extraGroups = [ "scanner" "lp" ];

  # To build raspi images
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  networking.retiolum.ipv4 = "10.243.100.100";
  networking.retiolum.ipv6 = "42:0:3c46:519d:1696:f464:9756:8727";

  lollypops.secrets.files = {
    "retiolum/rsa_priv" = { };
    "retiolum/ed25519_priv" = { };
  };

  services.tinc.networks.retiolum = {
    rsaPrivateKeyFile = "${config.lollypops.secrets.files."retiolum/rsa_priv".path}";
    ed25519PrivateKeyFile = "${config.lollypops.secrets.files."retiolum/ed25519_priv".path}";
  };

  boot.blacklistedKernelModules = [ "nouveau" ];

  pinpox.services.restic-client.enable = true;

  pinpox.desktop = {
    enable = true;
    wireguardIp = "192.168.7.2";
    hostname = "ahorn";
    bootDevice = "/dev/disk/by-uuid/d4b70087-c965-40e8-9fca-fc3b2606a590";
  };
}
