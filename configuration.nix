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
       #  ./intel.nix
       #  ./gnome3.nix
       #  ./wayland.nix
        # ./gnome3-i3.nix
        ./lenovo-t460p-configuration.nix
        ./wpa.nix
    ];

    # Use the gummiboot efi boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    boot.cleanTmpDir = true;

    # Intellij IDEA
    boot.kernel.sysctl = {
        "fs.inotify.max_user_watches" = 524288;
    };


    # See https://github.com/anderspapitto/nixos-configuration
    nix.nixPath = [
        "/etc/nixos"
        "nixos-config=/etc/nixos/configuration/configuration.nix"
    ];    
    nix.useSandbox = true;
    
    boot.kernelPackages = pkgs.linuxPackages_latest;

    networking = {
        extraHosts = "
            127.0.0.1   localhost spark-master hive-metastore hive-server namenode kafka datanode registry registry-postgresql hdfs-filebrowser keycloak ldap jupyterhub yarn-resourcemanager
            ::1         localhost spark-master hive-metastore hive-server namenode kafka datanode registry registry-postgresql hdfs-filebrowser keycloak ldap jupyterhub yarn-resourcemanager
        ";
        hostName = "hermes"; # Define your hostname.
        wireless = {
            enable = true;  # Enables wireless support via wpa_supplicant.
            userControlled.enable = true;
        };
        firewall = {
            enable = false; # enabling it breaks spark docker tests
            allowedTCPPorts = [];
            allowedUDPPorts = [];
        };
    };

    #i18n = {
    #    consoleKeyMap = "pl";
    #    defaultLocale = "pl_PL.UTF-8";
  # };

    fonts = {
    #  enableGhostscriptFonts = true;
      # enableDefaultFonts = true;
     fonts = with pkgs; [
    #    noto-fonts
    #    noto-fonts-cjk
    #    noto-fonts-emoji
    #    liberation_ttf
    #    fira-code
    #    fira-code-symbols
    #    mplus-outline-fonts
    #    dina-font
    #    proggyfonts
    #    siji
    #    unifont
    #    roboto
        powerline-fonts
        font-awesome
        dejavu_fonts
      ];
    };

    # Doesn't work with wayland/sway/pulseaudio
    # sound.mediaKeys.enable = true;

    hardware = {
        pulseaudio.enable = true;
        pulseaudio.support32Bit = true;

        sane.enable = true; # scanning
        sane.extraBackends = [ pkgs.hplipWithPlugin ];
    };


    time.timeZone = "Europe/Paris";

    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
        wget
        htop
        iotop
        iftop
        vim
        zip
        traceroute
        fuse_exfat
        alacritty
        termite
        pmount
        killall
        
        lightlocker
        
        hplip
        simple-scan sane-frontends sane-backends
    ];

    location = {
        latitude = 45.76;
        longitude = 4.84;
    };

    programs = {
        # adb.enable = true;
        light.enable = true;
        fuse.userAllowOther = true;
        java = {
            enable = true;
            package = pkgs.jdk8_headless;
            # package = pkgs.graalvm8;
        };
        steam.enable = true;
        zsh.enable = true;
    };
    services = {
        bloop = {
           # install = true;
            extraOptions = [];
        };
        
        dictd = {
            enable = false;
            DBs = with pkgs; [
                dictdDBs.eng2fra
                dictdDBs.fra2eng
            ];
        };

        earlyoom = {
            enable = true;
            enableDebugInfo = true;
            freeMemThreshold = 3;
        };
        
        gnome3.gnome-keyring.enable = true;
        gnome3.evolution-data-server.enable = true;
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
            temperature = {
                day = 4000;
                night = 3500;
            };
            extraOptions = [
                "-r" # disable fading
            ];
        };

        udev.extraRules = ''
            # LG
            SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", MODE="0666", GROUP="plugdev" 
            SUBSYSTEM=="usb", ATTR{idVendor}=="22b8", MODE="0666", GROUP="plugdev"
            SUBSYSTEM=="usb", ATTR{idVendor}=="0fce", MODE="0666", GROUP="plugdev"
            SUBSYSTEM=="usb", ATTR{idVendor}=="045e", MODE="0666", GROUP="plugdev"
            SUBSYSTEM=="usb", ATTR{idVendor}=="2ae5", MODE="0666", GROUP="plugdev"
        '';
 
        boinc = {
            enable = false;
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
        extraGroups = ["wheel" "networkmanager" "docker" "plugdev" "scanner" "video" "sway" "adb" "adbusers"];
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
    users.extraGroups.vboxusers.members = [ "karol" ];
    security.sudo.wheelNeedsPassword = false;

    # virtualisation.virtualbox.host.enable = true;

    virtualisation.docker = {
        enable = true;
        enableOnBoot = false;
        # extraOptions = ''--experimental'';
    };
}
