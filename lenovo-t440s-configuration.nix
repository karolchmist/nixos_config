{ config, lib, pkgs, ... }:

{
	hardware = {
		trackpoint.fakeButtons = true;
		bluetooth.enable = true;
	};

	services.xserver = {
		synaptics = {
			enable = true;
			#horizEdgeScroll = false;
			#twoFingerScroll = true;
			tapButtons = false;
			#additionalOptions = ''
			#	Option "TapButton2" "3"
			#'';
		};
	};
}