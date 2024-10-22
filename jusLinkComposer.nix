{stdenv, fetchgit, gnome }:
stdenv.mkDerivation {
  name = "jusLinkComposer-git";
# Switch between local testing and using proper git repo
  src = fetchgit {
    url = https://github.com/sjau/jusLinkComposer.git;
    rev = "a0e277bbb5b98fca4120550a407f921670221439";
    sha256 = "1056j1yyw60iz0a6xnriwz1w7l3a3pg8llzpcv5xm5z4p2w3iiap";
  };
#  src = /home/hyper/Desktop/git-repos/jusLinkComposer;
  installPhase = ''
    mkdir -p $out/bin
    cp -n jusLinkComposer.sh $out/bin/
# NixOS does currently not provide Kate, so Zenity is chosen over Kate
    for i in $out/bin/*; do
      substituteInPlace $i \
        --replace zenity ${gnome.zenity}/bin/zenity
    done

    mkdir -p $out/share/applications/
    cp -n *.desktop $out/share/applications/
    for i in $out/share/applications/*.desktop; do
      substituteInPlace $i \
        --replace "jusLinkComposer.sh" "/run/current-system/sw/bin/jusLinkComposer.sh"
    done

    mkdir -p $out/share/icons/hicolor/48x48/apps
    cp -n *.png $out/share/icons/hicolor/48x48/apps/
  '';
}
