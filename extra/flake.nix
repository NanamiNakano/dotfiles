{
  description = "Extra package flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    {
      ...
    }:
    {
      overlays.default = final: prev: {
      };
    };
}
