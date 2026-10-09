# quiver-launcher-nix
Nix flake for tgeorgiadis/quiver-launcher
## usage:
add this repo to flake.nix inputs: 

```
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    quiver.url = "github:volpinif/quiver-launcher-nix";
  };

```
add quiver to installed packages: 

```
{ pkgs, inputs, ... }:

  environment.systemPackages =
    (with pkgs; [
      inputs.quiver.packages.${pkgs.system}.quiver-launcher
    ]);

}

```

rebuild and enjoy
