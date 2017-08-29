{stdenv, fetchgit, gnome3 }:
stdenv.mkDerivation {
  name = "jusLinkComposer-git";
# Switch between local testing and using proper git repo
  src = fetchgit {
    url = https://github.com/sjau/jusLinkComposer.git;
    rev = "edcecfe407df6722a32d245a10163a3a49869f7c";
    sha256 = "1iwfyqwzdkj55b517bajjh9yc2ym0gm8zkllj080sxxpzrnwlzxn";
  };
#  src = /home/hyper/Desktop/git-repos/jusLinkComposer;
  installPhase = ''
    mkdir -p $out/bin
    cp -n jusLinkComposer.sh $out/bin/
# NixOS does currently not provide Kate, so Zenity is chosen over Kate
    for i in $out/bin/*; do
      substituteInPlace $i \
        --replace zenity ${gnome3.zenity}/bin/zenity
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
