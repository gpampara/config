{
  description = "macOS configuration";

  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    home-manager.url = "github:rycee/home-manager/release-22.11";
    nur.url = "github:nix-community/NUR";
    emacs-overlay.url = "github:nix-community/emacs-overlay/master";
    declarative-cachix.url = "github:jonascarpay/declarative-cachix/master";
  };

  # Use the same version of nixpkgs as us
  inputs.emacs-overlay.inputs.nixpkgs.follows = "nixpkgs";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  outputs = { self, nixpkgs, nixpkgs-unstable, nur, home-manager, emacs-overlay, declarative-cachix, ... }:
    let
      username = "gpampara";
      system = "x86_64-darwin";

      pkgs = import nixpkgs {
        inherit system;
        overlays =  [
          (import ./overlays)
          emacs-overlay.overlay
          nur.overlay
        ];
      };
    in
    {
      homeManagerConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs; #nixpkgs.legacyPackages.${system};
        modules =
          let
            nur-modules = import nur {
              nurpkgs = pkgs; #nixpkgs.legacyPackages.${system};
            };
            defaults = { pkgs, ... }: {
              _module.args.nixpkgs-unstable = import nixpkgs-unstable { inherit (pkgs.stdenv.targetPlatform) system; };
            };
          in
            [
              defaults
              nur-modules.repos.rycee.hmModules.emacs-init
              declarative-cachix.homeManagerModules.declarative-cachix
              ./home.nix
              {
                home = {
                  inherit username;
                  homeDirectory = toString /Users/${username};
                  stateVersion = "22.11";
                };
              }
            ];
      };
    };
}
