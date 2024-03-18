{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    kioskBase.url = "github:georgiaaim/nixos-kiosk-base"; # Adjust the URL/path to your flake
    kioskBase.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, kioskBase, ... }: {
    nixosConfigurations.IOTVignette = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        kioskBase.nixosModules.baseEnvironment
        ./hardware-configuration.nix # The consumer's specific hardware configuration
        ({ pkgs, ... }: {
          # Any additional system-specific configuration
          networking.hostName = pkgs.mkForce "IOTVignette";
        })
      ];
    };
  };
}

