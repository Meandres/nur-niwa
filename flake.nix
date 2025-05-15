{
  description = "A collection of packages that I couldn't find anywhere else (and that I used at some point).";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=24.11";
    unstable-nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { 
    self
    , nixpkgs
    , unstable-nixpkgs
    , flake-utils
  }:
    let
      systems = [
        "x86_64-linux"
        "i686-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "armv6l-linux"
        "armv7l-linux"
      ];
      inherit (flake-utils.lib) eachSystem filterPackages;
    in eachSystem systems (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowBroken = true;
        };
        unstable-pkgs = import unstable-nixpkgs {
          inherit system;
          config.allowBroken = true;
        };
      in {
        packages = (filterPackages system (import ./default.nix {inherit pkgs unstable-pkgs;}));
        lib = import ./lib {inherit pkgs unstable-pkgs;};
      }) // {
        nixosModules =
          builtins.mapAttrs (name: path: import path) (import ./modules);
      };
}
