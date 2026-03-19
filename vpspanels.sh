vps_panels_menu() {

while true; do
clear

echo "-----------------------------"
echo "VPS Panels"
echo "-----------------------------"
echo "Server VPS Panel Manager"
echo "-----------------------------"
echo
echo "1. HVM & VPS Bot"
echo "2. SVM"
echo
echo "0. Back"
echo

read -p "Select option: " vps_choice

case $vps_choice in

1)
echo "Launching HVM Installer..."
bash <(curl -fsSL https://raw.githubusercontent.com/DreamHost2ws/HVM5.1/main/LP-Hvm-Installer.sh)
;;

2)
echo "Installing SVM Panel..."
git clone https://github.com/AnkitKing7/lol
cd lol || exit
bash install.sh

echo "Extracting SVM..."
unzip Svm-v5.zip

echo "Starting SVM..."
python3 svm.py
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

# 👇 THIS LINE FIXES EVERYTHING
vps_panels_menu
