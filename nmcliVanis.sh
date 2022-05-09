#!/bin/bash

# Author Vanisul

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

trap ctrl_c INT

function ctrl_c(){
	echo -e "\n${yellowColour}[*]${endColour}${grayColour}Saliendo${endColour}"
	exit 0
}

function helpPanel(){
	echo -e "\n${yellowColour}[*]${endColour}${grayColour} Uso: ./nmcliVanis.sh${endColour}"
	echo -e "\t${purpleColour}n)${endColour}${yellowColour} Nombre de la tarjeta de red${endColour}"
	echo -e "\t${purpleColour}h)${endColour}${yellowColour} Mostrar este panel de ayuda${endColour}\n"
	exit 0
}

function startConnection(){
	#clear;
	echo -e "${yellowColour}[*] ${endColour}${grayColour}Comprobando Puntos de Acceso...${endColour}"
	sleep 1
	xterm -hold -e "nmcli dev wifi list" &
	nmcliwifilist_PID=$!

	echo -ne "\n${yellowColour}[*]${endColour}${grayColour} Nombre del punto de acceso: ${endColour}" && read acName
	echo -ne "\n${yellowColour}[*]${endColour}${grayColour} Contraseña: ${endColour}" && read acPasswd

	kill -9 $nmcliwifilist_PID
	wail $nmcliwifilist_PID 2>/dev/null
	bash -c "nmcli dev wifi connect ${acName} password '${acPasswd}'" 2>/dev/null
}


#_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_#
#											#
#	Main Function									#
#											#
#_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_#

if [ "$(id -u)" == "0" ]; then
	declare -i paramether_counter=0; declare -i comparator=3
	while getopts ":n:h:" arg; do
		case $arg in
			n) network_card=$OPTARG; let paramether_counter+=1 ;;
			h) helpPanel ;;
		esac
	done


	if [ echo "$paramether_counter" != 1 ]; then
		helpPanel
        else
		clear
		startConnection
        fi
else
        echo -e "\n${redColour}[*] No soy root${endColour}\n"
fi


