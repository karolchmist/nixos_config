{ config, lib, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    xkbOptions = "compose:caps, eurosign:5";
    #xserverArgs = [ "-dpi 144" ];

    displayManager.gdm.enable = true;

    desktopManager.gnome3 = {
      enable = true;
      flashback.customSessions = [
          {
            wmCommand = "${pkgs.i3}/bin/i3";
            wmLabel = "Gnome3 + i3";
            wmName = "gnome3-i3";
          }
      ];
    };
    desktopManager.default = "gnome-flashback-gnome3-i3-xsession";
    
    ### i3
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3lock
      ];
    };
    windowManager.default = "i3";
  };

  # gnome extensions are broken :/
  nixpkgs.config.allowBroken = true; 
  environment.systemPackages = with pkgs; [
    gnome3.gnome-shell
    gnome3.gnome-shell-extensions

  #  gnomeExtensions.system-monitor
    gnomeExtensions.battery-status
 ];
}
