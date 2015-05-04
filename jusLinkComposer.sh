#!/usr/bin/env bash

function showMenu
{
	menuSelection=$(kdialog --menu "Wähle Gerichtsentscheid aus:"	\
					BGE  "BGE"		\
					BGer "unpub. BGer"	\
			)
}



function showURL
{
        kdialog --msgbox "Auf den Entscheid kann mit folgender URL direkt zugegriffen werden\n\n ${decisionURL}"
}



function composeBGE
{
	decision=$(kdialog --title "BGE Entscheid" --inputbox "Bitte BGE in folgendem Format eingeben: 140 III 41")
	decision="${decision// /-}"
	decisionURL="http://relevancy.bger.ch/cgi-bin/JumpCGI?id=BGE-${decision}&lang=de&zoom=&system="
	showURL
}



function composeBGer
{
	decision=$(kdialog --title "BGEer Verfahrensnummer" --inputbox "Bitte die Verfahrensnummer im folgenden Format eingeben: 4A_369/2007")
	date=$(kdialog --title "Entscheiddatum" --inputbox "Bitte das Datum des Entscheids im folgenden Format eingeben: 05.11.2007")
	decisionURL="http://jumpcgi.BGer.ch/cgi-bin/JumpCGI?id=${date}_${decision}"
	showURL
}



function noSelection
{
	kdialog --msgbox "Es wurde keine Auswahl getätigt.\n Bitte nochmals versuchen."
}

# Show Menu Dialog
showMenu

case "${menuSelection}" in
	BGE)
		composeBGE ;;
	BGer)
		composeBGer ;;
	*)
		noSelection ;;
esac
