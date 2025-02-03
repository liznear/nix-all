{ config, pkgs, lib, ... }:

{
  home.username = "nearsyh";
  home.homeDirectory = "/Users/nearsyh";
  home.stateVersion = "25.05";

  programs = {
    zsh = import ../../../home/zsh.nix { inherit config pkgs lib; };
    starship = import ../../../home/starship.nix { inherit config pkgs lib; };
  };
}
