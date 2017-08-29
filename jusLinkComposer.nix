{stdenv, fetchgit, gnome3 }:
stdenv.mkDerivation {
  name = "jusLinkComposer-git";
# Switch between local testing and using proper git repo
  src = fetchgit {
    url = https://github.com/sjau/jusLinkComposer.git;
    rev = "6b855ec7565f11c8b9e9f6435f5722f74361cd14";
    sha256 = "12lzy9xwraxjdaapkwh208sr4b8nqw5pca3ajl1gvzc6vnm15hwh";
  };
  src = /home/hyper/Desktop/git-repos/jusLinkComposer;
  installPhase = ''
    mkdir -p $out/bin
    cp -n *.sh $out/bin/
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