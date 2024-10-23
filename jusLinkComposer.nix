{stdenv, fetchgit, zenity }:
stdenv.mkDerivation {
  name = "jusLinkComposer-git";
# Switch between local testing and using proper git repo
  src = fetchgit {
    url = https://github.com/sjau/jusLinkComposer.git;
    rev = "f14b873db0051f5faafafe3b1d438157e621ef40";
    sha256 = "sha256-nx6Ap4Kd1bCcUKG5bqlQUxNMMnKRDwV9jI/NMiNor0c=";
  };
#  src = /home/hyper/Desktop/git-repos/jusLinkComposer;
  installPhase = ''
    mkdir -p $out/bin
    cp -n jusLinkComposer.sh $out/bin/
# NixOS does currently not provide Kate, so Zenity is chosen over Kate
    for i in $out/bin/*; do
      substituteInPlace $i \
        --replace zenity ${zenity}/bin/zenity
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
