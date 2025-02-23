{ pkgs, lib, ... }:
{
  hardware = {
    raspberry-pi."4" = {
      # enableRedistributableFirmware = true;
      apply-overlays-dtmerge.enable = true;
      fkms-3d.enable = true;
    };
    deviceTree = {
      enable = true;
      # filter = lib.mkForce "rpi-4-.dtb";
    };
  };
  environment.systemPackages = with pkgs; [
    libraspberrypi
    raspberrypi-eeprom
  ];
}
