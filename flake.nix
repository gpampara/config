{
  description = "Home Manager configuration of gpampara";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    stylix.url = "github:danth/stylix";

    # # Specify the source of Home Manager and Nixpkgs.
    # nixpkgs-unstable.url = github:nixos/nixpkgs/nixos-unstable;
    # nixpkgs.url = github:NixOS/nixpkgs/release-24.05;
    # home-manager = {
    #   url = github:nix-community/home-manager/release-24.05;
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    emacs-overlay = {
      url = github:nix-community/emacs-overlay/master;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    declarative-cachix.url = github:jonascarpay/declarative-cachix/master;
    sops-nix = {
      url = github:Mic92/sops-nix/master;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #nix-colors.url = github:misterio77/nix-colors;
    nur.url = github:nix-community/NUR;
    # stylix = {
    #   url = github:danth/stylix;
    #   inputs.nixpkgs.follows = "nixpkgs";
    #   inputs.home-manager.follows = "home-manager";
    # };
  };

#  outputs = { nixpkgs, nixpkgs-unstable, nur, home-manager, ... }@inputs:
  outputs = { nixpkgs, nur, home-manager, ... }@inputs:
    let
      username = "gpampara";
      system = "x86_64-darwin";

      # unstableOverlay = final: prev: {
      #   unstable = import nixpkgs-unstable {
      #     inherit system;
      #     config.allowUnfree = true;
      #   };
      # };
    in
    {
      homeConfigurations."${username}" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          {
            nixpkgs.overlays = [
              (import ./overlay)
#              unstableOverlay
              inputs.emacs-overlay.overlay
            ];
            home = {
              inherit username;
              homeDirectory = "/Users/${username}";
            };
          }

          inputs.declarative-cachix.homeManagerModules.declarative-cachix
          inputs.sops-nix.homeManagerModules.sops
          #inputs.nix-colors.homeManagerModules.default
	        inputs.stylix.homeManagerModules.stylix

          # Load NUR modules from rycee
          ({ pkgs, ... }:
            let
              nur-no-pkgs = import nur {
                nurpkgs = import nixpkgs { inherit system; };
              };
            in
            {
              imports = [ nur-no-pkgs.repos.rycee.hmModules.emacs-init ];
            }
          )
          ./home.nix
        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        extraSpecialArgs = {
          #inherit (inputs) nix-colors;
          #inherit (inputs) stylix;
          #nixpkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
        };
      };
    };
}
