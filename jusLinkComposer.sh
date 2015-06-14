#!/usr/bin/env bash

function showMenu
{
	menuSelection=$(kdialog --menu "Wähle Gerichtsentscheid aus:"	\
					BGE  "BGE"			\
					BGer "unpub. BGer"		\
					BVGer "BVGer"			\
			)
}



function showURL
{
        kdialog --msgbox "Auf den Entscheid kann mit folgender URL direkt zugegriffen werden:<br><br><a href='${decisionURL}'>${decisionURL}</a>"
#        kdialog --title "Urteils-URL" --passivepopup 'Auf den Entscheid kann mit folgender URL direkt zugegriffen werden:<br><br><a href="'${decisionURL}'">'${decisionURL}'</a>'
#        kdialog --title 'Urteils-URL' --passivepopup '<a href="http://kde.org/">www.kde.org</a>' 10
 

}



function composeBGE
{
	decision=$(kdialog --title "BGE Entscheid" --inputbox "Bitte BGE in folgendem Format eingeben: 140 III 41")
	decision="${decision// /-}"
	decisionURL="http://relevancy.bger.ch/cgi-bin/JumpCGI?id=BGE-${decision}"
	showURL
}



function composeBGer
{
	decision=$(kdialog --title "BGEer Verfahrensnummer" --inputbox "Bitte die Verfahrensnummer im folgenden Format eingeben: 4A_369/2007")
	date=$(kdialog --title "Entscheiddatum" --inputbox "Bitte das Datum des Entscheids im folgenden Format eingeben: 05.11.2007")
	decisionURL="http://jumpcgi.BGer.ch/cgi-bin/JumpCGI?id=${date}_${decision}"
	showURL
}



function composeBVGer
{
        decision=$(kdialog --title "BVGEer Verfahrensnummer" --inputbox "Bitte die Verfahrensnummer im folgenden Format eingeben: 2007/1")
        decisionURL="http://www.bvger.ch/publiws/pub/cache.jsf?displayName=${decision}"
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
	BVGer)
		composeBVGer;;
	*)
		noSelection ;;
esac
