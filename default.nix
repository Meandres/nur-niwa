# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage

{ pkgs ? import <nixpkgs> { } }:

rec {
  # The `lib`, `modules`, and `overlays` names are special
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  inherit pkgs;

  example-package = pkgs.callPackage ./pkgs/example-package { };
  vmcache = pkgs.callPackage ./pkgs/vmcache { };
  exmap = pkgs.callPackage ./pkgs/exmap { };
  urunc = pkgs.callPackage ./pkgs/urunc {};
  bima = pkgs.callPackage ./pkgs/bima {};
  vhive = pkgs.callPackage ./pkgs/vhive { };
  firecracker-containerd = pkgs.callPackage ./pkgs/firecracker-containerd { };
  umap = pkgs.callPackage ./pkgs/umap { };
  umap-apps = pkgs.callPackage ./pkgs/umap-apps { inherit umap; };
}
