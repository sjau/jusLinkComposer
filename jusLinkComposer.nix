{stdenv, fetchgit, gnome3 }:
stdenv.mkDerivation {
  name = "jusLinkComposer-git";
# Switch between local testing and using proper git repo
  src = fetchgit {
    url = https://github.com/sjau/jusLinkComposer.git;
    rev = "d5d95a7fad9cb8b3eab6cf6f7208aee361464140";
    sha256 = "1kiylwy2dr9lm1zi7ishsdxzb1243dm1v1dydi7ia7hyh6db0gg2";
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
    
    mkdir -p $out/share/icons/oxygen/base/22x22/apps/
    cp -n *.png $out/share/icons/oxygen/base/22x22/apps/
  '';
}
