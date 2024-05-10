#!/bin/sh
#
#command=wget -q "--no-check-certificate" https://raw.githubusercontent.com/emil237/ajpanel/main/update-panel-emil-only.sh -O - | /bin/sh
##################
#############################
echo " update panel emil nabil "

if [ -f /etc/apt/apt.conf ]; then
    status='/var/lib/dpkg/status'
    it=DreamOs
    apt install wget >/dev/null 2>&1
else
    status='/var/lib/opkg/status'
    it=OpenSource
    opkg install wget >/dev/null 2>&1
fi

echo ""
BACKUP_DIR=$(cat /etc/enigma2/settings | grep config.plugins.AJPanel.backupPath | cut -d '=' -f 2)

for FNAME in "ajpanel_menu_Emil.xml"  "ajpanel_menu.xml"
do
	echo "--------------------------------------------------"
	echo ">>>>>  Downloading $FNAME  <<<<<"
	wget --no-check-certificate -O $BACKUP_DIR$FNAME https://raw.githubusercontent.com/emil237/ajpanel/main/$FNAME
	echo ''
done

echo " Ok downloaded panels "
sleep 3;
echo
echo 
echo " Uploaded By Emil Nabil "
sleep 4;
echo "> Setup Done..., Please Wait enigma2 restarting..."

# Restart Enigma2 service or kill enigma2 based on the system
if [ "$it" == DreamOS ]; then
    sleep 2
    systemctl restart enigma2
else
    sleep 2
    killall -9 enigma2
fi

exit 0



