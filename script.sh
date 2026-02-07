#!/bin/sh

echo "Downloading scripts..."

cd /tmp || exit 1

wget -q --no-check-certificate \
https://github.com/emil237/ajpanel/raw/main/script.tar.gz \
-O script.tar.gz

tar -xzf script.tar.gz -C /

sleep 2

rm -f script.tar.gz
sleep 2
exit 
