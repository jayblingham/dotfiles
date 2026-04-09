#!/bin/bash

dotfiles_location="$HOME/dotfiles"
backup_location="$HOME/dotfiles/backup"
basedir="$HOME/.config"

# 1. Backup destination directories in case of issues


# Create the backup directory if it doesn't exist
mkdir -p "$backup_location"

# Back up wallpaper
cp -R "$wallpaper_location" "$backup_location"

# Back up bashrc
cp "$HOME/.bashrc" "$backup_location/bashrc"

# Back up config directories using a loop
configs=("hypr" "kitty" "nvim" "rofi" "kate" "swaync" "waybar")

for folder in "${configs[@]}"; do
    if [ -d "$basedir/$folder" ]; then
        # --delete ensures your backup matches your actual config exactly
        # -a (archive) preserves permissions and timestamps
        rsync -a --delete "$basedir/$folder/" "$backup_location/$folder/"
        echo "Successfully backed up $folder"
    fi
done

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
