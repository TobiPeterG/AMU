#!/bin/sh
#show warning and wait for user to hit enter or abort installation
echo -e "This script will install my custom script to\nupdate your system when it's being shutdown.\nIt is tested on Manjaro 21.1.6, but should work\nwith future versions as well.\n\nThe script requires root privileges to copy the files to the\ncorresponding locations.\n\nThis script also includes a service that updates your\nflatpak and snap packages at startup."
printf 'press [ENTER] to continue, [CTRL]+[C] to abort...'
read _

#create required folders, copy files to correct location, make scripts executable
cd ./files
mkdir /usr/share/services/
mkdir /var/log/manjaro-automatic-update/
cp ./shutdown_update /usr/share/services/shutdown_update
cp ./startup_update /usr/share/services/startup_update
cp ./update_shutdown.service /etc/systemd/system/update_shutdown.service
cp ./update_startup.service /etc/systemd/system/update_startup.service

#the poweroff.target has to be modified to remove the timeout
cp -r ./poweroff.target.d /etc/systemd/system/

systemctl daemon-reload
systemctl enable update_startup.service
systemctl enable update_shutdown.service
systemctl start update_shutdown.service
chmod +x /usr/share/services/shutdown_update
chmod +x /usr/share/services/startup_update

#install plymouth, if not installed
if ! command -v /bin/plymouth;
then
    pamac install plymouth plymouth-theme-manjaro --no-confirm
    #backup config files
    cp /etc/mkinitcpio.conf /etc/mkinitcpio.conf-backup
    cp /etc/default/grub  /etc/default/grub-backup
    #add / change required init hooks
    sed -i 's/HOOKS="base udev/HOOKS="base udev plymouth/' /etc/mkinitcpio.conf
    sed -i 's/encrypt resume/plymouth-encrypt resume/' /etc/mkinitcpio.conf
    #change grub config to show plymouth
    sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash/' /etc/default/grub
    sudo mkinitcpio -P
    sudo update-grub
fi


#fix the font of plymouth not being visible of the manjaro theme
sed -i 's/_//' /usr/share/plymouth/themes/manjaro/manjaro.plymouth
#set the manjaro theme as default
plymouth-set-default-theme -R manjaro
