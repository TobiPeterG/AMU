# Update Ubuntu at shutdown and startup (with plymouth integration)
  THIS SCRIPT IS ONLY(!) THOUGHT FOR UBUNTU-BASED INSTALLATIONS
  AND NOTHING ELSE!  IT WILL NOT WORK AS INTENDED OR MAKE
  THE SYSTEM UNUSABLE ON OTHER INSTALLATIONS!
  USE AT YOUR OWN RISK!
  
  This script will install my custom script to update your
  system when it's being shutdown. It is tested on Kubuntu
  21.04 and 21.10, but should work with future versions as
  well.

  The script requires root privileges to copy the
  files to the corresponding locations.

  This script also includes a service that updates your
  flatpak and snap packages at startup."

  The installer will also activate a plymouth theme,
  in order for the script to show the progress of
  updates properly (Don't worry if you don't know
  what plymouth is, the script handles it).
  
  The updates are only executed at shutdown, not at reboot.
  
# Features

  - automatically search for update at shutdown
  - update at shutdown only, not at reboots
  - use systemd to stay compatible over system updates
  - integration with all common distributions
  - graphical integration with progress bars
  - automatically update from one Ubuntu version to another (e.g. 21.04 -> 21.10)
  - updates your flatpak and snap packages at startup
  - independant of the desktop environment

# Pictures

  Installing normal Updates:
  ![Installing normal Updates](https://user-images.githubusercontent.com/19935382/137891911-3862eeac-b4ca-47f0-be1f-7f735848db9b.png)
  
  Upgrading Ubuntu version:
  ![Upgrading Ubuntu version](https://user-images.githubusercontent.com/19935382/137891983-b8e5015e-8f56-4af0-97c1-1eb651490beb.png)

  
# INSTALLATION

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
