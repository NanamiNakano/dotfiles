{
  description = "Extra package flakes";

  inputs = {
    gpoc.url = "github:yuezk/GlobalProtect-openconnect";
  };

  outputs =
    {
      gpoc,
      utpm,
      ...
    }:
    {
      overlays.default = final: prev: {
        gpoc = gpoc.packages.${final.stdenv.hostPlatform.system}.default;
      };
    };
}
