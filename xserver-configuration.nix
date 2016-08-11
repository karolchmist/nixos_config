{ config, lib, pkgs, ... }:

{
	services.xserver = {
		enable = true;
		layout = "pl";
		xkbOptions = "compose:caps, eurosign:5";
		#xserverArgs = [ "-dpi 144" ];

		### i3
		windowManager.i3.enable = true;
		windowManager.default = "i3";
	};
	
	environment.systemPackages = with pkgs; [
		dmenu
		i3status
	];

}
