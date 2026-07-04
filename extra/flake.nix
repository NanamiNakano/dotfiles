{
  description = "Extra package flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    gpoc.url = "github:yuezk/GlobalProtect-openconnect";
  };

  outputs =
    {
      gpoc,
      ...
    }:
    {
      overlays.default = final: prev: {
        gpoc = gpoc.packages.${final.stdenv.hostPlatform.system}.default;
      };
    };
}
