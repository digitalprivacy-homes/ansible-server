#!/bin/bash
# Part of DIGITAL PRIVACY .HOMES.
# This script is to update the Letsencrypt certificates for *.digitalprivacy.homes.

sudo curl --socks5-hostname 127.0.0.1:9050 -o "/etc/nginx/ssl/digitalprivacy.homes.key" -z "/etc/nginx/ssl/digitalprivacy.homes.key" "https://certificates.digitalprivacy.homes/digitalprivacy.homes.key" > /dev/null 2>&1 && \
sudo curl --socks5-hostname 127.0.0.1:9050 -o "/etc/nginx/ssl/digitalprivacy.homes.cer" -z "/etc/nginx/ssl/digitalprivacy.homes.cer" "https://certificates.digitalprivacy.homes/digitalprivacy.homes.cer" > /dev/null 2>&1 && \
sudo systemctl reload nginx.service

echo "Certificates updated!"