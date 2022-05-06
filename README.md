# AMU - Automatic Manjaro Updater
  THIS SCRIPT IS ONLY(!) THOUGHT FOR MANJARO-BASED INSTALLATIONS
  AND NOTHING ELSE!  IT WILL NOT WORK AS INTENDED OR MAKE
  THE SYSTEM UNUSABLE ON OTHER INSTALLATIONS!
  USE AT YOUR OWN RISK!
  POWER LOSS DURING UPDATES CAN LEAVE THE SYSTEM IN AN UNBOOTABLE STATE!
  
  
  This script will install my custom script to update your
  system when it's being shutdown. It is tested on Manjaro 21.1.6, but should
  work on future versions as well.

  The script requires root privileges to copy the
  files to the corresponding locations.

  This script also includes a service that updates your
  flatpak and snap packages at startup.
  
  __Pamac (the default package manager of Manjaro) is used to update the system!__
  
  The updates are only executed at shutdown, not at reboot.
  
# Features

  - automatically search for updates at shutdown
  - update at shutdown only, not at reboots
  - use systemd to stay compatible over system updates
  - integration with all Manjaro flavors
  - graphical integration with progress bars
  - updates your flatpak and snap packages at startup
  - independant of the desktop environment
  - logs are saved at /var/log/manjaro-automatic-update/
  - log management to keep the 15 newest logs
  - only apply updates when battery is charged to >90% (notebook only)
  - installable using live system or existing system
  - automatic plymouth installation
  - backup existing configuration
  - works with encrypted drives

# Known Issues
  - __updating with a wifi connection might not work__ as the connection to the wifi network is closed after logging out. __To fix it__, go to the __network  settings__ of your wifi network and check the checkbox to __allow all users to connect to the network__. Updates should work now when connected to this wifi
  - if installed in a live environment, you have to know the name of the partition you installed Manjaro onto
  - Automatically updating the system is not recommended and can
    potentially break your system!
    Do not expect help in the official forum should this script break your system!
    
# Pictures

  ![Installing Updates](https://user-images.githubusercontent.com/19935382/142771245-d5674862-350c-432b-868b-690527afcff9.png)
  
  
# INSTALLATION

  1. Clone this Repository & extract the zip
  
  2. optional: replace ```shutdown_update``` with ```shutdown_update_GERMAN``` in the ```files``` folder
  
  3. make install.sh executable (right click on the file
  -> properties -> permissions tab -> "is executable")

  4. start install.sh

  5. follow instructions
  
  That's it! Enjoy!
  
# REMOVAL
  
  1. make uninstall.sh executable (right click on the file
  -> properties -> permissions tab -> "is executable")
  
  2. start uninstall.sh

  3. reboot
  
  After that, updates should not be applied at shutdown anymore
  
# TODO
  ~~- only apply updates when connected to power AND battery is over 50% charged~~ DONE
  
  ~~- Make installer work with different terminals~~ DONE
  
# Contribution
  I'm open and welcome contributions to make this script better and/or available to more distributions.
  Currently, the script is quite hacky as it is not using the offline-update service, but a custom
  solution.
  If you know a better approach, feel free to open a pull request!
  
  __Should you encounter any problem, please open an issue. Use at your own risk!__
  
  You can tip me anytime via paypal: https://paypal.me/tobiasgoergens :)
