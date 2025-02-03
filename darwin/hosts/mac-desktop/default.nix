{ config, pkgs, lib, ... }:

let
  common = import ../common.nix { inherit config pkgs lib; };
in
{
  home.username = "nearsyh";
  home.homeDirectory = "/Users/nearsyh";
  home.stateVersion = "25.05";

  programs = {
    ghostty = import ../../home/ghostty.nix { inherit config pkgs lib; };
  } // common.programs;
}
