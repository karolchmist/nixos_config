{ config, lib, pkgs, ... }:

{
	services.xserver = {
		enable = true;
		layout = "pl";
		xkbOptions = "eurosign:5";

		/*	
		### Xfce
		desktopManager.xfce.enable = true;
		windowManager.i3.enable = true;
		windowManager.default = "i3";
		*/

	
		### KDE
		desktopManager.kde4.enable = true;
		displayManager.kdm.enable = true;
		
/*			
		### Gnome
		desktopManager.gnome3.enable = true;
		displayManager.gdm.enable = true;
*/		
		
/*		
		#### XMonad 
		desktopManager = { 
			xterm.enable = false;
			default = "none";
		};
*/
/*
		windowManager = {
			default = "xmonad";
			xmonad = {
				enable = true;
				enableContribAndExtras = true;
				#extraPackages = self: [ self.xmonadContrib ];
			};
		};		
*/		
	};
	
	environment.systemPackages = with pkgs; [
		xmonad-with-packages
		kde5.karchive
	];

}
