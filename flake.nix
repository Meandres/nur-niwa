{
  description = "A collection of packages that I couldn't find anywhere else.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { 
    self
    , nixpkgs
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
      in {
        packages = (filterPackages system (import ./default.nix {inherit pkgs;}));
        lib = import ./lib {inherit pkgs;};
      }) // {
        nixosModules =
          builtins.mapAttrs (name: path: import path) (import ./modules);
      };
}
