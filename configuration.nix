# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
  # imports =
  #   [ # Include the results of the hardware scan.
  #     ./hardware-configuration.nix
  #   ];
  # imports = [
    # include NixOS-WSL modules
  #   <nixos-wsl/modules>
  # ];

  wsl.enable = true;
  wsl.defaultUser = "kleha";

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  # services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  # services.displayManager.sddm = {
  #   enable = true;
	#   wayland.enable = true;
  # };
  # services.desktopManager.plasma6.enable = true;

	# Enable Budgie Desktop Environment

	# services.xserver.desktopManager.budgie.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound with pipewire.
  # hardware.pulseaudio.enable = false;
  # security.rtkit.enable = true;
  # services.pipewire = {
  #   enable = true;
  #   alsa.enable = true;
  #   alsa.support32Bit = true;
  #   pulse.enable = true;
  #   # If you want to use JACK applications, uncomment this
  #   jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

	# Enable Nvidia GPU support

# 	hardware.graphics = {
# 		enable = true;
# 	};

# 	services.xserver.videoDrivers = ["nvidia"];

# 	hardware.nvidia = {
# 		modesetting.enable = true;
# 		powerManagement.enable = false;
# 		powerManagement.finegrained = false;
# 		open = false;
# 		nvidiaSettings = true;
# 		package = config.boot.kernelPackages.nvidiaPackages.stable;
# 		prime = {
# 			sync.enable = true;
# 			intelBusId = "PCI:0:2:0";
# 			nvidiaBusId = "PCI:1:0:0";
# 		};
# 	};

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kleha = {
    isNormalUser = true;
    description = "WSL Default User";
    extraGroups = [ "wheel" "docker" ];
    packages = with pkgs; [
      typst
      satysfi
      obsidian
			tree-sitter
			ngspice
		];
    shell = pkgs.zsh;
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    deno
		gcc
		docker
		trashy
		usbutils
  ];

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
    zsh = {
      enable = true;
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable experimental features

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
    };
  };

  # virtualisation = {
# 		docker.enable = true;
 #  };


  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
