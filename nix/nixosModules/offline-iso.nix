# An ISO for a live environment, with packages
# for flashing fak firmware.
{
  config,
  pkgs,
  ...
}: {
  # Timeout the GRUB menu after 1 second.
  #
  # This ISO image is not intended for use as an installer ISO,
  # but as a convenience ISO so the user doesn't need to
  # install Linux.
  boot.loader.timeout = pkgs.lib.mkForce 1;

  # bug: 2023-09-22: man-cache generation fails if programs.fish.enable = true;
  documentation.man.generateCaches = false;

  environment = {
    gnome.excludePackages = [pkgs.gnome-tour];
    systemPackages = with pkgs;
      [
        eza
        firefox
        fd
        fish
        # meson c projects need a C compiler,
        # even though the meson.build doesn't use gcc.
        # (setting CC is not sufficient).
        gcc
        gnome-console
        gnome.nautilus
        helix
        neovim
        ripgrep
        (vscode-with-extensions.override {
          vscodeExtensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "vscode-nickel";
              publisher = "tweag";
              version = "0.3.0";
              sha256 = "sha256-OntQfxh51B3x92IE4y62bw8csBGukqUzmUJIr/rGioU=";
            }
          ];
        })
      ]
      ++ [
        sdcc
        nickel
        # issue with NLS meta/license
        # nls
        meson
        python311
        ninja
        jq
        wchisp
      ];
  };

  isoImage = {
    appendToMenuLabel = " Live System";
    isoBaseName = "keyboard-labs-offline";
    makeUsbBootable = true;
    prependToMenuLabel = "Run ";
  };

  programs = {
    fish.enable = true;

    starship.enable = true;
  };

  services = {
    # Don't need the core utities
    # (other than file manager, console)
    gnome.core-utilities.enable = false;

    # 2022-06-19: the check fails, for some reason
    logrotate.checkConfig = false;

    udev.packages = [
      pkgs.stlink
      (pkgs.writeTextFile {
        name = "wch.rules";
        destination = "/lib/udev/rules.d/50-wch.rules";
        text = ''
          # Allow wchisp to be used without sudo.
          SUBSYSTEMS=="usb", ATTRS{idVendor}=="4348", ATTRS{idProduct}=="55e0", TAG+="uaccess"
        '';
      })
    ];

    # Enable the X11 windowing system.
    xserver = {
      # Enable the GNOME 3 Desktop Environment.
      desktopManager.gnome = {
        enable = true;
        extraGSettingsOverrides = ''
          # Favorite apps in gnome-shell
          [org.gnome.shell]
          favorite-apps=['code.desktop', 'org.gnome.Console.desktop', 'org.gnome.Nautilus.desktop']
        '';
      };
      displayManager = {
        gdm.enable = true;
        autoLogin = {
          enable = true;
          user = "nixos";
        };
      };

      enable = true;

      excludePackages = [pkgs.xterm];

      videoDrivers = ["nvidia"];

      layout = "us";
    };
  };

  system = {
    # The default label is quite verbose.
    nixos.label = "KeyboardLabsEnviornment";

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    stateVersion = "23.11";
  };

  time.timeZone = "Asia/Jakarta";

  users.users.nixos = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    password = "nixos";
    shell = pkgs.fish;
    uid = 1000;
  };
}
