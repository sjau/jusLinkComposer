#!/bin/bash

if [ "$(id -u)" != "0" ]; then
   printf "%s\n" "This script must be run as root" 1>&2
   exit 1
fi


# Vars
curPath=$(pwd)
installPath="/usr/bin/"
installDesktopPath="/usr/share/applications/"
installIconPath="/usr/share/icons/oxygen/22x22/apps/"
scriptName="jusLinkComposer"



installFunc () {
	cp "${scriptName}.sh" "${installPath}"
	chmod 0755 "${installPath}${scriptName}.sh"

	cp "${scriptName}.desktop" "${installDesktopPath}"
	chmod 0755 "${installDesktopPath}${scriptName}.desktop"

	cp "${scriptName}.png" "${installIconPath}"
	chmod 0755 "${installIconPath}${scriptName}.png"
}



uninstallFunc () {
        rm "${installPath}${scriptName}.sh"
        rm "${installDesktopPath}${scriptName}.desktop"
        rm "${installIconPath}${scriptName}.png"
}



symlinkFunc () {
	ln -s "${curPath}/${scriptName}.sh" "${installPath}"
	chmod 0755 "${installPath}${scriptName}.sh"

	ln -s "${curPath}/${scriptName}.desktop" "${installDesktopPath}"
	chmod 0755 "${installDesktopPath}${scriptName}.desktop"

	ln -s "${curPath}/${scriptName}.png" "${installIconPath}"
	chmod 0755 "${installIconPath}${scriptName}.png"
}




case "${1}" in
    install) printf "%s\n" "Installing ...."
        installFunc
        printf "%s\n" "... Installat complete."
        ;;
    uninstall) printf "%s\n" "Uninstalling ..."
        uninstallFunc
        printf "%s\n" "... Uninstall complete."
        ;;
    symlink) printf "%s\n" "Symlinking ..."
        symlinkFunc
        printf "%s\n" "... Symlink complete"
        ;;
    *)  printf "%s\n" "Use: run as root: ./install.sh PARAMETER"
        printf "%s\n" ""
        printf "%s\n" ""
        printf "%s\n" "Possible options for PARAMETER1"
        printf "%s\n" "symlink - instead of copying the files to their according location it just symlinks them; this is good for when you update the git repo --> this is RECOMMENDED"
        printf "%s\n" "install - this will copy the files to their according location"
        printf "%s\n" "uninstall - this will remove the files from their according location, however it'll leave the config files intact"
        ;;
esac
