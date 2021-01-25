{
  description = "macOS configuration";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    emacs-overlay.url = github:nix-community/emacs-overlay;
    home-manager = {
      url = github:rycee/home-manager/master;
      inputs.nixpkgs.follows = "/nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, emacs-overlay, ... }@inputs: {
    homeManagerConfigurations = {
      gpampara = home-manager.lib.homeManagerConfiguration {
        configuration = { ... }: {
          nixpkgs.overlays = [ emacs-overlay.overlay ];
          imports = [
            ./home.nix
          ];
        };
        system = "x86_64-darwin";
        homeDirectory = "/Users/gpampara";
        username = "gpampara";
      };
    };

    macbook = self.homeManagerConfigurations.gpampara.activationPackage;
  };
}
