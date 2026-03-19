#!/bin/bash

# ==========================================================
# LP INSTALLER
# LightingPlays Official Installer
# Version: v1.0
# ==========================================================

# COLORS
CYAN='\033[1;36m'
PURPLE='\033[1;35m'
GREEN='\033[1;32m'
RED='\033[1;31m'
YELLOW='\033[1;33m'
WHITE='\033[1;37m'
GRAY='\033[0;37m'
NC='\033[0m'

# ----------------------------------------------------------
# Loading Animation
# ----------------------------------------------------------
loading() {
clear
echo
echo -e "${CYAN}Initializing LP Installer...${NC}"
for i in {1..30}; do
printf "${GREEN}█${NC}"
sleep 0.03
done
echo
sleep 0.4
}

# ----------------------------------------------------------
# System Info
# ----------------------------------------------------------
system_info() {

CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print int($2 + $4)}')
RAM=$(free | awk '/Mem:/ {printf("%.0f"), $3/$2 * 100}')
DISK=$(df -h / | awk 'NR==2 {print $5}')
UPTIME=$(uptime -p | sed 's/up //')
HOST=$(hostname)

}

# ----------------------------------------------------------
# Logo
# ----------------------------------------------------------
logo() {

echo -e "${CYAN}"
echo "██╗     ██████╗ "
echo "██║     ██╔══██╗"
echo "██║     ██████╔╝"
echo "██║     ██╔═══╝ "
echo "███████╗██║     "
echo "╚══════╝╚═╝     "
echo -e "${NC}"

echo -e "${YELLOW}LP ALL-IN-ONE INSTALLER${NC}"
echo -e "${GRAY}LightingPlays Deployment Toolkit${NC}"
echo -e "${GRAY}Version v1.0${NC}"
echo
}

# ----------------------------------------------------------
# Menu UI
# ----------------------------------------------------------
menu() {

clear
system_info
logo

echo -e "${WHITE}Host:${NC} $HOST"
echo -e "${WHITE}Uptime:${NC} $UPTIME"
echo -e "${WHITE}CPU:${NC} ${GREEN}$CPU%${NC}   ${WHITE}RAM:${NC} ${GREEN}$RAM%${NC}   ${WHITE}Disk:${NC} ${GREEN}$DISK${NC}"
echo

echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${PURPLE}1.${NC} Panels                ${PURPLE}5.${NC} Server Utilities"
echo -e "${PURPLE}2.${NC} VPS Panels            ${PURPLE}6.${NC} Theme & BluePrints"
echo -e "${PURPLE}3.${NC} Dashboards            ${PURPLE}7.${NC} VPS Edit LPRO"
echo -e "${PURPLE}4.${NC} Virtualization"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo
echo -e "${RED}0.${NC} Exit"
echo
echo -ne "${CYAN}Select Option ➜ ${NC}"

}

# ----------------------------------------------------------
# Start Loading
# ----------------------------------------------------------
loading

# ----------------------------------------------------------
# Controller
# ----------------------------------------------------------
while true; do

menu
read -r opt

case $opt in

1)
bash <(curl -fsSL https://raw.githubusercontent.com/node2ws-glitch/LPINSTALLER/main/panels.sh)
;;

2)
bash <(curl -fsSL https://raw.githubusercontent.com/node2ws-glitch/LPINSTALLER/main/vpspanes.sh)
;;

3)
soon
;;

4)
bash <(curl -fsSL https://raw.githubusercontent.com/node2ws-glitch/LPINSTALLER/main/vm.sh)
;;

5)
bash <(curl -fsSL https://raw.githubusercontent.com/DreamHost2ws/ExtremLightingCode/main/panel/pterodactyl/tools/run.sh)
;;

6)
bash <(curl -fsSL https://raw.githubusercontent.com/DreamHost2ws/ExtremLightingCode/main/panel/pterodactyl/chang/dev.sh)
;;

7)
bash <(curl -fsSL https://raw.githubusercontent.com/DreamHost2ws/ExtremLightingCode/main/vps-edit/run.sh)
;;

0)
echo
echo -e "${RED}Closing LP Installer...${NC}"
sleep 1
exit
;;

*)
echo -e "${RED}Invalid Option!${NC}"
sleep 1
;;

esac

done
