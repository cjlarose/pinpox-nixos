# tfenv nix flake

This project provides a Nix flake that exports a package for the installation of `tfenv`. This repository was forked from https://github.com/pinpox/nixos and pruned to contain only the dependencies necessary for `tfenv`.

## Usage

Add this flake to your flake's imports:

```nix
{
  inputs = {
    tfenv.url = "github:cjlarose/pinpox-nixos/tfenv";
  };
}
```

Add the flake's overlay to `nixpkgs.overlays`

```nix
{ nixpkgs, tfenv, ... }:
let
  system = "x86_64-linux";
in nixpkgs.lib.nixosSystem {
  inherit system;
  modules = [
    ({ pkgs, ... }: {
      nixpkgs.overlays = [
        tfenv.overlays.default
      ];
    })
  ];
}
```

The overlay adds a property called `tfenv`, which you can use anywhere you'd use a package from `nixpkgs`.

```nix
{ pkgs, ... }: {
  home.packages = [
    pkgs.tfenv
  ];
}
```
