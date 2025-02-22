{ config, pkgs, lib, ... }:

{
  home.username = "nearsyh";
  home.homeDirectory = "/home/nearsyh";
  home.stateVersion = "25.05";

  imports = [
    ../common.nix
    ../../home/atuin.nix
  ];
}
