{ pkgs, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_rpi4;
    initrd.availableKernelModules = [ "vc4" "bcm2835_dma" "i2c_bcm2835" ];
  };
}
