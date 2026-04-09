# dotfiles

## Disclaimer

These are my dotfiles that I've customized for my own use, and uploaded to GitHub to make my life easier when re-installing my system.

I've added these here mostly for my own ease of use, but wanted to allow others to use them as an example configuration, or starting configuration.

I do not guarantee in any way that these files are free from error, or that they won't cause you issues on your own system.

Use these files at your own risk.

## Prerequisites:

These files were created on an Arch Linux system running Hyprland. In order to ensure that everything works, I recommend the same configuration.

## Installation

If you want to install these on an Arch/Hyprland system, you can must first use the **installSoftware.sh** script.

Once the software has successfully installed, run the **restoreDotfiles.sh** script.

### This will perform the following actions:

1. Update your system using **pacman -Syu**
2. Install required development packages: **git and base-devel**
3. Install YAY from AUR if not already installed.
4. Install required software.
5. Ask you about optional software, and install.

### Other Distributions

If you are trying to use these on a different distribution of Linux, you'll instead want to manually copy the configuration from each folder, into the appropriate location for your distro.

## Backup

The **backupDotfiles.sh** script will copy the configuration from each of the folders listed into a folder called ~/dotfiles.  Unless you create your own github account/repository and add it to that location, the git commands will fail. Setting up a git repo is out of scope for this document.
