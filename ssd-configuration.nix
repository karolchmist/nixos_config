{ config, lib, pkgs, ... }:

let 
  fsOptions = "defaults,relatime,discard";
in {
  fileSystems."/".options = fsOptions;
  fileSystems."/boot".options = fsOptions;
}
