{
  inputs = {
    hooks.url = "github:cachix/pre-commit-hooks.nix";
    utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    nixpkgs,
    hooks,
    utils,
    ...
  }:
    utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
      buildInputs = builtins.attrValues {
        inherit
          (pkgs.nodePackages)
          nodejs
          pnpm
          ;
      };

      pre-commit-check = hooks.lib.${system}.run {
        src = ./.;
        hooks = {
          alejandra.enable = true;
          stylua.enable = true;
        };
      };
    in {
      devShells.default = pkgs.mkShell {
        inherit buildInputs;
        inherit (pre-commit-check) shellHook;

        nativeBuildInputs = [pre-commit-check.enabledPackages];
      };
    });
}
