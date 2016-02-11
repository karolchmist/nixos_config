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
  boot.loader.gummiboot.enable = true;
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
    vim
    p7zip
    traceroute
    
      # Dev
      disnixos
      nix-repl
      nixops
      gnumake
      
      jdk
      sbt
      idea.idea-community
      
      gitAndTools.gitFull
     
      pgadmin
      
      nodejs
      python # needed by gyp 
      gcc # needed by gyp 
      nodePackages.npm2nix
      nodePackages.bower2nix
      nodePackages.bower
      nodePackages.gulp
      nodePackages.karma
#      nodePackages.protractor
  ];


  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  programs.zsh.enable = true;

  # Enable the X11 windowing system.
  services = {
	nixosManual.showManual = true;
	
	# samba.enable = true;
	printing.enable = true;

	redshift = {
	  enable = true;
	  latitude = "45.76";
	  longitude = "4.84";
	  brightness = {
		 day = "0.5";
		 night = "0.4";
	  };
	};


    mysql = {
     enable = true;
     package = pkgs.mysql;
    };
  };
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.karol = {
    isNormalUser = true;
    home = "/home/karol";
    extraGroups = ["wheel" "networkmanager"];
    uid = 1001;
    shell = "/run/current-system/sw/bin/zsh";
  };

  
  security.sudo.wheelNeedsPassword = false;
  
  system.autoUpgrade.enable = true;
  
  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "15.09";

  # 15.09
  #services.virtualboxHost.enable = true;
  # 16.03
  virtualisation.virtualbox.host.enable = true;
}
