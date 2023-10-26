{
  description = "Home Manager configuration of gpampara";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgsUnstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/release-23.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    declarative-cachix.url = "github:jonascarpay/declarative-cachix/master";
    sops-nix = {
      url = "github:Mic92/sops-nix/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = inputs@{ nixpkgs, nixpkgsUnstable, home-manager, ... }:
    let
      username = "gpampara";
    in
    {
      homeConfigurations."${username}" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-darwin";

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          {
            nixpkgs.overlays = [
              (import ./overlay)
              inputs.emacs-overlay.overlay
            ];
            home = {
              inherit username;
              homeDirectory = "/Users/${username}";
            };
          }
          inputs.declarative-cachix.homeManagerModules.declarative-cachix
          inputs.sops-nix.homeManagerModules.sops
          inputs.nix-colors.homeManagerModules.default
          ./home.nix
        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        extraSpecialArgs = {
          inherit (inputs) nix-colors;
          nixpkgsUnstable = inputs.nixpkgsUnstable.legacyPackages."x86_64-darwin";
        };
      };
    };
}
