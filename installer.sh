#!/bin/sh

#wget -q "--no-check-certificate" https://raw.githubusercontent.com/emil237/ajpanel/main/installer.sh -O - | /bin/sh

##########################################
version=The-latest-version
#############################################################
TEMPATH=/tmp
OPKGINSTALL="opkg install --force-overwrite"
MY_IPK="enigma2-plugin-extensions-ajpanel_v8.5.0_all.ipk"
MY_DEB="enigma2-plugin-extensions-ajpanel_v8.5.0_all.deb"
MY_URL="https://raw.githubusercontent.com/emil237/ajpanel/main"
if [ -f /etc/apt/apt.conf ] ; then
    STATUS='/var/lib/dpkg/status'
    OS='DreamOS'
elif [ -f /etc/opkg/opkg.conf ] ; then
   STATUS='/var/lib/opkg/status'
   OS='Opensource'
fi

# remove old version #
rm -rf /usr/lib/enigma2/python/Plugins/Extensions/AJPan

echo ""
# Download and install plugin
cd /tmp
set -e
 if which dpkg > /dev/null 2>&1; then
  wget "$MY_URL/$MY_DEB"
		dpkg -i --force-overwrite $MY_DEB; apt-get install -f -y
wait
rm -f $MY_DEB
	else
  wget "$MY_URL/$MY_IPK"
		$OPKGINSTALL $MY_IPK
wait
rm -f $MY_IPK
	fi
echo "================================="
set +e
cd ..
wait
	if [ $? -eq 0 ]; then
echo ">>>>  SUCCESSFULLY INSTALLED <<<<"
fi
		echo "********************************************************************************"
rm -rf * > /dev/null 2>&1
echo "   UPLOADED BY  >>>>   EMIL_NABIL "   
sleep 4;
		echo "#                Restart Enigma2 GUI                    #"
echo "#########################################################"
sleep 2
if [ $OS = 'DreamOS' ]; then
    systemctl restart enigma2
else
    killall -9 enigma2
fi
exit 0
