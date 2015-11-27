{ config, lib, pkgs, ... }:

{
	services.xserver = {
		enable = true;
		layout = "pl";
		desktopManager = { 
			kde4.enable = true;
			#gnome3.enable = true;
			#xterm.enable = false;
			#default = "none";
		};
		# Enable the KDE Desktop Environment.
		displayManager = {
			kdm.enable = true;
			#slim = {
			#	enable = true;
			#	defaultUser = "karol";
			#};
		};
		#windowManager = {
			# default = "xmonad";
			# xmonad = {
			# enable = true;
			# enableContribAndExtras = true;
			# extraPackages = self: [ self.xmonadContrib ];
			# };
		#};
		xkbModel = "pc105";
		xkbOptions = "eurosign:e";
	};
}
