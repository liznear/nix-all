{ config, pkgs, lib, ... }:

{
    home.file.".config/borders/bordersrc".text = ''
#!/usr/bin/env bash

borders active_color=0xff65ba94 inactive_color=0xff494d64 width=10.0
'';
}
