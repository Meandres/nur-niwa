# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage

{ pkgs, unstable-pkgs }:

rec {
  # The `lib`, `modules`, and `overlays` names are special
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  inherit pkgs;

  bima = pkgs.callPackage ./pkgs/bima {};
  driverctl = pkgs.callPackage ./pkgs/driverctl {};
  example-package = pkgs.callPackage ./pkgs/example-package { };
  exmap = pkgs.callPackage ./pkgs/exmap { };
  firecracker-containerd = pkgs.callPackage ./pkgs/firecracker-containerd { };
  tpchgen-rs = unstable-pkgs.callPackage ./pkgs/tpchgen-rs { };
  trace-cmd = pkgs.callPackage ./pkgs/trace-cmd { };
  umap = pkgs.callPackage ./pkgs/umap { };
  umap-apps = pkgs.callPackage ./pkgs/umap-apps { inherit umap; };
  urunc = pkgs.callPackage ./pkgs/urunc {};
  vhive = pkgs.callPackage ./pkgs/vhive { };
  vmcache = pkgs.callPackage ./pkgs/vmcache { };
}
