{ config, lib, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    xkbOptions = "compose:caps, eurosign:5";

    displayManager.lightdm.enable = true;

    desktopManager.xfce = {
      enable = true;
      noDesktop = true;
      enableXfwm = false;
    };
    
    ### i3
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        j4-dmenu-desktop
        i3lock
        i3status-rust
      ];
    };
  };
}
