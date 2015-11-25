# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./ssd-configuration.nix
    ];

  # Use the gummiboot efi boot loader.
  boot.loader.gummiboot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "pl";
    defaultLocale = "pl_PL.UTF-8";
    supportedLocales = ["pl_PL.UTF-8/UTF-8" "es_ES.UTF-8/UTF-8"];
  };

  hardware = {
	trackpoint.fakeButtons = true;
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

    # Desktop
    firefox
    #redshift
    #xmonad-with-packages

    # Dev
    sbt
    idea.idea-community
    gitAndTools.gitFull
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services = {
	nixosManual.showManual = true;
	
	samba.enable = true;
	
	redshift = {
	  enable = true;
	  latitude = "45.76";
	  longitude = "4.84";
	  brightness = {
		 day = "0.5";
		 night = "0.4";
	  };
	};
	
	xserver = {
		enable = true;
  		layout = "pl";

  		desktopManager = { 
			kde4.enable = true;
			#xterm.enable = false;
			#default = "none";
		};
  		
		# Enable the KDE Desktop Environment.
  		displayManager = {
			kdm.enable = true;
			slim = {
				#enable = true;
				#defaultUser = "karol";
			};
		};
		synaptics = {
			enable = true;
			horizEdgeScroll = false;
			twoFingerScroll = true;
			tapButtons = false;
		};
  		# windowManager = {
		# 	default = "xmonad";
		#	xmonad = {
		#		enable = true;
  		#		enableContribAndExtras = true;
		#	};
		# };
		# services.xserver.xkbModel
		xkbOptions = "eurosign:e";
	};
  };
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.karol = {
    isNormalUser = true;
    home = "/home/karol";
    extraGroups = ["wheel" "networkmanager"];
    uid = 1000;
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "15.09";

}
