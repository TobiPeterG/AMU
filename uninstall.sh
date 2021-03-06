#!/bin/sh
#disable installed services and remove all files and folders that were created by the installer
systemctl disable update_startup.service
systemctl disable update_shutdown.service
rm -rf /usr/local/bin/update_shutdown
rm -rf /usr/local/bin/update_startup
rm /etc/systemd/system/update_shutdown.service
rm /etc/systemd/system/update_startup.service
rm -rf /etc/systemd/system/poweroff.target.d
systemctl daemon-reload
