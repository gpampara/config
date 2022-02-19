{
  description = "macOS configuration";

  inputs = {
    # https://github.com/nix-community/emacs-overlay/archive/master@%{2%20hours%20ago}.tar.gz
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    #nixpkgs.url = "https://github.com/NixOS/nixpkgs/archive/nixos-unstable%40%7B2%2520hours%2520ago%7D.tar.gz";
    nur.url = "github:nix-community/NUR";
    emacs-overlay.url = "github:nix-community/emacs-overlay/master";
    #emacs-overlay.url = "https://github.com/nix-community/emacs-overlay/archive/master%40%7B2%2520hours%2520ago%7D.tar.gz";
    home-manager = {
      url = "github:rycee/home-manager/master";
      inputs.nixpkgs.follows = "/nixpkgs";
    };
    declarative-cachix.url = "github:jonascarpay/declarative-cachix/master";
  };

  outputs = { self, nixpkgs, nur, home-manager, emacs-overlay, declarative-cachix, ... }:
    let
      system = "x86_64-darwin";
    in
    {
      homeManagerConfigurations = {
        gpampara = home-manager.lib.homeManagerConfiguration {
          configuration = { ... }: {
            nixpkgs.overlays = [
              (import ./overlays)
              emacs-overlay.overlay
              nur.overlay
            ];
            imports =
              let
                nur-no-pkgs = import nur {
                  nurpkgs = import nixpkgs {
                    inherit system;
                  };
                };
              in
              [
                nur-no-pkgs.repos.rycee.hmModules.emacs-init
                declarative-cachix.homeManagerModules.declarative-cachix
                ./home.nix
              ];
          };

          inherit system;
          homeDirectory = /Users/gpampara;
          username = "gpampara";
        };
      };
    };
}
