{ config, pkgs, lib, ... }:

let
  common = import ../common.nix { inherit config pkgs lib; };
in
common // {
  home.username = "nearsyh";
  home.homeDirectory = "/Users/nearsyh";
  home.stateVersion = "25.05";
}
