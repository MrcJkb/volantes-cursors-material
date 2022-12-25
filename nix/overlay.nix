final: prev:

let
  variants = [ "volantes_cursors" "volantes_light_cursors" ];

  volantes-cursors-material = final.stdenvNoCC.mkDerivation {

    pname = "volantes-cursors-material";
    version = "unstable-scm";

    src = ../.;

    outputs = variants ++ [ "out" ];

    outputsToInstall = [ ];

    nativeBuildInputs = with final; [
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

    installPhase = ''
      runHook preInstall
      for output in $outputs; do
        if [ "$output" != "out" ]; then
          local outputDir="''${!output}"
          local iconsDir="$outputDir/share/icons"
          echo "Installing $output to $iconsDir"
          mkdir -p "$iconsDir"
          local variant="$output"
          cp -r "./dist/$variant" "$iconsDir"
        fi
      done
      # Needed to prevent breakage
      mkdir -p "$out"
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
