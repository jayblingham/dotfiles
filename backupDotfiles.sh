#!/bin/bash

# Define locations
dotfiles_location="$HOME/dotfiles"
wallpaper_location="$HOME/wallpaper/"
basedir="$HOME/.config"

# Create the dotfiles directory if it doesn't exist
mkdir -p "$dotfiles_location"

# Back up wallpaper
cp -R "$wallpaper_location" "$dotfiles_location"

# Back up bashrc
cp "$HOME/.bashrc" "$dotfiles_location/bashrc"

# Back up config directories using a loop
configs=("hypr" "kitty" "nvim" "rofi" "kate" "swaync" "waybar")

for folder in "${configs[@]}"; do
    if [ -d "$basedir/$folder" ]; then
        cp -R "$basedir/$folder" "$dotfiles_location/"
        echo "Backed up $folder"
    else
        echo "Warning: $basedir/$folder not found, skipping."
    fi
done

# Git Commands
cd "$dotfiles_location"
git add .
git commit -m "Update dotfiles: $(date +'%Y-%m-%d %H:%M:%S')"
git push origin main
