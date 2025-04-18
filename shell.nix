{pkgs ? import <nixpgs> {}}: let
  shared = import ./shared-packages.nix {inherit pkgs;};
in
  pkgs.mkShell {
    name = "fabric-shell";
    packages = with pkgs; [
      ruff # Linter
      basedpyright # Language server

      # Required for Devshell
      gtk3
      gtk-layer-shell
      cairo
      gobject-introspection
      libdbusmenu-gtk3
      gdk-pixbuf
      gnome-bluetooth
      cinnamon-desktop
       matugen
       cava
       hyprsunset
       wlinhibit
       tesseract
       imagemagick
       swappy
       swww
       noto-fonts-emoji
      # Addional packages

      fabric-libgray
      fabric-libglace
      networkmanager
      playerctl
      librsvg

      (python3.withPackages (
        ps:
          with ps;
            [
              setuptools
              wheel
              build
              python-fabric
              # TESTING
              pyopengl
              numpy
              pygobject-stubs
              ijson
              pillow
              psutil
              requests
              setproctitle
              toml
              watchdog
            ]
            ++ shared.sharedPythonPackages
      ))
    ];

   GDK_PIXBUF_MODULE_FILE = "${pkgs.gdk-pixbuf}/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache";
   GDK_PIXBUF_MODULEDIR = "${pkgs.gdk-pixbuf}/lib/gdk-pixbuf-2.0/2.10.0/loaders";
    shellHook = ''
      # ${pkgs.python3.interpreter} ./nix/tt.py
      # cp -rn "${pkgs.python3Packages.pygobject-stubs}/lib/python3.12/site-packages/gi-stubs/repository/." "/home/$USER/.local/lib/python3.12/site-packages/gi/repository/"
      export GDK_PIXBUF_MODULEDIR=${pkgs.librsvg}/lib/gdk-pixbuf-2.0/2.10.0/loaders
    '';
  }
