{ config, lib, pkgs, ... }:

{
	hardware = {
		trackpoint.fakeButtons = true;
		bluetooth.enable = true;
	};

	services.xserver = {
		xkbModel = "pc105";

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