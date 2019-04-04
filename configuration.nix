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

  # See https://github.com/anderspapitto/nixos-configuration
  nix.nixPath = [
		"/etc/nixos"
		"nixos-config=/etc/nixos/configuration/configuration.nix"
	];

  networking = {
	extraHosts = "
		127.0.0.1   localhost spark-master hive-metastore hive-server namenode kafka datanode
		::1         localhost spark-master hive-metastore hive-server namenode kafka datanode
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

  fonts.enableGhostscriptFonts = true;
  
  hardware = {
    pulseaudio.enable = true;
    # steam
    opengl.driSupport32Bit = true;
    opengl.driSupport = true;
    pulseaudio.support32Bit = true;

    sane.enable = true; # scanning
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

    hplip
  ];


  programs.zsh.enable = true;

  services = {
#	udisks2.enable = true;
	dictd = {
		enable = true;
		DBs = with pkgs; [ 
			dictdDBs.eng2fra
			dictdDBs.fra2eng
			#dictdWiktionary
			#dictdWordnet
		 ];
	};

	gnome3.gnome-keyring.enable = true;

	nixosManual.showManual = true;
	
	# samba.enable = true;
	printing = {
		enable = true;
		drivers = [ pkgs.hplipWithPlugin ];
	};
	saned.enable = true;

	redshift = {
	  enable = true;
	  latitude = "45.76";
	  longitude = "4.84";
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
  };
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.karol = {
    isNormalUser = true;
    home = "/home/karol";
    extraGroups = ["wheel" "networkmanager" "docker" "plugdev" "scanner"];
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
