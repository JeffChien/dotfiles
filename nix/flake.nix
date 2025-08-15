{
  description = "JChien's NixOS configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    # Optional: Declarative tap management
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      ...
    }:
    {
      # automatically gc
      nix.autoOptimiseStore = true;
      nix.gc.automatic = true;
      nix.gc.dates = "weekly";
      nix.gc.options = "--delete-older-than 90d";

      # allowing to install none-open source software
      nixpkgs.config.allowUnfree = true;

      i18n.defaultLocale = "zh_TW.UTF-8";
      i18n.supportedLocales = [
        "en_US.UTF-8"
        "en_GB.UTF-8"
      ];

      time.timeZone = "Asia/Taipei";

      # linux devices
      nixosConfigurations = { };

      # mac devices
      darwinConfigurations = {
        m1pro = inputs.nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          # Build darwin flake using:
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/m1pro/configuration.nix
            inputs.home-manager.darwinModules.home-manager
          ];
        };
      };
    };
}
