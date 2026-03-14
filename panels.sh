#!/bin/bash

while true; do

clear

echo "--------------------------------"
echo "Panels"
echo "--------------------------------"
echo "ServerPanel Manager"
echo "--------------------------------"
echo
echo "1. Pterodactyl"
echo "2. JexactylPanel"
echo "3. Reviactyl"
echo "4. FeatherPanel"
echo
echo "0. Back"
echo

read -p "Select option: " panel

case $panel in

1)
bash <(curl -fsSL https://raw.githubusercontent.com/node2ws-glitch/LPINSTALLER/main/panel/ptero.sh)
;;

2)
bash <(curl -fsSL https://raw.githubusercontent.com/DreamHost2ws/ExtremLightingCode/main/panel/Jexactyl/run.sh)
;;

3)
bash <(curl -fsSL https://raw.githubusercontent.com/DreamHost2ws/ExtremLightingCode/main/panel/unReviactyl.sh)
;;

4)
bash <(curl -fsSL https://raw.githubusercontent.com/DreamHost2ws/ExtremLightingCode/main/panel/unFEATHERPANEL.sh)
;;

0)
exit
;;

*)
echo "Invalid option!"
sleep 1
;;

esac

done
