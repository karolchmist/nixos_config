{ config, lib, pkgs, ... }:

{
    hardware = {
        bluetooth.enable = false;
    };

    boot.kernelParams = [ "video=SVIDEO-1:d mitigations=off" ];

    services = {
        tlp = {
            enable = true;
            settings = {
                "START_CHARGE_THRESH_BAT0" = 45;
                "STOP_CHARGE_THRESH_BAT0" = 60;
                "WIFI_PWR_ON_AC" = "off";
                "WIFI_PWR_ON_BAT" = "off";
                "DEVICES_TO_DISABLE_ON_LAN_CONNECT" = "wifi wwan";
            };
        };
        
        xserver = {
            xkbModel = "pc105";
    
            libinput = {
                enable = true;
            };
        };
    };
}
