{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixos-hardware, home-manager }:
    let
      system = "aarch64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
    in
    {
      packages.aarch64-linux = {
        sdImage = (self.nixosConfigurations.nixbi.config.system.build.sdImage);
      };
      nixosConfigurations = {
        nixbi = nixpkgs.lib.nixosSystem {
          inherit system pkgs;
          modules = [
            {
              nixpkgs.overlays = [
                # fix for sun4i missing
                (final: super: {
                  makeModulesClosure = x:
                    super.makeModulesClosure (x // { allowMissing = true; });
                })
              ];
              _module.args = { inherit inputs; };
            }
            "${nixpkgs}/nixos/modules/installer/sd-card/sd-image.nix"
            "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
            inputs.home-manager.nixosModules.home-manager
            inputs.nixos-hardware.nixosModules.raspberry-pi-4
            ./configuration.nix # DONE: CHANGEME: change the path to match your host folder
          ];
        };
      };
    };
}

