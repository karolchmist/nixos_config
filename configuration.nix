# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./ssd-configuration.nix
      ./xserver-configuration.nix
      ./lenovo-t440s-configuration.nix
    ];

  # Use the gummiboot efi boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
	hostName = "karol"; # Define your hostname.
  	# wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  	networkmanager.enable = true;
	firewall = {
		enable = true;
		allowedTCPPorts = [
			137 138 139 # Samba/Netbios
		];
		allowedUDPPorts = [
			137 138 139 # Samba/Netbios
		];	
	};
  };

  # Select internationalisation properties.
  i18n = {
    # consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "pl";
    # defaultLocale = "pl_PL.UTF-8";
    supportedLocales = ["en_US.UTF-8/UTF-8"];
  };

  fonts.enableGhostscriptFonts = true;
  
  hardware = {
    pulseaudio.enable = true;
  };
  
  # Set your time zone
  time.timeZone = "Europe/Paris";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    wget
    htop 
    iotop
    vim
    p7zip
    zip
    traceroute
    iftop
    cron  
    fuse_exfat
    terminator
      
    # Dev
    #disnixos
    nix-repl
    nixops
    gnumake
    gitAndTools.gitFull
    cron
  ];


  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  programs.zsh.enable = true;

  # Enable the X11 windowing system.
  services = {
        fcron = {
		enable = true;
		allow = ["karol"];
	};

	nixosManual.showManual = true;
	
	# samba.enable = true;
	printing = {
		enable = true;
		drivers = [ pkgs.epson-escpr ];
	};

	redshift = {
	  enable = true;
	  latitude = "45.76";
	  longitude = "4.84";
	  brightness = {
		 day = "1";
		 night = "0.5";
	  };
	};


    mysql = {
     enable = true;
     package = pkgs.mysql;
     extraOptions = ''
		sync_binlog = 0
	'';
    };
  };
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.karol = {
    isNormalUser = true;
    home = "/home/karol";
    extraGroups = ["wheel" "networkmanager" "docker"];
    uid = 1001;
    shell = "/run/current-system/sw/bin/zsh";
  };

  
  security.sudo.wheelNeedsPassword = false;
  
  system.autoUpgrade.enable = false;
  
  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "15.09";

  virtualisation.virtualbox.host.enable = true;

  virtualisation.docker.enable = true;
}
