{ config, lib, pkgs, ... }:

let 
  fsOptions = ["noatime" "nodiratime"];
in {
  fileSystems."/".options = fsOptions;
  fileSystems."/boot".options = fsOptions;
  services.fstrim.enable = true;
}
