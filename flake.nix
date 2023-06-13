{
  description = "Home Manager configuration of gpampara";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/release-23.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    declarative-cachix.url = "github:jonascarpay/declarative-cachix/master";
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }:
    let
      system = "x86_64-darwin";
      username = "gpampara";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

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
          ./home.nix
          ./config
          ./modules/emacs-init.nix
          inputs.declarative-cachix.homeManagerModules.declarative-cachix
        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
