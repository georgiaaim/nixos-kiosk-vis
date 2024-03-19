{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    kioskBase.url = "github:georgiaaim/nixos-kiosk-base"; # Adjust the URL/path to your flake
    kioskBase.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, kioskBase, ... }: {
    nixosConfigurations.VisionVignette = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        kioskBase.nixosModules.baseEnvironment
        ./hardware-configuration.nix # The consumer's specific hardware configuration
        ({ pkgs, lib, ... }: {
          # Any additional system-specific configuration
          networking.hostName = lib.mkForce "VisionVignette";
        })
      ];
    };
  };
}

