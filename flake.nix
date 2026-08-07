{
  description = "Venkatesh's NixOS configuration";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

  outputs = { nixpkgs, ... }: {
    nixosConfigurations.expertbook-p1 = nixpkgs.lib.nixosSystem {
      modules = [ ./configuration.nix ];
    };
  };
}
