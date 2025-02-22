{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nix-homebrew, nixpkgs, home-manager }:
  let
    username = "nearsyh";

    nixConfig = builtins.getEnv "NIX_CONFIG";

    homebrew_configurations = [
      nix-homebrew.darwinModules.nix-homebrew
      {
        nix-homebrew = {
          enable = true;
          enableRosetta = true;
          user = username;
        };
      }
    ];

    systemPackages = { sys, pkgs, ...}: [
      pkgs.vim
      pkgs.git
      pkgs.devbox
      pkgs.wget
      pkgs.just
    ] ++ ((import (./hosts + "/${sys}/extra_pkgs.nix")) pkgs);

    configuration = sys: { pkgs, ... }: {
      nixpkgs.config.allowUnfree = true;
      nixpkgs.config.allowBroken = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = systemPackages {
        sys=sys;
        pkgs=pkgs;
      };

      environment.variables = {
        EDITOR = "vim";
        VISUAL = "vim";
        NIX_CONFIG = nixConfig;
      };

      fonts.packages = [
        pkgs.nerd-fonts.mononoki
      ];

      users.users.nearsyh = {
        name = username;
        home = "/Users/nearsyh";
      };

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";
      nix.settings.trusted-users = ["root" "nearsyh"];
      nix.settings.substituters = [
        "https://mirrors.ustc.edu.cn/nix-channels/store"
      ];

      # Enable alternative shell support in nix-darwin.
      programs.zsh.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      system.defaults = {
        dock = {
          autohide = false;
          persistent-apps = [
            "/Applications/Arc.app"
            "/Applications/Ghostty.app"
            "${pkgs.vscode}/Applications/Visual Studio Code.app"
          ];
          persistent-others = [];
          show-recents = false;
        };
      };

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      homebrew = let
        extra = ((import (./hosts + "/${sys}/extra_brews.nix")) {});
      in
      {
        enable = true;
        onActivation.cleanup = "zap";
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
        brews = [] ++ extra.brews;
        casks = [] ++ extra.casks;
      };
    };

    build_darwin_system = sys: nix-darwin.lib.darwinSystem {
      modules = [
        # Install home brew
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            enableRosetta = true;
            user = username;
          };
        }

        # Configuration
        (configuration sys)

        # Home manager
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.nearsyh = import (./hosts + "/${sys}");
        }
      ];
    };

    build_linux_system = {sys, pkgs}: home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ((import ./hosts/linux-server) {
          systemPackages = systemPackages {
            sys=sys;
            pkgs=pkgs;
          };
        })
      ];
    };
  in
  {
    # Build darwin flake using:

    # $ darwin-rebuild build --flake .#mac-server
    darwinConfigurations."mac-server" = build_darwin_system "mac-server";

    # $ darwin-rebuild build --flake .#mac-desktop
    darwinConfigurations."mac-desktop" = build_darwin_system "mac-desktop";

    # $ darwin-rebuild build --flake .#mac-work
    darwinConfigurations."mac-work" = build_darwin_system "mac-work";

    # $ ./switch linux-server
    homeConfigurations."linux-server" = build_linux_system {
      sys = "linux-server";
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    };
  };
}
