{ config, lib, pkgs, ... }:

{
	services.xserver = {
		enable = true;
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
		windowManager.i3 = {
			enable = true;
			extraPackages = with pkgs; [
				dmenu
				i3lock
			];
		};
		windowManager.default = "i3";
	};
	
	environment.systemPackages = with pkgs; [
		nitrogen # wallpaper setter
		slock # X display locker
		(polybar.override {
			i3Support = true;	
			mpdSupport = true;
		})
	];

}
