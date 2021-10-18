#!/bin/sh
chmod +x ./plasma-shutdown
chmod +x ./shutdown_update
chmod +x ./startup_update
if [ ! -e /usr/bin/plasma-shutdown2 ]; then
    mv  /usr/bin/plasma-shutdown /usr/bin/plasma-shutdown2
    cp ./plasma-shutdown /usr/bin/plasma-shutdown
    cp /usr/bin/plasma-shutdown /usr/bin/plasma-shutdown-bu
else
    cp ./plasma-shutdown /usr/bin/plasma-shutdown
    cp /usr/bin/plasma-shutdown /usr/bin/plasma-shutdown-bu 
fi
mkdir /usr/share/services/
cp ./shutdown_update /usr/share/services/shutdown_update
cp ./startup_update /usr/share/services/startup_update
cp ./update_shutdown.service /etc/systemd/system/update_shutdown.service
cp ./update_startup.service /etc/systemd/system/update_startup.service
systemctl enable update_startup.service
apt-get install --reinstall plymouth-theme-spinner -y
update-alternatives --set default.plymouth /usr/share/plymouth/themes/bgrt/bgrt.plymouth
cp /usr/share/plymouth/themes/spinner/watermark.png /usr/share/plymouth/themes/spinner/watermark-old.png
cp /usr/share/plymouth/themes/kubuntu-logo/images/logo.png /usr/share/plymouth/themes/spinner/watermark.png
cp /usr/share/plymouth/ubuntu-logo.png /usr/share/plymouth/ubuntu-logo_old.png
cp /usr/share/plymouth/themes/kubuntu-logo/images/logo.png /usr/share/plymouth/ubuntu-logo.png
update-initramfs -c -k all

