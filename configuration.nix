{ config, pkgs, ... }:
let username = "unixby"; in
{

  imports = [
    ./modules
    ./hardware-configuration.nix
  ];
  users.users."${username}" = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Add to wheel group for sudo access
  };
  home-manager.users."${username}" = import ./home.nix username;
  home-manager.backupFileExtension = "backup";

  system.stateVersion = "25.05";
}
