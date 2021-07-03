#!/bin/bash

trap ctrl_c INT


# Result
mkdir result

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"


# functions
ctrl_c(){
	rm -rf result
    echo "Saliendo..."
    exit 0
}

# Utilities to use
dependencies(){

sudo apt install whatweb >/dev/null 2>&1 && sudo apt install dnsenum >/dev/null 2>&1 && sudo apt install fierce >/dev/null 2>&1 && sudo apt install theharvester >/dev/null 2>&1 

}

# This serves to know the technologies of a website

what(){

read -p "Insert url: " url 
echo -e "\n${redColour}Used technology:${endColour}"
echo ""
whatweb $url | tee result/Technology.txt
sleep 2
clear
}


# https://github.com/laramies/theHarvester
# This allows me through linkedin to obtain the workers of a company

thr(){

read -p "Insert url: " url
read -p "Insert result: " result
echo -e "\n${redColour}[${endColour}${yellowColour}*${endColour}${redColour}]${endColour}${redColour}Removing employees:${endColour}"
	theHarvester -d $url -l $result -b linkedin | tee result/employees.txt
sleep 10
clear
}


# https://github.com/sherlock-project/sherlock
# This allows me to discover social networks

people(){
	read -p "Insert user: " user
	echo -e "\n${redColour}[${endColour}${yellowColour}*${endColour}${redColour}]${endColour} ${redColour}Install sherlock in /opt${endColour}"
	sleep 5
	echo -e "\n${redColour}[${endColour}${yellowColour}*${endColour}${redColour}]${endColour} ${redColour}Taking social networks out of ${yellowColour}$user${endColour}:${endColour}"
	sleep 1
	python3 /opt/sherlock/sherlock $user --output result/social_networks.txt
sleep 2
clear
}


# Try to find the dns of a domain
dns(){
read -p "Insert url: " url
	dnsenum --enum $url | tee result/dns.txt
sleep 2
clear
}

# Try to collect the most information about a domain
complete_recon(){
	read -p "Insert domain: " host
	fierce --domain $host 
sleep 2
clear
}


# try to download all available metadata about a domain
metadata(){
read -p "Insert domain: " domain
	metagoofil -d $domain -t doc,pdf -l 200 -n 50 -o result/metadata
sleep 2
clear
}


# Banner

echo "										"
sleep 0.05
echo " ██████╗ ███████╗██╗███╗   ██╗████████╗"
sleep 0.05
echo "██╔═══██╗██╔════╝██║████╗  ██║╚══██╔══╝"
sleep 0.05
echo "██║   ██║███████╗██║██╔██╗ ██║   ██║   "
sleep 0.05
echo "██║   ██║╚════██║██║██║╚██╗██║   ██║   "
sleep 0.05
echo "╚██████╔╝███████║██║██║ ╚████║   ██║   "
sleep 0.05
echo " ╚═════╝ ╚══════╝╚═╝╚═╝  ╚═══╝   ╚═╝   "
sleep 0.05
echo "----------------B3nj1------------------"
sleep 0.05                                       

echo -e "\n${redColour}Install sherlock first if you don't have it, cancel Ctrl-c${endColour}"
echo -e "\n${redColour}https://github.com/sherlock-project/sherlock${endColour}"
sleep 3
echo -e "\n${redColour}[*] Installing dependencies...${endColour}" 
dependencies
echo -e "\n${redColour}[*] Ending...${endColour}" 
sleep 1
clear

menu(){

echo -ne "
${redColour}*-*-*-*-*-*-*-*-*-*-${endColour}
${redColour}[${endColour}${yellowColour}1${endColour}${redColour}]${endColour} ${redColour}Technology${endColour}
${redColour}[${endColour}${yellowColour}2${endColour}${redColour}]${endColour} ${redColour}DNS Enum${endColour}
${redColour}[${endColour}${yellowColour}3${endColour}${redColour}]${endColour} ${redColour}Metadata${endColour}
${redColour}[${endColour}${yellowColour}4${endColour}${redColour}]${endColour} ${redColour}People${endColour}
${redColour}[${endColour}${yellowColour}5${endColour}${redColour}]${endColour} ${redColour}Employees${endColour}
${redColour}[${endColour}${yellowColour}6${endColour}${redColour}]${endColour} ${redColour}Recon${endColour}
${redColour}[${endColour}${yellowColour}7${endColour}${redColour}]${endColour} ${redColour}Delete All files${endColour}
${redColour}[${endColour}${yellowColour}8${endColour}${redColour}]${endColour} ${redColour}Exit${endColour}"
printf "\n${redColour}Choose an option: ${endColour}";
read option
echo ""
clear

case $option in
  	1) what ; menu ;;
  	2) dns ; menu ;;
	3) metadata ; menu ;;
  	4) people ; menu ;;
  	5) thr ; menu ;;
  	6) complete_recon ; menu ;;
  	7) ctrl_c ; menu ;;
  	8) exit 0;;
esac
}

menu

