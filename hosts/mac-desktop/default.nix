{ config, pkgs, lib, ... }:

{
  home.username = "nearsyh";
  home.homeDirectory = "/Users/nearsyh";
  home.stateVersion = "25.05";

  imports = [
    ../common.nix
    ../../home/ghostty.nix
    ../../home/aerospace.nix
    (import ../../home/ssh {
      prefix = "
Host *
  IdentityAgent \"~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock\"
";
    })
  ];
}
