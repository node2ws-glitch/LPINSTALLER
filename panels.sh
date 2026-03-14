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
bash <(curl -fsSL https://pterodactyl-installer.se)
;;

2)
bash <(curl -fsSL https://raw.githubusercontent.com/jexactyl/jexactyl/main/install.sh)
;;

3)
echo "Reviactyl installer coming soon"
;;

4)
echo "FeatherPanel installer coming soon"
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
