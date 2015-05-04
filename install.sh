#!/bin/bash

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi


# Vars
curPath=$(pwd)
installPath="/usr/bin/"
installDesktopPath="/usr/share/applications/"
installIconPath="/usr/share/icons/hicolor/22x22/apps/"
scriptName="jusLinkComposer"



function installFunc
{
	cp "${scriptName}" "${installPath}"
	chmod 0755 "${installPath}${scriptName}.sh"

	cp "${scriptName}.desktop" "${installDesktopPath}"
	chmod 0755 "${installDesktopPath}${scriptName}.desktop"

	cp "${scriptName}.png" "${installIconPath}"
	chmod 0755 "${installIconPath}${scriptName}.png"

}



function uninstallFunc
{
        rm "${installPath}${scriptName}.sh"
        rm "${installDesktopPath}${scriptName}.sh"
        rm "${installIconPath}${scriptName}.png"
}



function symlinkFunc
{
	ln -s "${curPath}/${scriptName}.sh" "${installPath}"
	chmod 0755 "${installPath}${scriptName}.sh"

	ln -s "${curPath}/${scriptName}.desktop" "${installDesktopPath}"
	chmod 0755 "${installDesktopPath}${scriptName}.desktop"

	ln -s "${curPath}/${scriptName}.png" "${installIconPath}"
	chmod 0755 "${installIconPath}${scriptName}.png"
}




case "${1}" in
install) echo "Installing ...."
	installFunc
        echo "... Installat complete."
	;;
uninstall) echo "Uninstalling ..."
	uninstallFunc
	echo "... Uninstall complete."
    ;;
symlink) echo  "Symlinking ..."
	symlinkFunc
	echo "... Symlink complete"
    ;;
*) echo "Use: run as root: ./install.sh PARAMETER"
   echo ""
   echo ""
   echo "Possible options for PARAMETER1"
   echo "symlink - instead of copying the files to their according location it just symlinks them; this is good for when you update the git repo --> this is RECOMMENDED"
   echo "install - this will copy the files to their according location"
   echo "uninstall - this will remove the files from their according location, however it'll leave the config files intact"
   ;;
esac
