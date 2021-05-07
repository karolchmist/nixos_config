{ config, lib, pkgs, ... }:

{
  networking.networkmanager.enable = false;
  services.xserver = {
    enable = true;
    xkbOptions = "compose:caps, eurosign:5";

    displayManager.gdm.enable = true;

    desktopManager.gnome3 = {
      enable = true;
    };
  };
}
