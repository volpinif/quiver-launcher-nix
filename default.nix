{
  lib,
  appimageTools,
  fetchurl,
}:

let
  pname = "quiver-launcher";
  version = "3.5.0";

  src = fetchurl {
    url = "https://github.com/tgeorgiadis/quiver-launcher/releases/download/v${version}/QuiverLauncher-linux-x64.AppImage";
    hash = "sha256-jf5KobDajoXfIpzxd7ZU1Z6qh5ZdEh2awGK1TSobw9A";
  };

  appimageContents = appimageTools.extract {
    inherit pname version src;
  };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraPkgs = pkgs: [ pkgs.icu ];

  extraInstallCommands = ''
    mkdir -p $out/share/applications

    desktopFile="${appimageContents}/QuiverLauncher.desktop"
    if [ -f "$desktopFile" ]; then
      install -m 444 "$desktopFile" \
        $out/share/applications/quiver-launcher.desktop
      sed -i 's|^Exec=.*|Exec=quiver-launcher %U|' \
        $out/share/applications/quiver-launcher.desktop
    else
      cat > $out/share/applications/quiver-launcher.desktop <<'EOF'
[Desktop Entry]
Type=Application
Name=Quiver Launcher
Exec=quiver-launcher %U
Terminal=false
Categories=Utility;
EOF
    fi
  '';

  meta = {
    description = "Quiver Launcher";
    homepage = "https://github.com/tgeorgiadis/quiver-launcher";
    platforms = [ "x86_64-linux" ];
    mainProgram = pname;
  };
}

