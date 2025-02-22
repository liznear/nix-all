{ systemPackages }:

{ config, pkgs, lib, ... }:

{
  home.username = "nearsyh";
  home.homeDirectory = "/home/nearsyh";
  home.stateVersion = "25.05";
  home.packages = systemPackages;
  users.users.nearsyh.shell = pkgs.zsh;

  imports = [
    ../common.nix
    (import ../../home/ssh {
      prefix = "";
    })
  ];
}
