{ config, lib, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    xkbOptions = "compose:caps, eurosign:5";
    #xserverArgs = [ "-dpi 144" ];

    displayManager.lightdm.enable = true;
    displayManager.defaultSession = "xfce+i3";

    desktopManager.xfce = {
      enable = true;
      noDesktop = true;
      enableXfwm = false;
    };
    
    ### i3
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3lock
      ];
    };
  };
  
  environment.systemPackages = with pkgs; [
    nitrogen # wallpaper setter
    slock # X display locker
    (polybar.override {
      i3Support = true;  
      mpdSupport = true;
    })
  ];

}
