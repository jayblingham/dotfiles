# Jay's Notes for Installing Arch Linux

This quick guide will explain how I install Arch.  This is by no means a comprehensive guide, but instead what works for me.

Follow these steps at your own risk.  I am not responsible for any damage you do to your system, or it's configuration.

## Prerequisites

1. A CD, DVD, or USB with a bootable copy of Arch Linux (I use a USB with Ventoy).  This guide will not cover creating your boot medium.
2. A laptop, desktop or Virtual machine onto which you want to install Arch and only Arch. **This does not cover dual booting!**
3. Patience.  Things may not work exactly as I explain them here, or your hardware may be different, or any countless number of things can go wrong.  This procedure is by no means difficult, but could require troubleshooting if something isn't quite right.  Proceed with caution, and at your own risk.

## Installation

### Boot into Arch Linux
1. With your boot medium inserted, reboot your system and push whatever button brings up your boot menu. (Some may not have a boot menu, and will have to go into the BIOS and override or re-order their drives).
2. Once the boot completes, you will be presented with some text and a prompt that looks like this: **root@archiso ~ #**

### Configure Wifi (if applicable)

1. If you plan to use wifi continue to the next step.  If you only plan to use a wired connection (or you're using a Virtual Machine) skip to the next section.
2. On the command line type **iwctl** and press **ENTER**.  This will start the wifi configuration utility and your prompt will change to **[iwd]#**
3. Now type **device list** and press **ENTER**
4. If you see a device listed, take note of the device name and move to the next step.  If you don't, your wifi card may not be compatable.  Additional research will be required.
5. To start a scan of the available wifi networks type **station wlan0 scan**, replacing wlan0 with your device name if different.  Nothing will output to the screen, but the scan will start.
6. To see the SSIDs found during the scan type **station wlan0 get-networks**
7. Ensure you see your SSID in the list.  If not, you may have to perform some additional troubleshooting.
8. If you see yours in the list, connect to it by typing the following **station wlan0 connection NetworkName** replacing wlan0 with your device name, and NetworkName with your SSID, and press **ENTER**.
9. Enter your passphrase (wifi password) and press **ENTER**.  If successful, you will not see any output.
10. At the [iwd]# prompt, type **exit** and hit **ENTER**

### Verify that you are connected to the internet
1. Type **ping google.com**
2. If you receive a ping response, you are connected to the internet.
3. If you do not receive a ping response, try pinging some other well-known websites.  If you still don't get a ping response you may have an issue with your networking and will need to try again, or perform some troubleshooting or research.
4. To stop the ping, press **control + c**

### Start Archinstall
Note: Yes, I use Archinstall.  Some people will say this is not the *traditional* way of installing Arch Linux.  I disagree, it is simply the easier way.  I don't believe in making things more difficult than they need to be just to prove that I can do it.

1. Once all of the above has been completed, and is successful, type **archinstall** on the command line and press **ENTER**
2. The system will process for a few seconds while it verifies connectivity to the internet, and will then download and present the installer.

### Installation Options

On the left side of the screen you will see a list of options, and on the right you'll see a space where you can make changes to configuration for each option.  

You navigate the left hand side by using the **up and down arrow keys**, and when you want to edit an item you hit **ENTER** which will activate the right hand screen.  To exit without saving your changes, press **ESC**.  To save a change you've made, hit **ENTER**.

Let's dive into how *I* configure Arch.

### Arch Configuration

* Archinstall language
    ....* I leave this set to English

* Locales
    ....* Even though I'm in Canada, I still leave this as us for simplicity.

* Mirrors and repositories
    ....* First, I change my region to **Canada** to update the mirror lists.
    ....* Next I go into **Optional repositores** and enable **multilib**.

* Disk configuration
    ....* If you have a single disk, or are not familiar with Linux disk partitioning, I would suggest choosing the option to **Use a best-effort default partition layout**.
    ....* Select the disk that you want to use as your primary disk for Arch (be careful not to select your USB drive).
    ....* You can choose whatever filesystem you like, but if you're unsure choose ext4.
    ....* For the purposes of this guide, we'll say **No** to the question about using a separate /home partition.
    ....* There are options in here for Disk encryption, which I typically use, but I will let you explore that for yourself.  It is not required, and not in scope of this tutorial.

* Swap
    ....* No change.

* Bootloader
    ....* No change.

* Kernels
    ....* No change.

* Hostname
    ....* Change the hostname to whatever you want it to be.  This will be your computer name on the network, and will show up in your bash prompt.

* Authentication
    ....* Change the **Root password** to something secure that you'll remember.
    ....* Under **User account**, **add a user**, give it a name and a password, and when asked if it should be a **superuser (sudo)** choose **yes**.
    ....* Create as many users as you'll need, and then choose **Confirm and exit**

* Profile
    ....* Assuming that you'll wanting to use Hyprland to use my [dotfiles](README.md) you'll want to choose a **type** of **Desktop** and select **Hyprland**, **XFce4** and **KDE Plasma** from the list. (I use components from all 3)
    ....* When asked about **Seat access**, choose **polkit**.
    ....* Under **Graphics driver** choose the appropriate driver for the graphics chip you have in your computer.
    ....* Under **Greeter** I use **ly** which is very minimal.  If you want something more graphical, leave the default of **sddm**.

* Applications
    ....* No change (we install applications later)

* Network configuration
    ....* If your network is working properly, you can just select **Copy ISO network configuration to installation**.  Otherwise, you may want a network manager - but you'll have to research which one and how to use it.

* Additional packages
    ....* No change

* Timezone
    ....* Choose the timezone you are in.

* Automatic time sync (NTP)
    ....* No change.  We want it to be **Enabled** so that our computer's time is updated automatically from the internet.

Once the above is completed, you can now highlight **Install** and hit **ENTER**.  When asked if you'd like to continue, select **YES**

**NOTE**: This will overwrite whatever drive you selected in the step above.  Be warned, and be careful.

### Final Reboot

Once the installtion has completed, you will be asked what you would like to do next.

Choose **Reboot system** to reboot into your newly install Arch Installation.

You can now proceed with my software installation and dotfiles configuration [HERE](README.md)

