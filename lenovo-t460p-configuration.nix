{ config, lib, pkgs, ... }:

{
	hardware = {
		bluetooth.enable = false;
	};

	services.xserver = {
		xkbModel = "pc105";

		libinput = {
			enable = true;
		};
	};
}
