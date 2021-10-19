#!/bin/sh
echo "This script will install my custom script to\nupdate your system when it's being shutdown.\nIt is tested on Kubuntu 21.04 and 21.10, but should work\nwith future versions as well.\n\nThe script requires root privileges to copy the files to the\ncorresponding locations.\n\nThis script also includes a service that updates your\nflatpak and snap packages at startup."
printf 'press [ENTER] to continue, [CTRL]+[C] to abort...'
read _

mkdir /usr/share/services/
cp ./shutdown_update /usr/share/services/shutdown_update
cp ./startup_update /usr/share/services/startup_update
cp ./update_shutdown.service /etc/systemd/system/update_shutdown.service
cp ./update_startup.service /etc/systemd/system/update_startup.service
cp ./poweroff.target.d /etc/systemd/system/
systemctl daemon-reload
systemctl enable update_startup.service
systemctl enable update_shutdown.service
systemctl start update_shutdown.service
apt-get install --reinstall plymouth-theme-spinner -y
update-alternatives --set default.plymouth /usr/share/plymouth/themes/bgrt/bgrt.plymouth
if [ -f /usr/share/plymouth/themes/kubuntu-logo/images/logo.png ];
then
  cp /usr/share/plymouth/themes/spinner/watermark.png /usr/share/plymouth/themes/spinner/watermark-old.png
  cp /usr/share/plymouth/themes/kubuntu-logo/images/logo.png /usr/share/plymouth/themes/spinner/watermark.png
  cp /usr/share/plymouth/ubuntu-logo.png /usr/share/plymouth/ubuntu-logo_old.png
  cp /usr/share/plymouth/themes/kubuntu-logo/images/logo.png /usr/share/plymouth/ubuntu-logo.png
fi
chmod +x /usr/share/services/shutdown_update
chmod +x /usr/share/services/startup_update
update-initramfs -c -k all

