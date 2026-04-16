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
noto-fonts-emoji ttf-jetbrains-mono-nerd pavucontrol \
libreoffice-fresh gimp vlc fastfetch \
gwenview bluez bluetooth-manager \
power-profiles-daemon rsync archlinux-xdg-menu

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

# Do you want to use OneDrive?
ask_install "Do you want to use OneDrive?" "onedrive-abraunegg onedrivegui"

# Do you want to use Discord?
ask_install "Do you want to use Discord?" "discord"

# Will you be using a streamdeck on this pc?
ask_install "Will you be using a Stream Deck on this PC?" "opendeck"

# Does this PC have RGB?
ask_install "Does this PC have RGB lighting?" "openrgb"

# Will you be gaming on this PC?
ask_install "Will you be gaming on this PC?" "steam lutris"

# Do you want to install Thunderbird for email?
ask_install "Do you want to install Thunderbird for email?" "thunderbird"

# Do you want to install keepassxc?
ask_install "Do you want to install keepassxc?" "keepassxc"

# Do you want to install Spotify?
ask_install "Do you want to install Spotify?" "spotify"

# Do you want to install Google Chrome?
ask_install "Do you want to install Google Chrome?" "google-chrome"

# Do you want to install Microsoft Edge?
ask_install "Do you want to install Microsoft Edge?" "microsoft-edge-stable-bin"

# Will you be using a webcam?
ask_install "Will you be using a webcam?" "webcamize"

echo "--- Installation Complete! ---"
