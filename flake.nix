{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixos-wsl,
      ...
    }:
    let
      myOverlays = [
        ./overlays/pantalaimon.nix
      ];
    in 
      {
        nixpkgs.overlays = myOverlays;
        nixosConfigurations = {
          nixos-laptop = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              ./configuration.nix
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.kleha = import ./home.nix;
                home-manager.backupFileExtension = "bkup";
              }
            ];
          };
          nixos-wsl = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              nixos-wsl.nixosModules.default
              ./configuration-for-wsl.nix
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.kleha = import ./home-wsl.nix;
                home-manager.backupFileExtension = "bkup";
              }
            ];
          };
        };
      };
}
  
