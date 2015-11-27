{ config, lib, pkgs, ... }:

{
	services.xserver = {
		enable = true;
		layout = "pl";
		xkbOptions = "eurosign:5";
		
		### KDE
		desktopManager = { 
			kde4.enable = true;
		};
		displayManager = {
			kdm.enable = true;
		};
		
		/*		
		### Gnome
		desktopManager = { 
			gnome3.enable = true;
		};
		displayManager = {
			gdm.enable = true;

		};
		*/
		
		/*
		#### XMonad 
		desktopManager = { 
			xterm.enable = false;
			default = "none";
		};

		windowManager = {
			default = "xmonad";
			xmonad = {
				enable = true;
				#enableContribAndExtras = true;
				#extraPackages = self: [ self.xmonadContrib ];
			};
		};
		*/
		
	};
}
