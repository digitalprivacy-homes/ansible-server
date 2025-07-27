#!/bin/bash
# This script is made from and for https://digitalprivacy.homes (DIGITAL PRIVACY for every home).
# Repo: https://codeberg.org/digitalprivacy-homes/ansible-server
# License: GPL-3.0-or-later
# All necessary info and changes can be done via this script.

# Server IP address
IP=$(hostname -I | awk '{print $1}')

# Initialize result variable
result=""

# Clear screen
clear

while true; do
    # Display menu using whiptail
    CHOICE=$(
        whiptail --title "DIGITAL PRIVACY .HOMES" --nocancel --menu "" $(stty size) 10 \
            "1)" "Welcome/Info"   \
            "2)" "Set up your router" \
            "3)" "Server IP"  \
            "4)" "Services" \
            "5)" "Update certificates" \
            "6)" "Update IPs for your services" \
            "7)" "Disable script-autostart at login via main user" \
            "8)" "full-upgrade your system"  \
            "0)" "Exit" 3>&2 2>&1 1>&3
    )

    # Handle menu choices
    case $CHOICE in
        "1)")
            result="Your personal DIGITAL PRIVACY .HOMES server is ready to use.
Once everything is set up correctly, you can enjoy your internet connectivity much more without your data being constantly monitored by Big Tech.

Should you encounter any problems, just contact us.

 * Website:     https://digitalprivacy.homes
 *   Email:     hello@chat.digitalprivacy.homes
 *     FAQ:     https://digitalprivacy.homes/#faq

(Press the TAB key on your keyboard to be able to click on <Ok>)"
            ;;
        "2)")
            result="The server must be properly connected to your router so that your new server can be used as a DNS server and use this DNS entry to forward to all connected devices!
After the router uses the new DNS entry, you will need to reconnect or restart your phone, computer, etc. This will allow all your devices to connect to the new services and will also be secured by the new server.

The IP address of your new server (DNS server) is:
$IP
Use this IP for your DNS entry on your router. The changes to your router vary from manufacturer to manufacturer. The most commonly used search terms to look for are DNS and DHCP -> DNS.

If you cannot find the right information or need general help, feel free to contact us."
            ;;
        "3)")
            result="Your server ip address is:
$IP"
            ;;
        "4)")
            result="$(cat /etc/issue.net)"
            ;;
        "5)")
            result="$(/usr/local/bin/digitalprivacy-update_certificates)"
            ;;
        "6)")
            result="$(/usr/local/bin/digitalprivacy-update_ip)"
            ;;
        "7)")
            result="$(sed -i '\|/usr/local/bin/digitalprivacy|d' ~/.bashrc &&
            echo "Script-autostart disabled.")"
            ;;
        "8)")
            result="$(sudo apt-get full-upgrade -y)"
            ;;
        "0)")
            # Exit the loop
            clear
            echo "You can always start the info screen again. Just type:"
            echo "digitalprivacy"
            exit
            ;;
    esac

    # Display result using whiptail with scroll text
    whiptail --scrolltext --msgbox "$result" $(stty size)
done

# Exit the script
exit 0
