{ config, pkgs, lib, ... }:

{
  home.username = "nearsyh";
  home.homeDirectory = "/Users/nearsyh";
  home.stateVersion = "25.05";

  imports = [
    ../common.nix
  ];
}
