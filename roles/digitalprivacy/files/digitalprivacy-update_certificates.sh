#!/bin/bash
# This script is made from and for https://digitalprivacy.homes (DIGITAL PRIVACY for every home).
# Repo: https://codeberg.org/digitalprivacy-homes/ansible-server
# License: GPL-3.0-or-later
# This script is to update the Letsencrypt certificates for *.digitalprivacy.homes.

# Check whether digitalprivacy.homes certificates are available or not. Download and update them if necessary.
OLDKEY=$(sudo cat /etc/nginx/ssl/digitalprivacy.homes.key 2>&1)
NEWKEY=$(sudo cat /etc/nginx/ssl/digitalprivacy.homes.key.new 2>&1)
if [ ! -f /etc/nginx/ssl/digitalprivacy.homes.key ]; then
    echo "No certificates found at all. Downloading all necessary files."
    sudo touch /etc/nginx/ssl/digitalprivacy.homes.key
    sudo touch /etc/nginx/ssl/digitalprivacy.homes.cer
    # Downloads (new) certificates if available as with "new" ending.
    # This is necessary to also keep the new files and instead of overwriting the current files.
    sudo curl --socks5-hostname 127.0.0.1:9050 -o "/etc/nginx/ssl/digitalprivacy.homes.key.new" -z "/etc/nginx/ssl/digitalprivacy.homes.key.new" "https://certificates.digitalprivacy.homes/digitalprivacy.homes.key" >/dev/null 2>&1
    sudo curl --socks5-hostname 127.0.0.1:9050 -o "/etc/nginx/ssl/digitalprivacy.homes.key.sig" -z "/etc/nginx/ssl/digitalprivacy.homes.key.sig" "https://certificates.digitalprivacy.homes/digitalprivacy.homes.key.sig" >/dev/null 2>&1
    sudo curl --socks5-hostname 127.0.0.1:9050 -o "/etc/nginx/ssl/digitalprivacy.homes.key.CHECKSUM" -z "/etc/nginx/ssl/digitalprivacy.homes.key.CHECKSUM" "https://certificates.digitalprivacy.homes/digitalprivacy.homes.key.CHECKSUM" >/dev/null 2>&1
    sudo curl --socks5-hostname 127.0.0.1:9050 -o "/etc/nginx/ssl/digitalprivacy.homes.cer.new" -z "/etc/nginx/ssl/digitalprivacy.homes.cer.new" "https://certificates.digitalprivacy.homes/digitalprivacy.homes.cer" >/dev/null 2>&1
    sudo curl --socks5-hostname 127.0.0.1:9050 -o "/etc/nginx/ssl/digitalprivacy.homes.cer.sig" -z "/etc/nginx/ssl/digitalprivacy.homes.cer.sig" "https://certificates.digitalprivacy.homes/digitalprivacy.homes.cer.sig" >/dev/null 2>&1
    sudo curl --socks5-hostname 127.0.0.1:9050 -o "/etc/nginx/ssl/digitalprivacy.homes.cer.CHECKSUM" -z "/etc/nginx/ssl/digitalprivacy.homes.cer.CHECKSUM" "https://certificates.digitalprivacy.homes/digitalprivacy.homes.cer.CHECKSUM" >/dev/null 2>&1
    sudo sed -i 's/digitalprivacy.homes.cer/digitalprivacy.homes.cer.new/' /etc/nginx/ssl/digitalprivacy.homes.cer.CHECKSUM
    sudo sed -i 's/digitalprivacy.homes.key/digitalprivacy.homes.key.new/' /etc/nginx/ssl/digitalprivacy.homes.key.CHECKSUM
# If the old and new key are identical, there is no reason to continue. No new certificates have been created yet.
elif [ "$OLDKEY" = "$NEWKEY" ]; then
    echo "No new certificates available."
    exit 0
else
    echo "Checking for new certificates."
    sudo curl --socks5-hostname 127.0.0.1:9050 -o "/etc/nginx/ssl/digitalprivacy.homes.key.new" -z "/etc/nginx/ssl/digitalprivacy.homes.key.new" "https://certificates.digitalprivacy.homes/digitalprivacy.homes.key" >/dev/null 2>&1
    sudo curl --socks5-hostname 127.0.0.1:9050 -o "/etc/nginx/ssl/digitalprivacy.homes.key.sig" -z "/etc/nginx/ssl/digitalprivacy.homes.key.sig" "https://certificates.digitalprivacy.homes/digitalprivacy.homes.key.sig" >/dev/null 2>&1
    sudo curl --socks5-hostname 127.0.0.1:9050 -o "/etc/nginx/ssl/digitalprivacy.homes.key.CHECKSUM" -z "/etc/nginx/ssl/digitalprivacy.homes.key.CHECKSUM" "https://certificates.digitalprivacy.homes/digitalprivacy.homes.key.CHECKSUM" >/dev/null 2>&1
    sudo curl --socks5-hostname 127.0.0.1:9050 -o "/etc/nginx/ssl/digitalprivacy.homes.cer.new" -z "/etc/nginx/ssl/digitalprivacy.homes.cer.new" "https://certificates.digitalprivacy.homes/digitalprivacy.homes.cer" >/dev/null 2>&1
    sudo curl --socks5-hostname 127.0.0.1:9050 -o "/etc/nginx/ssl/digitalprivacy.homes.cer.sig" -z "/etc/nginx/ssl/digitalprivacy.homes.cer.sig" "https://certificates.digitalprivacy.homes/digitalprivacy.homes.cer.sig" >/dev/null 2>&1
    sudo curl --socks5-hostname 127.0.0.1:9050 -o "/etc/nginx/ssl/digitalprivacy.homes.cer.CHECKSUM" -z "/etc/nginx/ssl/digitalprivacy.homes.cer.CHECKSUM" "https://certificates.digitalprivacy.homes/digitalprivacy.homes.cer.CHECKSUM" >/dev/null 2>&1
fi

# Make sure that the public key is imported. 
# *Needs to be further improved. It works, but there is too much output.
PUBKEY=$(sudo gpg --list-keys | grep "certificates@chat.digitalprivacy.homes" | awk '{print $4}' | cut -b 2-39)
if [[ "$PUBKEY" != certificates@chat.digitalprivacy.homes ]]; then
    sudo curl --socks5-hostname 127.0.0.1:9050 -o "/etc/nginx/ssl/certificates_0xDA166C9A2E2841D7_public.asc" "https://certificates.digitalprivacy.homes/certificates_0xDA166C9A2E2841D7_public.asc" >/dev/null 2>&1
    sudo gpg --import /etc/nginx/ssl/certificates_0xDA166C9A2E2841D7_public.asc
    sudo echo -e "5\ny\n" | gpg --command-fd 0 --expert --edit-key certificates trust
fi

# Checks the checksum and signature of the new files, and if they match, the current key and cer files are renamed to *.old files (as a backup).
# The *.new files are applied (renamed to the *.key and *.cer files) and nginx is reloaded to use the new certificate(s).
CHECKSUMCER=$(sudo sha512sum -c /etc/nginx/ssl/digitalprivacy.homes.cer.CHECKSUM | awk '{print $2}')
CHECKSUMKEY=$(sudo sha512sum -c /etc/nginx/ssl/digitalprivacy.homes.key.CHECKSUM | awk '{print $2}')
SIGNCER=$(sudo gpg --verify /etc/nginx/ssl/digitalprivacy.homes.cer.sig /etc/nginx/ssl/digitalprivacy.homes.cer.new 2>&1 | grep Good | awk '{print $2}')
SIGNKEY=$(sudo gpg --verify /etc/nginx/ssl/digitalprivacy.homes.key.sig /etc/nginx/ssl/digitalprivacy.homes.key.new 2>&1 | grep Good | awk '{print $2}')
if [[ "$CHECKSUMCER" && "$CHECKSUMKEY" = "OK" ]] && [[ "$SIGNCER" && "$SIGNKEY" = "Good" ]]; then
    sudo mv /etc/nginx/ssl/digitalprivacy.homes.cer /etc/nginx/ssl/digitalprivacy.homes.cer.old
    sudo mv /etc/nginx/ssl/digitalprivacy.homes.key /etc/nginx/ssl/digitalprivacy.homes.key.old
    sudo cp /etc/nginx/ssl/digitalprivacy.homes.cer.new /etc/nginx/ssl/digitalprivacy.homes.cer
    sudo cp /etc/nginx/ssl/digitalprivacy.homes.key.new /etc/nginx/ssl/digitalprivacy.homes.key
    sudo systemctl reload nginx.service
    echo "Certificates updated!"
else
    echo "Checksum and/or signature failed."
    exit 0
fi