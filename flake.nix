{
  description = "macOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    emacs-overlay.url = "github:nix-community/emacs-overlay/master";
    home-manager.url = "github:rycee/home-manager/master";
    declarative-cachix.url = "github:jonascarpay/declarative-cachix/master";
  };

  # Use the same version of nixpkgs as us
  inputs.emacs-overlay.inputs.nixpkgs.follows = "nixpkgs";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  outputs = { self, nixpkgs, nur, home-manager, emacs-overlay, declarative-cachix, ... }:
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
          in
            [
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
