#!/bin/bash

# Define locations
dotfiles_location="$HOME/dotfiles"
wallpaper_location="$HOME/wallpaper/"
basedir="$HOME/.config"
systemd_user_dir="$HOME/.config/systemd/user"

# Create the dotfiles directory if it doesn't exist
mkdir -p "$dotfiles_location"

# Back up wallpaper
cp -R "$wallpaper_location" "$dotfiles_location"

# Back up bashrc
cp "$HOME/.bashrc" "$dotfiles_location/bashrc"

# Back up rclone and systemd setup (Publicly safe)
echo "Backing up rclone and systemd logic..."
mkdir -p "$dotfiles_location/systemd/user"
if [ -f "$systemd_user_dir/rclone-ftp.service" ]; then
    cp "$systemd_user_dir/rclone-ftp.service" "$dotfiles_location/systemd/user/"
fi

# Sync rclone configs but EXCLUDE the secret environment file
# This prevents your FTP password from being pushed to GitHub
if [ -d "$basedir/rclone" ]; then
    rsync -a --delete --exclude='*-secret.env' "$basedir/rclone/" "$dotfiles_location/rclone/"
fi

# Back up config directories using a loop
configs=("hypr" "kitty" "nvim" "rofi" "kate" "swaync" "waybar")

for folder in "${configs[@]}"; do
    if [ -d "$basedir/$folder" ]; then
        # --delete ensures your backup matches your actual config exactly
        # -a (archive) preserves permissions and timestamps
        rsync -a --delete "$basedir/$folder/" "$dotfiles_location/$folder/"
        echo "Successfully synced $folder"
    fi
done

# Git Commands
cd "$dotfiles_location"

# Ensure a .gitignore exists so secrets never leak even if copied
if [ ! -f ".gitignore" ]; then
    echo "**/*-secret.env" > .gitignore
fi

git add .
git commit -m "Update dotfiles: $(date +'%Y-%m-%d %H:%M:%S')"
git push origin main
