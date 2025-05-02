{ config, pkgs, lib, ... }:

{
    home.file.".config/aerospace/aerospace.toml".text = ''
borders active_color=0xff65ba94 inactive_color=0xff494d64 width=12.0
'';
}
