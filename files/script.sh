#!/bin/sh
#show warning and wait for user to hit enter or abort installation
echo -e "This script will install my custom script to\nupdate your system when it's being shutdown.\nIt is tested on Manjaro 21.1.6, but should work\nwith future versions as well.\n\nThe script requires root privileges to copy the files to the\ncorresponding locations.\n\nThis script also includes a service that updates your\nflatpak and snap packages at startup."
printf 'press [ENTER] to continue, [CTRL]+[C] to abort...'
read _

fun_chroot() {

    script_folder=${PWD##*/}
    read -p 'What device is your system installed on (e.g. /dev/sda1)? ' system_device
    device_uuid=luks-$(blkid -o value -s UUID $system_device)

    if cryptsetup luksOpen $system_device $device_uuid
    then
        system_device=/dev/mapper/$device_uuid
    fi

    if [ $(lsblk -no FSTYPE $system_device) = "btrfs" ]
    then
        mount -o subvol=@,ssd,noatime,commit=120,compress=zstd $system_device /mnt
    else
        mount $system_device /mnt
    fi

    for i in /dev /dev/pts /proc /sys /run; do sudo mount -B $i /mnt$i; done
    cp -r $PWD /mnt/tmp
    chroot /mnt /bin/sh /tmp/${script_folder}/.install.sh /tmp/${script_folder}
}

#chek if system is running in a live environment
if echo $(df -kh) |grep -q live; then
    echo -e "This system seems to be running in a live environment (e.g. booted from USB or CD). Is this true? [Y/n]"
    read -p "" -n1 yn
    case $yn in
        [Yy]* ) fun_chroot;;
        [Nn]* ) sh .install.sh ".";;
        * ) fun_chroot;;
    esac
else
    echo "This system seems to already be installed on your PC. Is this true? [Y/n]"
    read -p "" -n1 yn
    case $yn in
        [Yy]* ) sh .install.sh ".";;
        [Nn]* ) fun_chroot;;
        * ) sh .install.sh ".";;
    esac
fi
