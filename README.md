# Update Kubuntu at shutdown and startup (with plymouth integration)
  THIS SCRIPT IS ONLY(!) THOUGHT FOR KUBUNTU INSTALLATIONS
  AND NOTHING ELSE!  IT WILL NOT WORK AS INTENDED OR MAKE
  THE SYSTEM UNUSABLE ON OTHER INSTALLATIONS!
  USE AT YOUR OWN RISK!

  This script will install my custom script to update your
  system when it's being shutdown. It is tested on Kubuntu
  21.04 and 21.10, but should work with future versions as
  well.

  The script requires root privileges to copy the
  files to the corresponding locations. Please note that
  in file plasma-shutdown the <root-password> needs to be
  specified in order for the script to work! If you
  haven't done this before executing this file, you need
  to edit it and execute this script again.

  This script also includes a service that updates your
  flatpak and snap packages at startup."

  The installer will also activate a plymouth theme,
  in order for the script to show the progress of
  updates properly (Don't worry if you don't know
  what plymouth is, the script handles it).
  
  The updates are only executed at shutdown, not at reboot.

# INSTALLATION:

  1. Clone this Repository & extract the zip
  
  2. make install.sh executable (right click on the file
  -> properties -> permissions tab -> "is executable"
  
  3. replace root-password in plasma-shutdown with your root password

  4. start install.sh

  That's it! Enjoy!
  
# Contribution
  I'm open and welcome contributions to make this script better and/or available to more distributions.
  Currently, the script is quite hacky as it is not using the offline-update service, but a custom
  solution and the progress bar is not really good as well.
  If you know a better approach, feel free to open a pull request!
  
  Should you encounter any issue, please open an issue. Use at your own risk!
  
  You can tip me anytime via paypal: https://paypal.me/tobiasgoergens :)
