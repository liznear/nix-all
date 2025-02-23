{ config, pkgs, lib, ... }:

{
  home.file.".config/ghostty/config".text = ''
font-family = "Mononoki Nerd Font Mono"
font-size = 16
theme = "catppuccin-latte"
keybind = global:cmd+grave_accent=toggle_quick_terminal
'';
}
