#!/bin/sh # ============================================================================================================ # SCRIPT : Download/Install AJPanel Custom-Menu XML Files # ============================================================================================================ 
BACKUP_DIR=$(cat /etc/enigma2/settings | grep config.plugins.AJPanel.backupPath | cut -d '=' -f 
2) for FNAME in "ajpanel_menu_biko_73.xml" "ajpanel_menu_Emil.xml" "ajpanel_menu_Haitham.xml" "ajpanel_menu.xml" do 	echo "--------------------------------------------------" 	echo ">>>>> Downloading $FNAME <<<<<" 	wget --no-check-certificate -O $BACKUP_DIR$FNAME https://raw.githubusercontent.com/emil237/ajpanel/main/$FNAME 	
echo '' 
done



