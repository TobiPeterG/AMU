#!/bin/sh
mount -a
script_path="$1"

#create required folders, copy files to correct location, make scripts executable
mkdir /var/log/manjaro-automatic-update/
cp ${script_path}/update_shutdown /usr/local/bin/update_shutdown
cp ${script_path}/update_shutdown /usr/local/bin/update_startup
cp ${script_path}/update_shutdown.service /etc/systemd/system/update_shutdown.service
cp ${script_path}/update_startup.service /etc/systemd/system/update_startup.service

#the poweroff.target has to be modified to remove the timeout
cp -r ${script_path}/poweroff.target.d /etc/systemd/system/

systemctl daemon-reload
systemctl enable update_startup.service
systemctl enable update_shutdown.service
systemctl start update_shutdown.service
chmod +x /usr/local/bin/update_shutdown
chmod +x /usr/local/bin/update_startup

#install plymouth, if not installed
if ! command -v /bin/plymouth;
then
    pamac install plymouth plymouth-theme-manjaro --no-confirm
    #backup config files
    cp /etc/mkinitcpio.conf /etc/mkinitcpio.conf-backup
    cp /etc/default/grub  /etc/default/grub-backup
    #add / change required init hooks
    sed -i 's/HOOKS="base udev/HOOKS="base udev plymouth/' /etc/mkinitcpio.conf
    sed -i 's/encrypt filesystems/plymouth-encrypt filesystems/' /etc/mkinitcpio.conf
    #change grub config to show plymouth
    sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash/' /etc/default/grub
    sudo mkinitcpio -P
    sudo update-grub
fi


#fix the font of plymouth not being visible of the manjaro theme
sed -i 's/_//' /usr/share/plymouth/themes/manjaro/manjaro.plymouth
#set the manjaro theme as default
plymouth-set-default-theme -R manjaro
