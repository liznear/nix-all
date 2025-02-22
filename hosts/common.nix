{ config, pkgs, lib, ... }:

{
  # Manage itself.
  programs.home-manager = {
    enable = true;
  };

  # Enable alternative shell support in nix-darwin.
  programs.zsh.enable = true;

  imports = [
    ../home/zsh.nix
    ../home/starship.nix
    ../home/tools.nix
  ];
}
