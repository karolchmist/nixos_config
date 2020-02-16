# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
    imports =
    [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
        ./ssd-configuration.nix
         ./xfce4-i3.nix
       #  ./wayland.nix
        # ./gnome3-i3.nix
        ./lenovo-t460p-configuration.nix
        ./wpa.nix
    ];

    # Use the gummiboot efi boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    boot.cleanTmpDir = true;
    boot.tmpOnTmpfs = true;

    # Intellij IDEA
    boot.kernel.sysctl = {
        "fs.inotify.max_user_watches" = 524288;
    };


    # See https://github.com/anderspapitto/nixos-configuration
    nix.nixPath = [
        "/etc/nixos"
        "nixos-config=/etc/nixos/configuration/configuration.nix"
    ];

    networking = {
        extraHosts = "
            127.0.0.1   localhost spark-master hive-metastore hive-server namenode kafka datanode registry registry-postgresql hdfs-filebrowser
            ::1         localhost spark-master hive-metastore hive-server namenode kafka datanode registry registry-postgresql hdfs-filebrowser
        ";
        hostName = "hermes"; # Define your hostname.
        wireless = {
            enable = true;  # Enables wireless support via wpa_supplicant.
            userControlled.enable = true;
        };
        firewall = {
            enable = true;
            allowedTCPPorts = [];
            allowedUDPPorts = [];
        };
    };

    i18n = {
        consoleKeyMap = "pl";
        defaultLocale = "pl_PL.UTF-8";
   };

    fonts = {
      enableGhostscriptFonts = true;
      fonts = with pkgs; [
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        liberation_ttf
        fira-code
        fira-code-symbols
        mplus-outline-fonts
        dina-font
        proggyfonts
        siji
        unifont
        roboto
      ];
    };

    sound.mediaKeys.enable = true;

    hardware = {
        pulseaudio.enable = true;
        # steam
        opengl.driSupport32Bit = true;
        opengl.driSupport = true;
        pulseaudio.support32Bit = true;

        sane.enable = true; # scanning
    };

    time.timeZone = "Europe/Paris";

    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
        wget
        htop
        iotop
        vim
        p7zip
        zip
        traceroute
        iftop
        fuse_exfat
        sakura # default terminal
        keepassx
        pmount
        killall

        hplip
    ];


    programs.zsh.enable = true;

    location = {
        latitude = 45.76;
        longitude = 4.84;
    };

    services = {
        dictd = {
            enable = true;
            DBs = with pkgs; [
                dictdDBs.eng2fra
                dictdDBs.fra2eng
            ];
        };

        earlyoom = {
            enable = true;
            enableDebugInfo = true;
        };
        
        
        gnome3.gnome-keyring.enable = true;

        nixosManual.showManual = true;

        printing = {
            enable = true;
            drivers = [ pkgs.hplipWithPlugin ];
        };

        saned.enable = true;

        redshift = {
            enable = true;
            brightness = {
                day = "1";
                night = "0.8";
            };
        };

        udev.extraRules = ''
            SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", MODE="0666", GROUP="plugdev"
            SUBSYSTEM=="usb", ATTR{idVendor}=="22b8", MODE="0666", GROUP="plugdev"
            SUBSYSTEM=="usb", ATTR{idVendor}=="0fce", MODE="0666", GROUP="plugdev"
            SUBSYSTEM=="usb", ATTR{idVendor}=="045e", MODE="0666", GROUP="plugdev"
            SUBSYSTEM=="usb", ATTR{idVendor}=="2ae5", MODE="0666", GROUP="plugdev"
        '';
 
        boinc = {
            enable = true;
            allowRemoteGuiRpc = true;
            extraEnvPackages = [
                pkgs.virtualbox
            ];
        };
    };
  
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.extraUsers.karol = {
        isNormalUser = true;
        home = "/home/karol";
        extraGroups = ["wheel" "networkmanager" "docker" "plugdev" "scanner" "video" "sway"];
        uid = 1001;
        shell = "/run/current-system/sw/bin/zsh";
    };
    users.extraUsers.guest = {
        isNormalUser = true;
        home = "/home/guest";
        extraGroups = [];
        uid = 1002;
        shell = "/run/current-system/sw/bin/zsh";
    };

    security.sudo.wheelNeedsPassword = false;

    virtualisation.docker.enable = true;
    virtualisation.docker.enableOnBoot = false;
}
