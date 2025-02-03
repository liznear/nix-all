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

    configuration = sys: { pkgs, ... }: {
      nixpkgs.config.allowUnfree = true;
      nixpkgs.config.allowBroken = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = [
        pkgs.vim
        pkgs.git
      ] ++ ((import (./hosts + "/${sys}/extra_pkgs.nix")) pkgs);

      fonts.packages = [
        pkgs.nerd-fonts.mononoki
      ];

      users.users.nearsyh = {
        name = username;
        home = "/Users/nearsyh";
      };

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      programs.zsh.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

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

    build_system = sys: nix-darwin.lib.darwinSystem {
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
  in
  {
    # Build darwin flake using:

    # $ darwin-rebuild build --flake .#mac-server
    darwinConfigurations."mac-server" = build_system "mac-server";

    # $ darwin-rebuild build --flake .#mac-desktop
    darwinConfigurations."mac-desktop" = build_system "mac-desktop";

    # $ darwin-rebuild build --flake .#mac-work
    darwinConfigurations."mac-work" = build_system "mac-work";
  };
}
