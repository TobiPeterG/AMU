# Update Manjaro at shutdown and startup (with plymouth integration)
  THIS SCRIPT IS ONLY(!) THOUGHT FOR MANJARO-BASED INSTALLATIONS
  AND NOTHING ELSE!  IT WILL NOT WORK AS INTENDED OR MAKE
  THE SYSTEM UNUSABLE ON OTHER INSTALLATIONS!
  USE AT YOUR OWN RISK!
  
  This script will install my custom script to update your
  system when it's being shutdown. It is tested on Manjaro 21.1.6, but should
  work on future versions as well.

  The script requires root privileges to copy the
  files to the corresponding locations.

  This script also includes a service that updates your
  flatpak and snap packages at startup.

  In order for the script to work, you need to install Plymouth
  using the installation guide here:
  https://wiki.manjaro.org/index.php/Plymouth
  A step-by-step explanation on what to do is also given down below!
  
  The updates are only executed at shutdown, not at reboot.
  
# Features

  - automatically search for update at shutdown
  - update at shutdown only, not at reboots
  - use systemd to stay compatible over system updates
  - integration with all Manjaro flavors
  - graphical integration with progress bars
  - updates your flatpak and snap packages at startup
  - independant of the desktop environment
  - logs are saved at /var/log/manjaro-automatic-update/

# Known Issues
  - Automatically updating the system is not recommended and can
    potentially break your system!
    Do not expect help in the official forum should this script break your system!
# Pictures

  ![Installing Updates](https://user-images.githubusercontent.com/19935382/142771245-d5674862-350c-432b-868b-690527afcff9.png)
  
# Installation of Plymouth
  1. Type in the terminal: ```pamac install plymouth plymouth-theme-manjaro```
  
  2. Add ```plymouth``` to the ```HOOKS``` array in ```mkinitcpio.conf```.
  
     It must be added after ```base``` and ```udev``` for it to work:
  
     - Open ```/etc/mkinitcpio.conf``` with ```sudo nano /etc/mkinitcpio.conf```
     
     - The line looks like this afterwards: ```HOOKS="base udev plymouth ..."```
  3. Make the manjaro theme the default plymouth theme:
     - Type in your terminal: ```plymouth-set-default-theme -R manjaro```
  
  4. Edit the ```grub config```:
     - Type in your terminal: ```sudo nano /etc/default/grub```
     - add the word ```splash``` to the list of arguments for the following line:
     
       ```GRUB_CMDLINE_LINUX_DEFAULT="quiet splash ..."```
  5. Update grub:
     - Type in your terminal: ```sudo update-grub```
  
# INSTALLATION

  0. Install Plymouth (see above)

  1. Clone this Repository & extract the zip
  
  2. make install.sh executable (right click on the file
  -> properties -> permissions tab -> "is executable"

  3. start install.sh
  
  That's it! Enjoy!
  
# REMOVAL
  
  1. make uninstall.sh executable (right click on the file
  -> properties -> permissions tab -> "is executable"
  
  2. start uninstall.sh

  3. reboot
  
  After that, updates should not be applied at shutdown anymore
  
# Contribution
  I'm open and welcome contributions to make this script better and/or available to more distributions.
  Currently, the script is quite hacky as it is not using the offline-update service, but a custom
  solution and the progress bar is not really good as well.
  If you know a better approach, feel free to open a pull request!
  
  Should you encounter any issue, please open an issue. Use at your own risk!
  
  You can tip me anytime via paypal: https://paypal.me/tobiasgoergens :)
