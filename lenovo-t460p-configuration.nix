{ config, lib, pkgs, ... }:

{
    hardware = {
        bluetooth.enable = false;
    };

    services = {
        tlp = {
            enable = true;
            extraConfig = ''
                 START_CHARGE_THRESH_BAT0=45
                 STOP_CHARGE_THRESH_BAT0=60 
                 WIFI_PWR_ON_AC=off
                 WIFI_PWR_ON_BAT=off
                 DEVICES_TO_DISABLE_ON_LAN_CONNECT="wifi wwan"
            '';
        };
        
        xserver = {
            xkbModel = "pc105";
    
            libinput = {
                enable = true;
            };
        };
    };
}
