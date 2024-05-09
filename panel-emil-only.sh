#!/bin/sh
#
echo " download and install panel emil nabil "

if [ -f /etc/apt/apt.conf ]; then
    status='/var/lib/dpkg/status'
    it=DreamOs
    apt install wget >/dev/null 2>&1
else
    status='/var/lib/opkg/status'
    it=OpenSource
    opkg install wget >/dev/null 2>&1
fi

# Remove unnecessary files and folders
[ -d "/CONTROL" ] && rm -r /CONTROL >/dev/null 2>&1
rm -rf /control /postinst /preinst /prerm /postrm /tmp/*.ipk /tmp/*.tar.gz >/dev/null 2>&1

echo ""
echo "> Checking mounted storage, please wait..."
sleep 3

# Check for mounted storage
mrp=("/media/hdd" "/media/usb" "/media/mmc")
for mr in "${mrp[@]}"; do
    if [ -d "$mr" ]; then
        echo "> Mounted storage found at: $mr"
        break
    fi
done

if [ ! -d "$mr/AJPanel_Backup" ]; then
    mkdir -p $mr/AJPanel_Backup
else
echo ""
fi
# Set up update URL
echo "https://raw.githubusercontent.com/biko-73/AjPanel/main/" > $mr/AJPanel_Backup/ajpanel_update_url
echo ""
echo ""
###########################
# Download and install emil-panel
plugin=AJPanel_Backup
url="https://github.com/emil237/ajpanel/raw/main/AJPanel_Backup.zip"
package=/var/volatile/tmp/$plugin.zip
wget --show-progress -qO $package --no-check-certificate $url
cd /tmp
unzip AJPanel_Backup.zip
rm -rf AJPanel_Backup.zip
cp -rf AJPanel_Backup $mr/
rm -rf AJPanel_Backup
cd
echo " Ok Downloaded Panel "
sleep 3;
echo
echo 
echo " Uploaded By Emil Nabil "
sleep 4;
# Configure ajpanel_menu.xml
    espp=$(grep config.plugins.AJPanel.backupPath /etc/enigma2/settings | cut -d '=' -f 2)
    ajpanel_menu="ajpanel_menu.xml"
    ajpanel_menu_path="$espp$ajpanel_menu"
    ajpanel_menu_url="https://dreambox4u.com/emilnabil237/plugins/ajpanel/ajpanel_menu.xml"
    wget --show-progress -qO $ajpanel_menu_path --no-check-certificate "$ajpanel_menu_url"

    echo ""
    echo "> $plugin package installed successfully"
    echo "> Uploaded By Emil Nabil"
    sleep 4;
# Get system image version
if [ -f /etc/image-version ]; then
    image=$(grep -iF "creator" /etc/image-version | cut -d "=" -f 2 | xargs)
elif [ -f /etc/issue ]; then
    image=$(awk '{print $1;}' /etc/issue)
else
    image=''
fi

[ ! -z "$image" ] && echo -e "> image: $image"
sleep 3
echo ">  Setup The Plugin...."
# Configure ajpanel_settings
touch "$mr/AJPanel_Backup/ajpanel_settings"
cat <<EOF > "$mr/AJPanel_Backup/ajpanel_settings"
config.plugins.AJPanel.backupPath=$mr/AJPanel_Backup/
config.plugins.AJPanel.browserBookmarks=/usr/lib/enigma2/python/Plugins/Extensions/,/tmp/,/
config.plugins.AJPanel.checkForUpdateAtStartup=True
config.plugins.AJPanel.downloadedPackagesPath=$mr/AJPanel_Backup/downloaded-packages/
config.plugins.AJPanel.exportedPIconsPath=$mr/AJPanel_Backup/exported-picons/
config.plugins.AJPanel.exportedTablesPath=$mr/AJPanel_Backup/exported-tables/
config.plugins.AJPanel.FileManagerExit=d
config.plugins.AJPanel.hideIptvServerChannPrefix=True
if [ "$it" == DreamOS ]; then
    config.plugins.AJPanel.iptvAddToBouquetRefType=8193
else
    config.plugins.AJPanel.iptvAddToBouquetRefType=5002
fi
config.plugins.AJPanel.lastFileManFindSrt=/tmp
config.plugins.AJPanel.lastPkgProjDir=/etc/enigma2/MyMetrixLiteBackup.dat
config.plugins.AJPanel.lastTerminalCustCmdLineNum=307
config.plugins.AJPanel.packageOutputPath=$mr/AJPanel_Backup/create-package-files/
if [ "$it" == DreamOS ]; then
    config.plugins.AJPanel.PIconsPath=$mr/picon/
else
    config.plugins.AJPanel.PIconsPath=/media/hdd/picon/
fi
config.plugins.AJPanel.screenshotFType=png
config.plugins.AJPanel.subtBGTransp=60
config.plugins.AJPanel.subtDelaySec=-1
config.plugins.AJPanel.subtShadowColor=#FF0000
config.plugins.AJPanel.subtTextFg=#FFFF00
EOF

# Update Enigma2 settings
sed -i '/config.plugins.AJPanel../d' /etc/enigma2/settings
grep "config.plugins.AJPanel.*" "$mr/AJPanel_Backup/ajpanel_settings" >> /etc/enigma2/settings
##################################################################################
echo ""

==============================================================================

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












