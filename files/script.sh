#!/bin/sh
#show warning and wait for user to hit enter or abort installation
echo -e "This script will install my custom script to\nupdate your system when it's being shutdown.\nIt is tested on Manjaro 21.1.6, but should work\nwith future versions as well.\n\nThe script requires root privileges to copy the files to the\ncorresponding locations.\n\nThis script also includes a service that updates your\nflatpak and snap packages at startup."
printf 'press [ENTER] to continue, [CTRL]+[C] to abort...'
read _

fun_chroot() {

    script_folder=${PWD##*/}
    read -p 'What is the path of the installed system? ' install_path
    mount -o subvol=@,ssd,noatime,space_cache,commit=120,compress=zstd $install_path /mnt
    cp -r $PWD /mnt/tmp
    for i in /dev /dev/pts /proc /sys /run; do sudo mount -B $i /mnt$i; done
    chroot /mnt
    script_path=/mnt/tmp/${script_folder}
}

fun_install() {

    #create required folders, copy files to correct location, make scripts executable
    cd ${script_path}/files
    mkdir /usr/share/services/
    mkdir /var/log/manjaro-automatic-update/
    cp ${script_path}/shutdown_update /usr/share/services/shutdown_update
    cp ${script_path}/startup_update /usr/share/services/startup_update
    cp ${script_path}/update_shutdown.service /etc/systemd/system/update_shutdown.service
    cp ${script_path}/update_startup.service /etc/systemd/system/update_startup.service

    #the poweroff.target has to be modified to remove the timeout
    cp -r ${script_path}/poweroff.target.d /etc/systemd/system/

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


}



#chek if system is running in a live environment
if echo $(df -kh) |grep -q live; then
    echo -e "This system seems to be running in a live environment. Is this true? [Y/n]"
    read -p "" -n1 yn
    case $yn in
        [Yy]* ) fun_chroot && fun_install;;
        [Nn]* ) fun_install;;
        * ) fun_chroot && fun_install;;
    esac
else
    echo "This system seems to already be installed on your system. Is this true? [Y/n]"
    read -p "" -n1 yn
    case $yn in
        [Yy]* ) fun_install;;
        [Nn]* ) fun_chroot && fun_install;;
        * ) fun_install;;
    esac
fi
