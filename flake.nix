{
  description = "Flake for development tooling for Keyboard labs.";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";

    # For the offline ISO,
    # use same version of Nickel as Fak uses.
    nickel = {
      url = "github:tweag/nickel/1.2.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    systems.url = "github:nix-systems/x86_64-linux";
  };

  outputs = {
    self,
    nickel,
    nixpkgs,
    flake-utils,
    nixos-generators,
    systems,
    ...
  }:
    flake-utils.lib.eachSystem (import systems) (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      bootloaders = import ./nix/pkgs/bootloaders {
        inherit pkgs;
      };
      qmk = pkgs.callPackage ./nix/pkgs/qmk {};
      pcb = pkgs.callPackage ./pcb {};
    in {
      checks = {
        firmware = pkgs.symlinkJoin {
          name = "keyboard-labs-firmware";
          paths = [
            self.packages.${system}.bootloader-circuitpython-jpconstantineau_pykey60
            self.packages.${system}.bootloader-stm32f103-stm32duino
            self.packages.${system}.bootloader-stm32f401-tinyuf2
            self.packages.${system}.bootloader-stm32f411-tinyuf2
            self.packages.${system}.qmk-bm40hsrgb-rgoulter
            self.packages.${system}.qmk-minif4_36-rev2021_5-blackpill_f401-rgoulter
            self.packages.${system}.qmk-pico42-rgoulter-basic
            self.packages.${system}.qmk-pico42-manna-harbour_miryoku
            self.packages.${system}.qmk-pico42-vial
            self.packages.${system}.qmk-pykey40-lite-rgoulter
            self.packages.${system}.qmk-pykey40-lite-rgoulter-pinkieoutercolumn
            self.packages.${system}.qmk-pykey40-lite-vial
            self.packages.${system}.qmk-x_2-rev2021_1-bluepill
            self.packages.${system}.qmk-x_2-rev2021_1-blackpill_f401
          ];
        };

        pcb = pkgs.symlinkJoin {
          name = "keyboard-labs-pcb";
          paths = [
            self.packages.${system}.pcb-keyboard-100x100-minif4-dual-rgb-reversible
            self.packages.${system}.pcb-keyboard-ch552-36-lhs
            self.packages.${system}.pcb-keyboard-ch552-36-rhs
            self.packages.${system}.pcb-keyboard-ch552-44
            self.packages.${system}.pcb-keyboard-ch552-48
            self.packages.${system}.pcb-keyboard-ch552-48-lpr
            self.packages.${system}.pcb-keyboard-pico42
            self.packages.${system}.pcb-keyboard-pykey40-hsrgb
            self.packages.${system}.pcb-keyboard-pykey40-lite
            self.packages.${system}.pcb-keyboard-x2-lumberjack-arm-hsrgb
            self.packages.${system}.pcb-keyboard-x2-lumberjack-arm
          ];
        };
      };

      packages = rec {
        bootloader-circuitpython-jpconstantineau_pykey60 = bootloaders.circuitpython.jpconstantineau_pykey60;
        bootloader-stm32f103-stm32duino = bootloaders.stm32duino.stm32f103;
        bootloader-stm32f401-tinyuf2 = bootloaders.tinyuf2.stm32f401;
        bootloader-stm32f411-tinyuf2 = bootloaders.tinyuf2.stm32f411;
        qmk-bm40hsrgb-rgoulter = qmk.bm40hsrgb-rgoulter;
        qmk-minif4_36-rev2021_5-blackpill_f401-rgoulter = qmk.minif4_36-rev2021_5-blackpill_f401-rgoulter;
        qmk-pico42-rgoulter-basic = qmk.pico42-rgoulter-basic;
        qmk-pico42-manna-harbour_miryoku = qmk.pico42-manna-harbour_miryoku;
        qmk-pico42-vial = qmk.pico42-vial;
        qmk-pykey40-lite-rgoulter = qmk.pykey40-lite-rgoulter;
        qmk-pykey40-lite-rgoulter-pinkieoutercolumn = qmk.pykey40-lite-rgoulter-pinkieoutercolumn;
        qmk-pykey40-lite-vial = qmk.pykey40-lite-vial;
        qmk-x_2-rev2021_1-bluepill = qmk.x_2-rev2021_1-bluepill;
        qmk-x_2-rev2021_1-blackpill_f401 = qmk.x_2-rev2021_1-blackpill_f401;

        pcb-keyboard-100x100-minif4-dual-rgb-reversible = pcb.keyboard-100x100-minif4-dual-rgb-reversible;
        pcb-keyboard-ch552-36-lhs = pcb.keyboard-ch552-36-lhs;
        pcb-keyboard-ch552-36-rhs = pcb.keyboard-ch552-36-rhs;
        pcb-keyboard-ch552-44 = pcb.keyboard-ch552-44;
        pcb-keyboard-ch552-48 = pcb.keyboard-ch552-48;
        pcb-keyboard-ch552-48-lpr = pcb.keyboard-ch552-48-lpr;
        pcb-keyboard-pico42 = pcb.keyboard-pico42;
        pcb-keyboard-pykey40-hsrgb = pcb.keyboard-pykey40-hsrgb;
        pcb-keyboard-pykey40-lite = pcb.keyboard-pykey40-lite;
        pcb-keyboard-x2-lumberjack-arm-hsrgb = pcb.keyboard-x2-lumberjack-arm-hsrgb;
        pcb-keyboard-x2-lumberjack-arm = pcb.keyboard-x2-lumberjack-arm;

        uf2conv = pkgs.callPackage ./nix/pkgs/uf2conv {};
        wchisp = pkgs.callPackage ./nix/pkgs/wchisp {};

        docker-kibot-kicad = import ./scripts/docker-kibot.nix {
          pkgs = pkgs;
          tag = "kicad-7";
        };
        gcc-arm-a-embedded = pkgs.callPackage ./nix/pkgs/gcc-arm-a-embedded {};
        kicad = pkgs.kicad;

        # An ISO for a live environment, with packages
        # for flashing fak firmware.
        offline-iso = nixos-generators.nixosGenerate {
          pkgs = import nixpkgs {
            inherit system;
            config = {allowUnfree = true;};
          };
          format = "iso";
          modules = [
            (
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
                      nickel.packages."x86_64-linux".default
                      nls
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
            )
          ];
        };
      };

      devShells = {
        circuitpython = import ./nix/shells/circuitpython/shell.nix {
          inherit pkgs;
        };

        pcb = import ./pcb/shell.nix {
          pkgs = pkgs;
          on-nixos = false;
        };

        pcb-nixos = import ./pcb/shell.nix {
          pkgs = pkgs;
          on-nixos = true;
        };
      };
    });
}
