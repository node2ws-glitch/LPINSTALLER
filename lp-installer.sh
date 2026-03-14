#!/bin/bash

# ===========================================================
# LP ALL IN ONE INSTALLER - LightingPlays
# Version: v1.0
# ===========================================================

# --- COLORS ---
B_CYAN='\033[1;38;5;51m'
B_PURPLE='\033[1;38;5;141m'
B_GREEN='\033[1;38;5;82m'
B_RED='\033[1;38;5;196m'
GOLD='\033[38;5;220m'
W='\033[1;37m'
G='\033[0;38;5;244m'
NC='\033[0m'

# --- LOADING ANIMATION ---
loading() {
clear
echo
echo -e "${B_CYAN}Starting LP Installer...${NC}"
for i in {1..20}; do
printf "${B_GREEN}▓${NC}"
sleep 0.05
done
echo
sleep 0.5
}

# --- SYSTEM METRICS ---
get_metrics() {
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{printf "%.0f", $2+$4}')
RAM=$(free | grep Mem | awk '{printf "%.0f", $3*100/$2}')
UPT=$(uptime -p | sed 's/up //')
DISK=$(df -h / | awk 'NR==2 {print $5}')
HOST=$(hostname)
}

# --- ASCII LOGO ---
logo() {

echo -e "${B_CYAN}"
echo "██╗     ██████╗ "
echo "██║     ██╔══██╗"
echo "██║     ██████╔╝"
echo "██║     ██╔═══╝ "
echo "███████╗██║     "
echo "╚══════╝╚═╝     "
echo -e "${NC}"

echo -e "${GOLD}LP ALL IN ONE INSTALLER${NC}"
echo -e "${G}Version v1.0 | LightingPlays${NC}"
echo
}

# --- UI ---
render_ui() {
clear
get_metrics

logo

echo -e "${W}Host:${NC} $HOST"
echo -e "${W}Uptime:${NC} $UPT"
echo -e "${W}CPU:${NC} $CPU%   ${W}RAM:${NC} $RAM%   ${W}Disk:${NC} $DISK"
echo

echo -e "${B_PURPLE}1.${NC} Panels                   ${B_PURPLE}5.${NC} Server Utilities"
echo -e "${B_PURPLE}2.${NC} VPS Panels               ${B_PURPLE}6.${NC} Theme & BluePrints"
echo -e "${B_PURPLE}3.${NC} Dashboards               ${B_PURPLE}7.${NC} VPS Edit LPRO"
echo -e "${B_PURPLE}4.${NC} Virtualization"
echo
echo -e "${B_RED}0.${NC} Exit"
echo
echo -ne "${B_CYAN}Select Option:${NC} "
}

# --- START LOADING ---
loading

# --- CONTROLLER ---
while true; do
render_ui
read -r opt

case $opt in

1)
bash <(curl -fsSL https://raw.githubusercontent.com/DreamHost2ws/ExtremLightingCode/main/panel/run.sh)
;;

2)
bash <(curl -fsSL https://raw.githubusercontent.com/DreamHost2ws/ExtremLightingCode/main/run.sh)
;;

3)
bash <(curl -fsSL https://raw.githubusercontent.com/DreamHost2ws/ExtremLightingCode/main/menu/System1.sh)
;;

4)
bash <(curl -fsSL https://raw.githubusercontent.com/DreamHost2ws/ExtremLightingCode/main/no-kvm/run.sh)
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
echo -e "${B_RED}Exiting LP Installer...${NC}"
sleep 1
exit
;;

*)
echo -e "${B_RED}Invalid Option!${NC}"
sleep 1
;;

esac

done
