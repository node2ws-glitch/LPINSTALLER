#!/bin/bash
# ===========================================================
# LP SYSTEM MANAGER - LIGHTINGPLAYS EDITION (v1.0)
# LP Virtualization & Node Control
# ===========================================================

hostnamectl set-hostname LP-NODE 2>/dev/null

# --- COLORS ---
B_BLUE='\033[1;38;5;33m'
B_CYAN='\033[1;38;5;51m'
B_PURPLE='\033[1;38;5;141m'
B_GREEN='\033[1;38;5;82m'
B_RED='\033[1;38;5;196m'
GOLD='\033[38;5;220m'
W='\033[1;38;5;255m'
G='\033[0;38;5;244m'
BG_SHADE='\033[48;5;236m'
NC='\033[0m'

pause() {
echo
echo -ne " ${G}➜${NC} ${W}Press Enter to return...${NC}"
read _
}

# --- SYSTEM METRICS ---
get_metrics() {

CPU=$(top -bn1 | grep "Cpu(s)" | awk '{printf "%.0f", $2+$4}')
RAM=$(free | grep Mem | awk '{printf "%.0f", $3*100/$2}')
UPT=$(uptime -p | sed 's/up //')
DISK=$(df -h / | awk 'NR==2 {print $5}')
CURRENT_HOST=$(hostname)

KVM_STATUS=$([ -e /dev/kvm ] && echo -e "${B_GREEN}ON${NC}" || echo -e "${B_RED}OFF${NC}")

if command -v docker &> /dev/null; then
DOKO_RUNNING=$(docker ps -q | wc -l)
DOKO_STATUS="${B_GREEN}${DOKO_RUNNING}${NC}"
else
DOKO_STATUS="${B_RED}N/A${NC}"
fi

}

# --- DOCKER TABLE ---
render_doko_grid() {

if ! command -v docker &> /dev/null; then
return
fi

echo -e " ${B_CYAN}🐳 ACTIVE DOCKER NODES${NC}"
echo -e " ${G}┌──────────┬──────────┬──────────────┬──────────────┬────────────┐${NC}"
echo -e " ${G}│${NC} ${W}NAME${NC}      ${G}│${NC} ${W}ID${NC}        ${G}│${NC} ${W}LOCAL IP${NC}     ${G}│${NC} ${W}HOST:CONT${NC}    ${G}│${NC} ${W}STATUS${NC}     ${G}│${NC}"
echo -e " ${G}├──────────┼──────────┼──────────────┼──────────────┼────────────┤${NC}"

docker ps -a --format "{{.Names}}|{{.ID}}|{{.Status}}|{{.Ports}}" | head -n 3 | while read -r line
do

IFS='|' read -r name id status ports <<< "$line"

ip=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$name" 2>/dev/null || echo "0.0.0.0")

mapping=$(echo "$ports" | grep -oP '\d+->\d+' | head -n1 | sed 's/->/:/')

p_stat=$([[ "$status" == *"Up"* ]] && echo -e "${B_GREEN}ON${NC}" || echo -e "${B_RED}OFF${NC}")

printf " ${G}│${NC} %-8.8s ${G}│${NC} %-8.8s ${G}│${NC} %-12.12s ${G}│${NC} %-12.12s ${G}│${NC} %-10b ${G}│${NC}\n" "$name" "$id" "$ip" "${mapping:- ---}" "$p_stat"

done

echo -e " ${G}└──────────┴──────────┴──────────────┴──────────────┴────────────┘${NC}"

}

# --- UI RENDER ---
render_ui() {

clear
get_metrics

echo -e " ${B_BLUE}${NC}${BG_SHADE}${W} HOST: $CURRENT_HOST ${NC}${B_BLUE}${NC}  ${B_PURPLE}${NC}${BG_SHADE}${W} UPTIME: $UPT ${NC}${B_PURPLE}${NC}  ${B_GREEN}${NC}${BG_SHADE}${W} KVM: $KVM_STATUS ${NC}${B_GREEN}${NC}  ${GOLD}${NC}${BG_SHADE}${W} DOCKER: $DOKO_STATUS ${NC}${GOLD}${NC}"

echo

# --- LP ASCII LOGO ---
echo -e "${B_CYAN}██╗     ██████╗     ███████╗██╗   ██╗███████╗████████╗███████╗███╗   ███╗${NC}"
echo -e "${B_CYAN}██║     ██╔══██╗    ██╔════╝╚██╗ ██╔╝██╔════╝╚══██╔══╝██╔════╝████╗ ████║${NC}"
echo -e "${B_PURPLE}██║     ██████╔╝    ███████╗ ╚████╔╝ ███████╗   ██║   █████╗  ██╔████╔██║${NC}"
echo -e "${B_PURPLE}██║     ██╔═══╝     ╚════██║  ╚██╔╝  ╚════██║   ██║   ██╔══╝  ██║╚██╔╝██║${NC}"
echo -e "${GOLD}███████╗██║         ███████║   ██║   ███████║   ██║   ███████╗██║ ╚═╝ ██║${NC}"
echo -e "${GOLD}╚══════╝╚═╝         ╚══════╝   ╚═╝   ╚══════╝   ╚═╝   ╚══════╝╚═╝     ╚═╝${NC}"

echo -e " ${W}LightingPlays Virtualization Manager${NC}"

echo -e " ${G}────────────────────────────────────────────────────────────${NC}"

render_doko_grid

printf "\n ${W}LP Node Status:${NC} ${G}CPU:${NC} ${B_CYAN}%-4s${NC} ${G}RAM:${NC} ${B_PURPLE}%-4s${NC} ${G}Disk:${NC} ${B_GREEN}%-4s${NC}\n" "$CPU%" "$RAM%" "$DISK"

echo

echo -e " ${B_CYAN}LP VIRTUALIZATION CONTROL${NC}"
echo -e " ${G}├─ ${W}[1]${NC} RDX/IDX Environment"
echo -e " ${G}├─ ${W}[2]${NC} VM-1 (KVM Mode)"
echo -e " ${G}├─ ${W}[3]${NC} VM-2 (No-KVM)"
echo -e " ${G}├─ ${W}[5]${NC} LXC/LXD Deploy"
echo -e " ${G}└─ ${W}[6]${NC} Docker Deploy"

echo
echo -e " ${B_PURPLE}SESSION CONTROL${NC}"
echo -e " ${G}└─ ${B_RED}[0] EXIT${NC}"

echo
echo -ne " ${B_CYAN}➜${NC} ${W}Select Option${NC} ${G}(0-6):${NC} "

}

# --- MAIN LOOP ---
while true
do

render_ui

read -r opt

case $opt in

1)

echo -e "\n ${B_CYAN}Initializing IDX Dev Environment...${NC}"

mkdir -p "$HOME/vm/.idx"
cd "$HOME/vm/.idx" || exit

cat <<EOF > dev.nix
{ pkgs, ... }: {

channel = "stable-24.05";

packages = with pkgs; [

unzip
openssh
git
qemu_kvm
btop
sudo
cdrkit
cloud-utils
qemu

];

env = {

EDITOR = "nano";

};

}
EOF

echo -e " ${B_GREEN}Environment Ready.${NC}"

pause

;;

2)

bash <(curl -s https://raw.githubusercontent.com/nobita329/hub/refs/heads/main/Codinghub/VM/vm-run1.sh)

pause

;;

3)

bash <(curl -s https://raw.githubusercontent.com/nobita329/hub/refs/heads/main/Codinghub/VM/os.sh)

bash <(curl -s https://raw.githubusercontent.com/nobita329/hub/refs/heads/main/Codinghub/VM/vm-run2.sh)

pause

;;

5)

bash <(curl -s https://raw.githubusercontent.com/nobita329/ptero/refs/heads/main/ptero/vps/lxc.sh)

pause

;;

6)

bash <(curl -s https://raw.githubusercontent.com/nobita329/hub/refs/heads/main/Codinghub/VM/docker/manage.sh)

pause

;;

0)

echo
echo -e " ${B_RED}Disconnected.${NC} Goodbye, LightingPlays."

exit 0

;;

*)

echo -e " ${B_RED}Invalid Option.${NC}"

sleep 0.7

;;

esac

done
