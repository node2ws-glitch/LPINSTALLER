# ===================== MAIN MENU =====================
while true; do
clear

echo -e "${PURPLE}  ____  _                     _            _         _ ${NC}"
echo -e "${PURPLE} |  _ \| |_ ___ _ __ ___   __| | __ _  ___| |_ _   _| |${NC}"
echo -e "${PURPLE} | |_) | __/ _ \ '__/ _ \ / _\` |/ _\` |/ __| __| | | | |${NC}"
echo -e "${PURPLE} |  __/| ||  __/ | | (_) | (_| | (_| | (__| |_| |_| | |${NC}"
echo -e "${PURPLE} |_|    \__\___|_|  \___/ \__,_|\__,_|\___|\__|\__, |_|${NC}"
echo -e "${PURPLE}                                               |___/   ${NC}"
echo ""

echo -e "${CYAN} ┌────────────────────────────────────────────────────────────┐${NC}"

if [ -d "/var/www/pterodactyl" ]; then
echo -e "${CYAN} │${NC} ${BOLD}${WHITE}PANEL STATUS:${NC} ${GREEN}INSTALLED ✔${NC}                              ${CYAN}│${NC}"
else
echo -e "${CYAN} │${NC} ${BOLD}${WHITE}PANEL STATUS:${NC} ${RED}NOT INSTALLED ✘${NC}                          ${CYAN}│${NC}"
fi

echo -e "${CYAN} ├────────────────────────────────────────────────────────────┤${NC}"
echo -e "${CYAN} │${NC}                                                            ${CYAN}│${NC}"

echo -e "${CYAN} │${NC}  ${GREEN}[1]${NC} Install Panel        ${CYAN}[6]${NC} Install Wings             ${CYAN}│${NC}"
echo -e "${CYAN} │${NC}  ${GREEN}[2]${NC} Create User          ${CYAN}[7]${NC} SSL Configuration        ${CYAN}│${NC}"
echo -e "${CYAN} │${NC}  ${YELLOW}[3]${NC} Update Panel         ${CYAN}[8]${NC} Auto Setup (Panel+Wings) ${CYAN}│${NC}"
echo -e "${CYAN} │${NC}  ${YELLOW}[4]${NC} Domain / SSL         ${CYAN}[9]${NC} Panel Manager           ${CYAN}│${NC}"
echo -e "${CYAN} │${NC}  ${RED}[5]${NC} Uninstall Panel       ${CYAN}[10]${NC} Database Manager        ${CYAN}│${NC}"

echo -e "${CYAN} │${NC}                                                            ${CYAN}│${NC}"
echo -e "${CYAN} │${NC}  ${WHITE}[0] Exit System${NC}                                           ${CYAN}│${NC}"

echo -e "${CYAN} └────────────────────────────────────────────────────────────┘${NC}"
echo ""
echo -ne "${BOLD}${WHITE}  root@ptero:~# ${NC}"
read choice

case $choice in

1) install_ptero ;;

2) create_user ;;

3) update_panel ;;

4) bash <(curl -fsSL https://raw.githubusercontent.com/DreamHost2ws/ExtremLightingCode/main/panel/pterodactyl/ssl.sh) ;;

5) uninstall_ptero ;;

6)
bash <(curl -fsSL https://raw.githubusercontent.com/DreamHost2ws/ExtremLightingCode/main/panel/wings/run.sh)
;;

7)
bash <(curl -fsSL https://raw.githubusercontent.com/DreamHost2ws/ExtremLightingCode/main/panel/pterodactyl/ssl.sh)
;;

8)
echo "Running Auto Setup..."
bash <(curl -fsSL https://pterodactyl-installer.se)
;;

9)
bash <(curl -fsSL https://raw.githubusercontent.com/DreamHost2ws/ExtremLightingCode/main/panel/pterodactyl/tools/run.sh)
;;

10)
echo "Opening Database Manager..."
mysql -u root -p
;;

0)
clear
exit
;;

*)
echo -e "${RED}Invalid option selected...${NC}"
sleep 1
;;

esac
done
