#!/bin/bash

dotfiles_location="$HOME/dotfiles"
backup_location="$HOME/dotfiles/backup"
basedir="$HOME/.config"

# 1. Backup destination directories in case of issues


# Create the backup directory if it doesn't exist
mkdir -p "$backup_location"

# Back up wallpaper
cp -R "$wallpaper_location" "$backup_location"
echo "Successfully backed up $wallpaper_location"

# Back up bashrc
cp "$HOME/.bashrc" "$backup_location/bashrc"
echo "Successfully backed up .bashrc"

# Back up config directories using a loop
configs=("hypr" "kitty" "nvim" "rofi" "kate" "swaync" "waybar" "rclone")
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
configs=("hypr" "kitty" "nvim" "rofi" "kate" "swaync" "waybar" "rclone")

for folder in "${configs[@]}"; do
    if [ -d "$dotfiles_location/$folder" ]; then
        # Ensure the destination parent directory exists
        mkdir -p "$basedir"
        
        # Sync from dotfiles repo TO local config
        rsync -a --delete "$dotfiles_location/$folder/" "$basedir/$folder/"
        echo "Restored $folder"
    fi
done

# 3a. Restore Systemd User Services
# We handle this separately to ensure the path is correct for systemd
if [ -d "$dotfiles_location/systemd/user" ]; then
    mkdir -p "$HOME/.config/systemd/user"
    rsync -a "$dotfiles_location/systemd/user/" "$HOME/.config/systemd/user/"
    echo "Restored Systemd user services"
fi

# 4. Restore wallpaper
if [ -d "$dotfiles_location/wallpaper" ]; then
    rsync -a "$dotfiles_location/wallpaper/" "$HOME/wallpaper/"
fi

# 5. Enable and Start the FTP Mount
echo "--- Activating Services ---"
if [ -f "$HOME/.config/systemd/user/rclone-ftp.service" ]; then
    # Reload to ensure systemd sees the newly copied file
    systemctl --user daemon-reload
    
    # Enable and start the service
    # We check if the secret file exists first to avoid a failed status
    if [ -f "$HOME/.config/rclone/ftp-secret.env" ]; then
        systemctl --user enable --now rclone-ftp.service
        echo "rclone FTP mount activated."
    else
        echo "Note: ftp-secret.env not found. Service restored but not started."
        echo "Please run your installation script or create the .env file manually."
    fi
fi
