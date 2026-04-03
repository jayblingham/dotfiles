#!/bin/bash

dotfiles_location="$HOME/dotfiles"
basedir="$HOME/.config"

# 1. Update the local repository first
git clone https://github.com/jayblingham/dotfiles.git

# 2. Restore bashrc
cp "$dotfiles_location/bashrc/.bashrc" "$HOME/.bashrc"

# 3. Restore config folders
configs=("hypr" "kitty" "nvim" "rofi" "kate" "swaync" "waybar")

for folder in "${configs[@]}"; do
    if [ -d "$dotfiles_location/$folder" ]; then
        # Ensure the destination parent directory exists
        mkdir -p "$basedir"
        
        # Sync from dotfiles repo TO local config
        rsync -a --delete "$dotfiles_location/$folder/" "$basedir/$folder/"
        echo "Restored $folder"
    fi
done

# 4. Restore wallpaper
if [ -d "$dotfiles_location/wallpaper" ]; then
    rsync -a "$dotfiles_location/wallpaper/" "$HOME/wallpaper/"
fi
