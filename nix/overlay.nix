final: prev:

let
  volantes-cursors-material = final.stdenvNoCC.mkDerivation {

    pname = "volantes-cursors-material";
    version = "unstable-scm";

    src = ../.;

    outputsToInstall = [ ];

    nativeBuildInputs = with final; [
      gtk3
      inkscape
      xorg.xcursorgen
    ];

    postPatch = ''
      patchShebangs ./build.sh
    '';

    # Make fontconfig stop warning about being unable to load config
    FONTCONFIG_FILE = final.makeFontsConf { fontDirectories = [ ]; };

    # Make inkscape stop warning about being unable to create profile directory
    preBuild = ''
      export HOME="$NIX_BUILD_ROOT"
    '';

    postFixup = ''
      gtk-update-icon-cache $out/share/icons/volantes_cursors
      gtk-update-icon-cache $out/share/icons/volantes_light_cursors
    '';

    installPhase = ''
      runHook preInstall
      local iconsDir="$out/share/icons"
      mkdir -p "$iconsDir"
      ls "./dist"
      cp -r "./dist/volantes_cursors" "$iconsDir"
      cp -r "./dist/volantes_light_cursors" "$iconsDir"
      runHook postInstall
    '';

    meta = {
      description = "Volantes cursor theme with a Material colour palette.";
      homepage = "https://github.com/MrcJkb/volantes-cursors-material";
      license = final.lib.licenses.gpl2;
      platforms = final.lib.platforms.linux;
    };
  };

in
{

  inherit volantes-cursors-material;

}
