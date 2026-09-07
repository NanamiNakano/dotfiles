{
  description = "Extra package flakes";

  inputs = {
    gpoc.url = "github:yuezk/GlobalProtect-openconnect";
    utpm.url = "github:typst-community/utpm";
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
        utpm = utpm.packages.${final.stdenv.hostPlatform.system}.default;
      };
    };
}
