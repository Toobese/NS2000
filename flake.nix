{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    systems.url = "github:nix-systems/default";
    devenv.url = "github:cachix/devenv";
  };

  outputs = { self, nixpkgs, devenv, systems, ... } @ inputs:
    let
      forEachSystem = nixpkgs.lib.genAttrs (import systems);
    in
    {
      devShells = forEachSystem
        (system:
          let
            pkgs = nixpkgs.legacyPackages.${system};
          in
          {
            default = devenv.lib.mkShell {
              inherit inputs pkgs;
              modules = [
                {
                  languages.python = {
                    enable = true;
                    poetry.enable = true;
                    package = pkgs.python3.withPackages (ps: [

                    ]);
                  };
                  packages = with pkgs; [
                  ];

                  enterShell = ''
                    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${pkgs.glib}/lib;
                  '';
                }
              ];
            };
          });
    };
}
