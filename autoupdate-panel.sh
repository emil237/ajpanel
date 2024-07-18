#!/bin/sh

# Configure ajpanel_menu_Emil.xml path
espp=$(grep config.plugins.AJPanel.backupPath /etc/enigma2/settings | cut -d '=' -f 2)
ajpanel_menu="ajpanel_menu_Emil.xml"
ajpanel_menu_path="$espp$ajpanel_menu"

# Determine local panel version
lpv=$(sed -n '/About/p' "$ajpanel_menu_path" | sed 's/^.*">/">/' | sed 's/">*//' | sed 's/<.*//')

# Determine web panel version
wget -qO /tmp/version.txt --no-check-certificate https://dreambox4u.com/emilnabil237/plugins/ajpanel/new/version.txt
sleep 3
wpv=$(sed -n '/20/p' /tmp/version.txt)

# Update panel
if [ "$lpv" = "$wpv" ]; then
    panel=updated
else
    wget "http://localhost/web/message?text=> Emil-panel,new update available please wait...&type=5&timeout=5" >/dev/null 2>&1
    sleep 5
    wget -q "--no-check-certificate" https://dreambox4u.com/emilnabil237/plugins/ajpanel/new/emil-panel-lite.sh -O - | /bin/sh
fi

