import os
import subprocess
import time

def run_command(command):
    subprocess.run(command, shell=True, check=True, stdout=subprocess.DEVNULL, stderr=subprocess.STDOUT)

print("Download and install panel emil nabil lite")

if os.path.isfile('/etc/apt/apt.conf'):
    status = '/var/lib/dpkg/status'
    it = 'DreamOs'
    run_command('apt install wget')
else:
    status = '/var/lib/opkg/status'
    it = 'OpenSource'
    run_command('opkg install wget')

print("")

run_command('opkg install curl')
time.sleep(2)

os.chdir('/tmp')
run_command('curl -k -Lbk -m 55532 -m 555104 "https://dreambox4u.com/emilnabil237/plugins/ajpanel/new/emil-panel-lite.tar.gz" > /tmp/emil-panel-lite.tar.gz')
time.sleep(1)
print("installing ....")

os.chdir('/tmp')
run_command('tar -xzf emil-panel-lite.tar.gz -C /')
print("\n" * 8)
time.sleep(1)

os.remove('/tmp/emil-panel-lite.tar.gz')
print("OK")
print("Ok Downloaded Panel")
time.sleep(3)
print("download scripts")

os.chdir('/tmp')
run_command('wget -q "--no-check-certificate" https://github.com/emil237/ajpanel/raw/main/script.tar.gz -O /tmp/script.tar.gz')
run_command('tar -xzf /tmp/script.tar.gz -C /')
time.sleep(2)
os.remove('/tmp/script.tar.gz')
print("")

image = ''
if os.path.isfile('/etc/image-version'):
    with open('/etc/image-version') as f:
        for line in f:
            if 'creator' in line:
                image = line.split('=')[1].strip()
elif os.path.isfile('/etc/issue'):
    with open('/etc/issue') as f:
        image = f.readline().split()[0]

if image:
    print(f"> image: {image}")

time.sleep(3)
print("> Setup The Plugin....")

# Configure ajpanel_settings
settings_path = "/emil-panel-lite/ajpanel_settings"
os.makedirs(os.path.dirname(settings_path), exist_ok=True)
with open(settings_path, 'w') as f:
    f.write(f"""config.plugins.AJPanel.backupPath=/emil-panel-lite/
config.plugins.AJPanel.browserBookmarks=/usr/lib/enigma2/python/Plugins/Extensions/,/tmp/,/
config.plugins.AJPanel.checkForUpdateAtStartup=True
config.plugins.AJPanel.downloadedPackagesPath=/emil-panel-lite/downloaded-packages/
config.plugins.AJPanel.exportedPIconsPath=/emil-panel-lite/exported-picons/
config.plugins.AJPanel.exportedTablesPath=/emil-panel-lite/exported-tables/
config.plugins.AJPanel.FileManagerExit=d
config.plugins.AJPanel.hideIptvServerChannPrefix=True
config.plugins.AJPanel.iptvAddToBouquetRefType={"8193" if it == 'DreamOs' else "5002"}
config.plugins.AJPanel.lastFileManFindSrt=/tmp
config.plugins.AJPanel.lastPkgProjDir=/etc/enigma2/MyMetrixLiteBackup.dat
config.plugins.AJPanel.lastTerminalCustCmdLineNum=307
config.plugins.AJPanel.packageOutputPath=/emil-panel-lite/create-package-files/
config.plugins.AJPanel.PIconsPath={'/media/hdd/picon/' if it == 'DreamOs' else ''}
config.plugins.AJPanel.screenshotFType=png
config.plugins.AJPanel.subtBGTransp=60
config.plugins.AJPanel.subtDelaySec=-1
config.plugins.AJPanel.subtShadowColor=#FF0000
config.plugins.AJPanel.subtTextFg=#FFFF00
""")

# Update Enigma2 settings
run_command('sed -i "/config.plugins.AJPanel../d" /etc/enigma2/settings')
run_command('grep "config.plugins.AJPanel.*" "/emil-panel-lite/ajpanel_settings" >> /etc/enigma2/settings')

print("")
print("Ok confg panel")
time.sleep(3)
print("Uploaded By Emil Nabil")
time.sleep(4)
print("> Setup Done..., Please Wait enigma2 restarting...")

if it == 'DreamOs':
    time.sleep(2)
    run_command('systemctl restart enigma2')
else:
    time.sleep(2)
    run_command('killall -9 enigma2')


