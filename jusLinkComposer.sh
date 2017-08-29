#!/usr/bin/env bash

chkCancelButton () {
    if [[ "${1}" -eq 1 ]]; then
        guiError "Abbrechen Taste wurde gedrückt."
        exit 1;
    fi
}


guiError () {
    if type kdialog &>/dev/null; then
        kdialog --error "${1}"
    else
        zenity --error --text="${1}"
    fi
    exit 1;
}


guiInput () {
    local output
    if type kdialog &>/dev/null; then
        output=$(kdialog --title "${1}" --inputbox "${2}" "${3}")
        chkCancelButton "${?}"
    else
        output=$(zenity --entry --title "${1}" --text="${2}" --entry-text="${3}")
        chkCancelButton "${?}"
    fi
    printf "%s" "${output}"
}

guiInfo () {
    if type kdialog &>/dev/null; then
        kdialog --msgbox "${1}"
    else
        zenity --info --text="${1}"
    fi
}

showMenu () {
    if type kdialog &>/dev/null; then
        menuSelection=$(kdialog --checklist "Wähle Gerichtsentscheid aus:" BGE "BGE" off BGer "unpub. BGer" off BVGer "BVGer" off)
        chkCancelButton "${?}"
    else
        menuSelection=$(zenity --list --radiolist --text "Wähle Gerichtsentscheid aus:" --hide-header --column "1" --column "2" FALSE "BGE" FALSE "unpub. BGer" FALSE "BVGer")
        chkCancelButton "${?}"
        case "${menuSelection}" in
            "unpub. BGer")  menuSelection="BGer" ;;
        esac
    fi
}


showURL () {
        guiInfo "Auf den Entscheid kann mit folgender URL direkt zugegriffen werden:

        <a href='${decisionURL}'>${decisionURL}</a>"
}


composeBGE () {
	decision=$(guiInput "BGE Entscheid" "Bitte BGE in folgendem Format eingeben: 140 III 41")
	decision="${decision// /-}"
	decisionURL="http://relevancy.bger.ch/cgi-bin/JumpCGI?id=BGE-${decision}"
	showURL
}


composeBGer () {
	decision=$(guiInput "BGEer Verfahrensnummer" "Bitte die Verfahrensnummer im folgenden Format eingeben: 4A_369/2007")
	date=$(guiInput "Entscheiddatum" "Bitte das Datum des Entscheids im folgenden Format eingeben: 05.11.2007")
	decisionURL="http://jumpcgi.BGer.ch/cgi-bin/JumpCGI?id=${date}_${decision}"
	showURL
}


composeBVGer () {
        decision=$(guiInput "BVGEer Verfahrensnummer" "Bitte die Verfahrensnummer im folgenden Format eingeben: 2007/1")
        decisionURL="http://www.bvger.ch/publiws/pub/cache.jsf?displayName=${decision}"
        showURL
}


noSelection () {
	guiInfo "Es wurde keine Auswahl getätigt.\n Bitte nochmals versuchen."
}


# Show Menu Dialog
showMenu


case "${menuSelection}" in
	"BGE")     composeBGE ;;
	"BGer")    composeBGer ;;
	"BVGer")   composeBVGer;;
	*)         noSelection ;;
esac
