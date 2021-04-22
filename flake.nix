{
  description = "macOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    emacs-overlay.url = "github:nix-community/emacs-overlay/master";
    home-manager = {
      url = "github:rycee/home-manager/master";
      inputs.nixpkgs.follows = "/nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nur, home-manager, emacs-overlay, ... }@inputs: {
    workbook = home-manager.lib.homeManagerConfiguration {
      configuration = { ... }: {
        nixpkgs.overlays = [
          (import ./overlays)
          emacs-overlay.overlay
          nur.overlay
        ];
        imports =
          let
            nur-no-pkgs = import nur {
              nurpkgs = import nixpkgs { system = "x86_64-darwin"; };
            };
          in
            [
              nur-no-pkgs.repos.rycee.hmModules.emacs-init
              ./home.nix
	          ];
      };

      system = "x86_64-darwin";
      homeDirectory = /Users/gpampara;
      username = "gpampara";
    };

    macbook = self.workbook.activationPackage;
  };
}
