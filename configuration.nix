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
      ./lenovo-t460p-configuration.nix
      ./wpa.nix
    ];

  # Use the gummiboot efi boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
	hostName = "hermes"; # Define your hostname.
  	wireless.enable = true;  # Enables wireless support via wpa_supplicant.
	firewall = {
		enable = true;
		allowedTCPPorts = [];
		allowedUDPPorts = [];
	};
  };

  i18n = {
  #  consoleKeyMap = "pl";
  #  supportedLocales = ["en_US.UTF-8/UTF-8"];
  };

  fonts.enableGhostscriptFonts = true;
  
  hardware = {
    pulseaudio.enable = true;
    # steam
    opengl.driSupport32Bit = true;
    opengl.driSupport = true;
    pulseaudio.support32Bit = true;
  };
  
  time.timeZone = "Europe/Paris";

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
    terminator
    keepassx
    pmount
 
    # Dev
    #disnixos
    nix-repl
    # nixops
    gnumake
    gitAndTools.gitFull
  ];


  programs.zsh.enable = true;

  services = {
#	udisks2.enable = true;

  	openssh.enable = true;
	dictd = {
		enable = true;
		DBs = with pkgs; [ 
			dictdDBs.eng2fra
			dictdDBs.fra2eng
			#dictdWiktionary
			#dictdWordnet
		 ];
	};

	nixosManual.showManual = true;
	
	# samba.enable = true;
	printing = {
		enable = true;
		drivers = [ pkgs.epson-escpr ];
	};

	redshift = {
	  enable = false;
	  latitude = "45.76";
	  longitude = "4.84";
	  brightness = {
		 day = "1";
		 night = "1.0";
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
    extraGroups = ["wheel" "networkmanager" "docker" "plugdev"];
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
  
  system.autoUpgrade.enable = true;
  
  # The NixOS release to be compatible with for stateful data such as databases.
  #system.stateVersion = "16.04";

  virtualisation.virtualbox.host.enable = true;

  virtualisation.docker.enable = true;
}
