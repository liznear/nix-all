{ systemPackages }:

{ config, pkgs, lib, ... }:

{
  home.username = "nearsyh";
  home.homeDirectory = "/home/nearsyh";
  home.stateVersion = "25.05";
  home.packages = systemPackages;
  home.shell = pkgs.zsh;

  imports = [
    ../common.nix
  ];
}
