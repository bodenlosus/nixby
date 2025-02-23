{ config, lib, ... }:
{
  nixpkgs.crossSystem = lib.systems.elaborate "aarch64-linux";
}
