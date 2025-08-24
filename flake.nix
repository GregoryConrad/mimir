{
  description = "Mimir";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      utils,
    }:
    utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        formatter = pkgs.nixfmt-tree;

        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            rustup
            buf
            protobuf_31
            # TODO flutter335 but at version where native assets works
            # TODO LLVM
          ];

          env = {
            RUST_BACKTRACE = "1";
          };
        };
      }
    );
}
