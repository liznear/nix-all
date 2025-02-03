{ config, pkgs, lib, ... }:

{
  programs = {
    zsh = import ../../home/zsh.nix { inherit config pkgs lib; };
    starship = import ../../home/starship.nix { inherit config pkgs lib; };
  };
}
