#!/bin/sh
systemctl disable update_startup.service
systemctl disable update_shutdown.service
rm -rf mkdir /usr/share/services/
rm /etc/systemd/system/update_shutdown.service
rm /etc/systemd/system/update_startup.service
systemctl daemon-reload
