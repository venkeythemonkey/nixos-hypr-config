{
  description = "Venkatesh's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs, nixpkgs-unstable, ... }: {
    nixosConfigurations.expertbook-p1 = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit nixpkgs-unstable; };
      modules = [ ./hosts/expertbook-p1 ];
    };
  };
}
