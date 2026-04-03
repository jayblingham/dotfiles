#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "--- Starting System Update and Base Installs ---"
sudo pacman -Syu --noconfirm
sudo pacman -S --needed git base-devel --noconfirm

# Install yay if not present
if ! command -v yay &> /dev/null; then
    echo "--- Installing yay (AUR Helper) ---"
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
fi

echo "--- Installing Core Software Suite ---"
yay -S --needed hypridle hyprlock hyprpaper waybar swaync rofi hyprshot wttrbar \
nerd-fonts-noto-sans-mono ttf-font-awesome ttf-cascadia-code-nerd \
noto-fonts-emoji ttf-jetbrains-mono-nerd pavucontrol onedrive-abraunegg \
onedrivegui discord libreoffice-fresh google-chrome gimp vlc fastfetch \
keepassxc thunderbird spotify gwenview bluez bluetooth-manager \
webcamize power-profiles-daemon rsync

# Function to handle conditional installs
ask_install() {
    read -p "$1 (y/n): " choice
    case "$choice" in 
      y|Y ) yay -S --needed "$2";;
      n|N ) echo "Skipping $2...";;
      * ) echo "Invalid input, skipping...";;
    esac
}

echo "--- Optional Components ---"

# Will you be using a streamdeck on this pc?
ask_install "Will you be using a Stream Deck on this PC?" "opendeck"

# Does this PC have RGB?
ask_install "Does this PC have RGB lighting?" "openrgb"

# Will you be gaming on this PC?
ask_install "Will you be gaming on this PC?" "steam lutris"

# Will you be using this PC for work?
ask_install "Will you be using this PC for work?" "microsoft-edge-stable-bin"

echo "--- Installation Complete! ---"
