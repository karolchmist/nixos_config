{ config, lib, pkgs, ... }:

{
	services.xserver = {
		enable = true;
		layout = "pl";
		xkbOptions = "compose:caps, eurosign:5";
		#xserverArgs = [ "-dpi 144" ];

		displayManager.lightdm.enable = true;

		desktopManager.xfce = {
			enable = true;
			noDesktop = true;
			enableXfwm = false;
		};
		desktopManager.default = "xfce";
		
		### i3
		windowManager.i3.enable = true;
		windowManager.default = "i3";
	};
	
	environment.systemPackages = with pkgs; [
		dmenu
		i3
		i3status
		i3blocks
		nitrogen # wallpaper setter
		slock # X display locker
	];

}
