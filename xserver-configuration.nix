{ config, lib, pkgs, ... }:

{
	services.xserver = {
		### Xfce
		#desktopManager.xfce.enable = true;
		windowManager.i3.enable = true;
		windowManager.default = "i3";

/*	
		### KDE
		desktopManager.kde4.enable = true;
		displayManager.kdm.enable = true;
*/		
/*			
		### Gnome
		desktopManager.gnome3.enable = true;
		displayManager.gdm.enable = true;
		#windowManager.compiz.enable = true;
*/		
/*		
		#### XMonad 
		desktopManager = { 
			xterm.enable = false;
			xfce.enable = true;
			default = "xfce";
		};
		displayManager.lightdm.enable = true;

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
	
	environment.systemPackages = with pkgs; [
		#gmrun
		#dmenu
		#xorg.xmessage
	];

}
