#!/usr/bin/env bash

# ==========================================================
# LP INSTALLER v2
# LightingPlays Advanced Installer
# ==========================================================

VERSION="2.0"
REPO_RAW="https://raw.githubusercontent.com/node2ws-glitch/LPINSTALLER/main/lp-installer.sh"

# COLORS
CYAN='\033[1;36m'
GREEN='\033[1;32m'
PURPLE='\033[1;35m'
RED='\033[1;31m'
YELLOW='\033[1;33m'
WHITE='\033[1;37m'
GRAY='\033[0;37m'
NC='\033[0m'

# ----------------------------------------------------------
# Progress Bar
# ----------------------------------------------------------
progress_bar() {
echo
echo -e "${CYAN}Loading LP Installer...${NC}"
for i in {1..30}; do
printf "${GREEN}█${NC}"
sleep 0.02
done
echo
sleep 0.3
}

# ----------------------------------------------------------
# System Info
# ----------------------------------------------------------
system_info() {
CPU=$(top -bn1 | awk '/Cpu/ {print int($2+$4)}')
RAM=$(free | awk '/Mem:/ {printf("%.0f"), $3/$2 * 100}')
DISK=$(df -h / | awk 'NR==2 {print $5}')
HOST=$(hostname)
UPTIME=$(uptime -p | sed 's/up //')
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

echo -e "${YELLOW}LP INSTALLER v${VERSION}${NC}"
echo -e "${GRAY}LightingPlays Deployment System${NC}"
echo
}

# ----------------------------------------------------------
# Auto Update
# ----------------------------------------------------------
check_update() {

TMP_FILE="/tmp/lp_update.sh"

curl -fsSL "$REPO_RAW" -o "$TMP_FILE" 2>/dev/null

if [[ -s "$TMP_FILE" ]]; then
REMOTE_VER=$(grep VERSION "$TMP_FILE" | head -1 | cut -d '"' -f2)

if [[ "$REMOTE_VER" != "$VERSION" ]]; then
echo -e "${YELLOW}Updating installer to v$REMOTE_VER...${NC}"
sleep 1
bash "$TMP_FILE"
exit
fi
fi
}

# ----------------------------------------------------------
# Menu Options
# ----------------------------------------------------------
options=(
"Panels"
"VPS Panels"
"Dashboards"
"Virtualization"
"Server Utilities"
"Theme & BluePrints"
"VPS Edit LPRO"
"Exit"
)

# ----------------------------------------------------------
# Arrow Menu
# ----------------------------------------------------------
draw_menu() {

system_info
clear
logo

echo -e "${WHITE}Host:${NC} $HOST"
echo -e "${WHITE}Uptime:${NC} $UPTIME"
echo -e "${WHITE}CPU:${NC} ${GREEN}$CPU%${NC}  ${WHITE}RAM:${NC} ${GREEN}$RAM%${NC}  ${WHITE}Disk:${NC} ${GREEN}$DISK${NC}"
echo
echo -e "${CYAN}Use ↑ ↓ arrows and ENTER${NC}"
echo

for i in "${!options[@]}"; do
if [[ $i == $selected ]]; then
echo -e "${PURPLE}➤ ${options[$i]}${NC}"
else
echo "  ${options[$i]}"
fi
done
}

# ----------------------------------------------------------
# Execute Choice
# ----------------------------------------------------------
run_option() {

case $selected in

0)
bash <(curl -fsSL https://raw.githubusercontent.com/DreamHost2ws/ExtremLightingCode/main/panel/run.sh)
;;

1)
bash <(curl -fsSL https://raw.githubusercontent.com/DreamHost2ws/ExtremLightingCode/main/run.sh)
;;

2)
bash <(curl -fsSL https://raw.githubusercontent.com/DreamHost2ws/ExtremLightingCode/main/menu/System1.sh)
;;

3)
bash <(curl -fsSL https://raw.githubusercontent.com/DreamHost2ws/ExtremLightingCode/main/no-kvm/run.sh)
;;

4)
bash <(curl -fsSL https://raw.githubusercontent.com/DreamHost2ws/ExtremLightingCode/main/panel/pterodactyl/tools/run.sh)
;;

5)
bash <(curl -fsSL https://raw.githubusercontent.com/DreamHost2ws/ExtremLightingCode/main/panel/pterodactyl/chang/dev.sh)
;;

6)
bash <(curl -fsSL https://raw.githubusercontent.com/DreamHost2ws/ExtremLightingCode/main/vps-edit/run.sh)
;;

7)
echo -e "${RED}Exiting LP Installer...${NC}"
exit
;;

esac
}

# ----------------------------------------------------------
# Main
# ----------------------------------------------------------

progress_bar
check_update

selected=0

while true; do

draw_menu

read -rsn1 key

if [[ $key == $'\x1b' ]]; then
read -rsn2 key
fi

case $key in

"[A")
((selected--))
[[ $selected -lt 0 ]] && selected=$((${#options[@]} - 1))
;;

"[B")
((selected++))
[[ $selected -ge ${#options[@]} ]] && selected=0
;;

"")
run_option
;;

esac

done
