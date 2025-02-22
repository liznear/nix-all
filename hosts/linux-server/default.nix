{ systemPackages }:

{ config, pkgs, lib, ... }:

{
  home.username = "nearsyh";
  home.homeDirectory = "/home/nearsyh";
  home.stateVersion = "25.05";
  home.packages = systemPackages;

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  imports = [
    ../common.nix
    (import ../../home/ssh {
      prefix = "";
    })
  ];
}
