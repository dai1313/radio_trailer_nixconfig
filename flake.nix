{
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        disko.url = "github:nix-community/disko";
        disko.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = {nixpkgs, disko, ... }: {
        nixosConfigurations.console_1 = nixpkgs.lib.nixosSystem {   
            system = "x86_64-linux";
            modules = [
                disko.nixosModules.disko
                    ./configuration.nix
                    ./disk-config.nix
            ];
        };
    };
}
