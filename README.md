# dotfiles

## Disclaimer

These are my dotfiles that I've customized for my own use, and uploaded to GitHub to make my life easier when re-installing my system.

I've added these here mostly for my own ease of use, but wanted to allow others to use them as an example configuration, or starting configuration.

I do not guarantee in any way that these files are free from error, or that they won't cause you issues on your own system.

Use these files at your own risk.

## Prerequisites:

These files were created on an Arch Linux system running Hyprland. In order to ensure that everything works, I recommend starting here to review or use my [Arch with Hyprland Installation Guide](ARCHINSTALL.md)

## Install git and clone the repo

You will first need to install git and clone my dotfiles repo.  This will download all the files you need to successfully use this configuration.

    ```
    sudo pacman -S --needed git --noconfirm
    ```
Once git is installed, you can clone the repo using the following commands.

    ```
    cd ~
    git clone http://github.com/jayblingham/dotfiles.git
    ```
You are now ready to contiue with the installation.

## Software Installation

If you want to install these on an Arch/Hyprland system, you must first use the **installSoftware.sh** script located in the **~/dotfiles/** directory.

#### This will perform the following actions:

1. Update your system using **pacman -Syu**
2. Install required development packages: **base-devel**
3. Install YAY from AUR if not already installed.
4. Install required software.
5. Ask you about optional software. (In order to ensure my config works for you, choose **YES** for **Google-Chrome**)

**NOTE*: 
    - If you are asked about **"Packages to CleanBuild"** or **"Diffs to Show"**, just hit enter.
    - If you are asked if you want to **"Remove make dependancies after install"**, choose **y**

## Install the dotfiles

Once the software has successfully installed, run the **restoreDotfiles.sh** script.  This will first backup your existing configuration files into **~/dotfiles/backup/**, and then copy the new configuration files to the appropriate directory.

** DO NOT REBOOT **

You must update some hyprland configuration files to ensure that everything works as expected after reboot.

#### Identify Monitors:

1. Open a terminal and run the command: **hyprctl monitors**
2. Scroll to the top of the output, and look for any lines that start with **Monitor**.
3. Record the text directly next to it. ie. HDMI-A-1, DP-1
    i. If you only have one monitor, you will only see one.  Multiple monitors, multiple.
4. Still in the terminal, change directory into **~/.config/hypr**
5. Using your favourite text editor (nano, vim, nvim) open **hyprland.conf** for editing.
6. In the section called **MONITORS**, you'll see my 3 monitors.  If you only have a single monitor, comment out the 2nd and 3rd lines. Update the 1st line with your monitor entry to include the name you recorded, it's max resolution, and max refresh rate.
    i. **monitor=HDMI-A-1,1920x1080@60,0x0,1**
7. If you have more than one monitor, you need to calculate the dimensions.  This is too much detail to include in this README, but I will show an example of my 3 monitor configuration and the rest you should be able to search out online.  If you have two 1080p monitors, you can comment out the 3rd line, if you have three, you can use all three.  ** You must update the monitor name as found in step 3, and the appropriate refresh rate for each of your monitors. **

    ```
    monitor=HDMI-A-2,1920x1080@180,0x0,1
    monitor=DP-1,1920x1080@144,1920x0,1
    monitor=HDMI-A-1,1920x1080@180,284x0,1
    ```

8. Once you've completed the monitor config, save and close the file.
9. Next, open the **hyprpaper.conf** file.
10. Even if you don't yet have a custom wallpaper selected, it's best to update this file for when you do.
11. Much like the hyprland.conf file, udpate the monitor name to match your monitor.
12. Depending on how many monitors you have, you will want to remove wallpaper sections to match that number.
13. Save and exit the file once done updating.
14. Finally, change to the following directory **~/.config/waybar/**
15. Open the **config.jsonc** file in your text editor for editing.
16. At the top, you'll see a line that starts with the word **output**.
17. Update this line with the name of the monitor that you want the waybar (status bar) to appear on.

Once you've completed those steps, reboot to ensure that your monitors are working properly, and that waybar appears at the top of the screen.  Not all of waybar's functions may be working immediately.  I'll add a troubleshooting section for those below.

**Note**: You may need to reorder your monitors in the **~/.config/hypr/hyprland.conf** file, if you find they are not in the correct order.

#### Must Know Keyboard Shortcuts

If this is your first time using Hyprland, you'll need to know a few keyboard shortcuts to be able to get around.  

In the list below the **"Super"** key refers to what is typically the **"Windows"** key on your keyboard.

**Super+q** = Open a terminal (Kitty)
**Super+c** = Close selected window/application
**Super+m** = Log out
**Super+e** = File Manager (works only if you've also installed KDE Plasma and XFce4)
**Super+v** = Toggle floating window (same key combo to switch it back)
**Super+r** = Open app menu
**Super+w** = Web Browser (Google Chrome, only once installed)
**Super+PrtScr** = Screenshot current window
**Shift+PrtScr** = Screenshot selection
**Super+l** = Lock workstation
**Super+p** = Show copy/paste clipboard
**Super+1** = Switch to workspace 1 (use other numbers to switch to different monitors or create virtual workspaces)
**Super+Shift+1** Move currently selected app to workspace 1. (use other numbers to switch app to different monitors or virtual workspaces)

There are other keybinds that you can find in the **keybindings** section of the **~/.config/hypr/hyprland.conf** file, or you can modify/add your own.

#### Troubleshooting Waybar Plugins

* Update Waybar Temperature config to point to correct CPU temp file
    * Go to **/sys/class/hwmin/hwmon#**
    * Check temp#_label to find CPU or CPU package.
    * Find the temp#_input file associated with the CPU label.
    * Update the path in **~/.config/waybar/config.jsonc**

* Update Waybar Weather config to point to correct city
    * Update **~/.config/waybar/config.jsonc**
    * Change the city information using the format **'City, Province/State, Country'
    * The single quotes are required.

### Other Distributions

If you are trying to use these on a different distribution of Linux, you'll instead want to manually copy the configuration from each folder, into the appropriate location for your distro.

## Backup

The **backupDotfiles.sh** script will copy the configuration from each of the folders listed into a folder called ~/dotfiles.  Unless you create your own github account/repository and add it to that location, the git commands will fail. Setting up a git repo is out of scope for this document.
