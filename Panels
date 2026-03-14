panels_menu() {

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
bash <(curl -fsSL https://raw.githubusercontent.com/reviactyl/reviactyl/main/install.sh)
;;

4)
bash <(curl -fsSL https://raw.githubusercontent.com/featherpanel/panel/main/install.sh)
;;

0)
break
;;

*)
echo "Invalid option!"
sleep 1
;;

esac

done

}
