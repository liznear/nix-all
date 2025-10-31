{ config, inputs, pkgs, lib, ... }:

{
  home.username = "nearsyh";
  home.homeDirectory = "/home/nearsyh";
  home.stateVersion = "25.05";

  imports = [
    ../common.nix
    (import ../../home/ssh {
      prefix = "";
    })
  ];
}
