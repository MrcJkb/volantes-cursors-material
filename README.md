# Volantes Cursors [Material]

[![Nix build](https://github.com/MrcJkb/volantes-cursors-material/actions/workflows/nix-build.yml/badge.svg)](https://github.com/MrcJkb/volantes-cursors-material/actions/workflows/nix-build.yml)

Fork of [Volantres Cursors](https://github.com/varlesh/volantes-cursors) with the [Material colour palette](https://material-theme.com/).

![screenshot](https://user-images.githubusercontent.com/12857160/209580520-ff5de329-d3b8-485b-9552-f389f7ccd76c.png)

## Variants

| Cursor theme                     | Material variant  |
|----------------------------------|-------------------|
| Volantes Material Dark           | Material Darker   |
| Volantes Material Light          | Material Lighter  |

## Installation

### NixOS

This cursor theme has been packaged as a [Nix flake](https://nixos.wiki/wiki/Flakes).

The following snippet should contain all configurations necessary for use with a desktop environment
like GNOME, KDE, ...

```nix
# flake.nix
{
  inputs = {
    # nixpkgs.url = ...
    # home-manager.url = ...
    cursor-theme.url = "github:MrcJkb/volantes-cursors-material";
  };

  outputs = { self, nixpkgs, home-manager, cursor-theme, ... }@attrs:
  {
    my-nixos-system = nixpkgs.lib.nixosSystem {
      # ...
      modules = [
        ({ config, pkgs, ... }: { nixpkgs.overlays = [
            cursor-theme.overlay
          ];
        })
        home-manager.nixosModule
      ];
      # ...
      { pkgs, ... }: {
        home-manager.users."<username>" = {
          gtk.cursorTheme = {
            name = "Volantes Material Dark";
            package = pkgs.volantes-cursors-material;
          };
        };
      };
    };
  };
}
```

Without a DE (or if the above is not enough),
it may be necessary to add the following to the NixOS config:

```nix
home-manager.users."<username>" = {
  home = {
    file.".icons/default".source = "${pkgs.volantes-cursors-material}/share/icons/volantes_cursors";
  };
};

environment.sessionVariables = {
  # Workaround for cursor theme not being recognized
  XCURSOR_PATH = [
    "${config.system.path}/share/icons"
    "$HOME/.icons"
    "$HOME/.nix-profile/share/icons/"
  ];
  GTK_DATA_PREFIX = [
    "${config.system.path}"
  ];
};
```

A reboot may be necessary for the changes to take effect.

### Manual Install

1. Install dependencies:

    - git
    - make
    - inkscape
    - xcursorgen

2. Run the following commands as normal user:

    ```console
    git clone git@github.com:MrcJkb/volantes-cursors-material.git
    cd volantes-cursors-material
    make build
    sudo make install
    ```

3. Choose a theme in the Settings or in the Tweaks tool.



