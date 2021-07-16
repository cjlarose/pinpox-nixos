{ lib, pkgs, config, ... }:
with lib;
let cfg = config.pinpox.server;
in {

  imports = [ ../../users/pinpox.nix ];

  options.pinpox.server = {
    enable = mkEnableOption "Enable the default server configuration";

    hostname = mkOption {
      type = types.str;
      default = null;
      example = "deepblue";
      description = "hostname to identify the instance";
    };

    homeConfig = mkOption {
      type = types.attrs;
      default = null;
      example = "{}";
      description =
        "Main users account home-manager configuration for the host";
    };

  };

  config = mkIf cfg.enable {

    networking.hostName = cfg.hostname;

    home-manager.users.pinpox = cfg.homeConfig;

    environment.systemPackages = with pkgs; [
      universal-ctags
      git
      gnumake
      go
      htop
      neovim
      nix-index
      nixfmt
      python
      ripgrep
      wget
    ];

    # pinpox.metrics.node.enable = true;
    pinpox.defaults = {
      environment.enable = true;
      locale.enable = true;
      nix.enable = true;
      zsh.enable = true;
      networking.enable = true;
    };
    pinpox.services = { openssh.enable = true; };
  };
}
