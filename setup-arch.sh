#!/usr/bin/env -S sh -c 'sudo pacman -S --needed --noconfirm gum git >/dev/null && exec bash "$@"' --

# Install required packages
install_packages() {
  local package_array=("$@")
  local total_packages=${#package_array[@]}
  local installed_count=0
  local failed_count=0
  local failed_packages=()

  echo "Starting installation of $total_packages packages..."
  echo "================================================"

  for package in "${package_array[@]}"; do
    echo "Installing package: $package"
    echo "----------------------------------------"

    # Check if package is already installed
    if yay -Q "$package" >/dev/null 2>&1; then
      echo "✓ Package $package is already installed"
      ((installed_count++))
      echo
      continue
    fi

    # Try to install the package
    if yay -S --noconfirm "$package"; then
      echo "✓ Successfully installed: $package"
      ((installed_count++))
    else
      echo "✗ Failed to install: $package"
      ((failed_count++))
      failed_packages+=("$package")
    fi

    echo
  done

  # Summary
  echo "================================================"
  echo "Installation Summary:"
  echo "Total packages: $total_packages"
  echo "Successfully installed: $installed_count"
  echo "Failed to install: $failed_count"

  if [ $failed_count -gt 0 ]; then
    echo "Failed packages:"
    for failed_pkg in "${failed_packages[@]}"; do
      echo "  - $failed_pkg"
    done
    echo
    echo "You can try to install failed packages individually later."
    return 1
  else
    echo "All packages installed successfully!"
    return 0
  fi
}

packages_common_utils=(
  # Core utils
  "pacman-contrib"
  "wget"
  "net-tools"
  "unzip"
  "unrar"
  "rsync"
  "brightnessctl"
  "bluez"
  "bluez-utils"
  "blueman"
  "iwd"
  "wireless_tools"
  # "rofi-bluetooth-git"
  "networkmanager"
  "networkmanager-dmenu"
  "network-manager-applet"
  "openvpn"
  "networkmanager-openvpn"
  "rofi-power-menu"
  "greetd"
  "greetd-regreet"
  "cage"
  "ntfs-3g"
  "upower"
  "bind"
  "man-db"
  "man-pages"
  "tealdeer"
  "downgrade"
  "reflector"
  "pkgfile"
  "gvfs"
  "gvfs-mtp"
  "gvfs-smb"
  "dkms"
  "archlinux-xdg-menu"
  # "ark"
  "ffmpegthumbnailer"
  "ffmpegthumbs"
  "sshpass"
  "wtype"
  "dosfstools"
  "exfatprogs"
  "cliphist"
  "zram-generator"

  # Audio utils
  "playerctl"
  "pavucontrol"
  "alsa-utils"
  "pipewire"
  "lib32-pipewire"
  "pipewire-pulse"
  "pipewire-alsa"
  "pipewire-jack"
  "pipewire-audio"
  "libpulse"
  "wireplumber"
  "sox"

  # Development
  "base-devel"
  "git"
  "git-lfs"
  "lazygit"
  "cmake"
  "meson"
  "ninja"
  "cpio"
  "go"
  "luarocks"
  "nodejs"
  "npm"
  "pnpm"
  "uv"
  "python-pipx"
  "python-gobject"
  "dart-sass"

  # Container management
  # "podman"

  # Shell & terminal utils
  "zsh"
  "fzf"
  "zoxide"
  "starship"
  "lsd"
  "plocate"
  "ripgrep"
  "bat"
  "bat-extras"
  "cava"
  "btop"
  "fastfetch"

  # Portals
  "xdg-desktop-portal-gtk"
  "xdg-desktop-portal-hyprland"

  # Dotfiles & ricing
  "stow"
  "nwg-look"
  "gtk4"
  "adw-gtk-theme"
  "bibata-cursor-theme"
  "tela-circle-icon-theme-dracula"
  "matugen"
  "rofi"
)

packages_common_x11=(
  "xorg"
  "xsel"
  "dex"
  "xdotool"
  "xclip"
  "xinput"
  "polybar"
  "dunst"
  "feh"
  "maim"
  "picom"
)

packages_common_wayland=(
  "qt5-wayland"
  "qt6-wayland"
  "egl-wayland"
  "wlr-randr"
  "wl-clipboard"
  "wl-clip-persist"
  # "rofi-wayland"
  "waybar"
  "mako"
  "awww"
)

packages_hyprland=(
  "hyprland"
  "hyprutils"
  "hyprpicker"
  "hyprpolkitagent"
  "hyprshot"
  "xdg-desktop-portal-hyprland"
  "hyprlock"
  "hypridle"
  "uwsm"
)

packages_niri=(
  "niri"
  "xwayland-satellite"
  "xdg-desktop-portal-gnome"
  "hyprlock"
)

packages_awesome=(
  "awesome"
  "lain"
  "polkit-gnome"
)

packages_i3=(
  "i3-wm"
  "i3lock"
  "autotiling"
)

packages_apps=(
  # Terminals
  "kitty"

  # Web browsers
  "firefox"
  "librewolf"

  # Text & hex editors
  "neovim"
  "vim"
  "nano"
  "zed"
  "ghex"
  "meld"

  # Media players & radios
  "mpd"
  "mpc"
  "rmpc"
  "mpv"
  "shortwave"
  "aimp"

  # File managers
  "nautilus"
  "yazi"

  # Password managers
  "secrets"

  # Readers & image viewers
  "foliate"
  "mcomix-git"
  "papers"
  "libreoffice-fresh"
  "obsidian"
  "loupe"

  # Messengers
  "discord"

  # Disk space visualizers
  "baobab"
  "ncdu"
  "gdu"

  # File transfer
  "filezilla"
  "syncthing"

  # Disk management & ISO writers
  "gnome-disk-utility"
  "gnome-multi-writer"

  # AI
  # "ollama-cuda"

  # Other
  "imagemagick"
  "transmission-gtk"
  "qalculate-gtk"
  "clock-rs-git"
  "czkawka-gui-bin"
  "yt-dlp"
  "youtube-dl-gui-bin"
  "spotdl"
)

packages_fonts=(
  "ttf-hack-nerd"
  "ttf-liberation"
  "ttf-dejavu"
  "ttf-opensans"
  "noto-fonts"
  "noto-fonts-extra"
  "noto-fonts-cjk"
  "noto-fonts-emoji"
  "otf-font-awesome"
)

packages_gaming=(
  "steam"
  "lutris"
  "umu-launcher"
)

packages_firmware=(
  "aic94xx-firmware"
  "ast-firmware"
  "linux-firmware-qlogic"
  "wd719x-firmware"
  "upd72020x-fw"
)

packages_nvidia=(
  "nvidia-open"
  "lib32-nvidia-utils"
  "nvidia-utils"
  "nvidia-settings"
  "libva-nvidia-driver"
)

set_variables() {
  choice_backup_hook=$(gum choose "No" "Yes" --header "Would you like to setup a pacman hook that creates a copy of the /boot directory?")
  choice_microcode=$(gum choose "None" "Intel" "AMD" --header "Would you like to install processor microcode?")
  choice_nvidia=$(gum choose "No" "Yes" --header "Would you like to install Nvidia drivers?")
  choice_wm=$(gum choose "hyprland" "niri" "awesome" "i3" --no-limit --header "Choose window managers to be installed.")
  choice_apps=$(gum choose "Yes" "No" --header "Would you like to install apps (browsers, file managers, terminal emulators, etc.)?")
  choice_gaming_tools=$(gum choose "No" "Yes" --header "Would you like to install gaming tools?")
  choice_dotfiles=$(gum choose "Yes" "No" --header "Would you like to install rouxshell?")
  choice_wallpapers=$(gum choose "Yes" "No" --header "Would you like to install Roux Wallpapers?")
}

setup_backup_hook() {
  case "$choice_backup_hook" in
  Yes)
    echo "→ Setting up pacman boot backup hook..."
    echo "→ Configuring /boot backup when pacman transactions are made..."
    sudo -i -u root /bin/bash <<EOF
mkdir -p /etc/pacman.d/hooks
echo "[Trigger]
Operation = Upgrade
Operation = Install
Operation = Remove
Type = Path
Target = usr/lib/modules/*/vmlinuz

[Action]
Depends = rsync
Description = Backing up /boot...
When = PostTransaction
Exec = /usr/bin/rsync -a --delete /boot /.bootbackup" > /etc/pacman.d/hooks/50-bootbackup.hook
EOF
    ;;
  No) echo "→ Skipping setup of pacman boot backup hook..." ;;
  esac
}

install_window_managers() {
  IFS = ', '
  for choice in "${choice_wm[@]}"; do
    case "$choice" in
    hyprland*)
      install_packages "${packages_hyprland[@]}"
      install_packages "${packages_common_wayland[@]}"
      ;;
    niri*)
      install_packages "${packages_niri[@]}"
      install_packages "${packages_common_wayland[@]}"
      ;;
    awesome*)
      install_packages "${packages_awesome[@]}"
      install_packages "${packages_common_x11[@]}"
      ;;
    i3*)
      install_packages "${packages_i3[@]}"
      install_packages "${packages_common_x11[@]}"
      ;;
    esac
  done
}

install_microcode() {
  case "$choice_microcode" in
  Intel)
    echo "→ Installing Intel microcode..."
    yay -S --needed --noconfirm intel-ucode
    ;;
  AMD)
    echo "→ Installing AMD microcode..."
    yay -S --needed --noconfirm amd-ucode
    ;;
  None) echo "→ Skipping installation of microcode..." ;;
  esac
}

install_nvidia_drivers() {
  case "$choice_nvidia" in
  Yes)
    echo "→ Installing Nvidia drivers..."
    install_packages "${packages_nvidia[@]}"
    ;;
  No) echo "→ Skipping installation of Nvidia drivers..." ;;
  esac
}

install_apps() {
  case "$choice_apps" in
  Yes)
    echo "→ Installing applications..."
    install_packages "${packages_apps[@]}"
    ;;
  No) echo "→ Skipping installation of apps..." ;;
  esac
}

install_gaming_tools() {
  case "$choice_gaming_tools" in
  Yes)
    echo "→ Installing gaming tools..."
    install_packages "${packages_gaming[@]}"
    ;;
  No) echo "→ Skipping installation of gaming tools..." ;;
  esac
}

setup_mpd() {
  [[ "$choice_apps" != "Yes" ]] && return 0

  mkdir -p $HOME/.local/share/mpd/playlists
  touch $HOME/.local/share/mpd/{database,state,sticker.sql}

  systemctl --user enable --now mpd.service
  mpc update
}

install_flatpaks() {
  flatpak install flathub com.github.tchx84.Flatseal --assumeyes
}

install_dotfiles() {
  if [[ "$choice_dotfiles" != "Yes" ]]; then
    echo "→ Skipping installation of rouxshell..."
    return 0
  fi

  echo "→ Installing rouxshell..."

  local repo_url="https://github.com/imroux/rouxshell.git"
  local target_dir="$HOME/.local/share/rouxshell"
  local wallpaper="$HOME/.local/share/backgrounds/resident-evil/resident-evil-9-requiem/requiem_2.jpg"

  # Handle existing repo directory safely
  if [[ -d "$target_dir/.git" ]]; then
    echo "→ Existing repository found, pulling latest changes..."
    git -C "$target_dir" pull --ff-only || return 1
    [[ "$choice_wallpapers" == "Yes" ]] && git -C "$target_dir" submodule update --init --recursive --depth 1
  else
    rm -rf "$target_dir"
    local clone_args=(--depth 1)
    [[ "$choice_wallpapers" == "Yes" ]] && clone_args+=(--recurse-submodules --shallow-submodules)
    git clone "${clone_args[@]}" "$repo_url" "$target_dir" || return 1
  fi

  # Stow dotfiles without altering the caller's working directory
  stow -d "$target_dir/home" -t "$HOME" --no-folding . || return 1
  sudo cp -r --no-preserve=ownership "$target_dir/system/." /

  # Apply wallpaper & matugen theme safely
  if command -v matugen >/dev/null 2>&1; then
    if [[ -f "$wallpaper" ]]; then
      if command -v awww-daemon >/dev/null 2>&1 && [[ -n "${WAYLAND_DISPLAY:-}" ]]; then
        pgrep -x awww-daemon >/dev/null || (awww-daemon >/dev/null 2>&1 & disown)
        sleep 0.5 # Give daemon a moment to create its Wayland socket
      fi
      matugen image "$wallpaper" --source-color-index 3
    else
      echo "⚠ Wallpaper not found at $wallpaper (skipping matugen theme generation)"
    fi
  fi

  # Optional post-install commands (guarded so missing tools don't crash the script)
  command -v bat >/dev/null 2>&1 && bat cache --build
  command -v tldr >/dev/null 2>&1 && tldr --update

  # if command -v flatpak >/dev/null 2>&1; then
  #   sudo flatpak override --filesystem=xdg-data/themes
  #   flatpak install -y flathub org.gtk.Gtk3theme.adw-gtk3 org.gtk.Gtk3theme.adw-gtk3-dark
  # fi

  if command -v gsettings >/dev/null 2>&1; then
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
  fi

  # Link user configs with root configs cleanly
  sudo mkdir -p /root/.config
  local root_links=(
    "home/.zshrc:/root/.zshrc"
    "home/.config/zsh:/root/.config/zsh"
    "home/.config/starship.toml:/root/.config/starship.toml"
    "home/.config/nvim:/root/.config/nvim"
  )
  for pair in "${root_links[@]}"; do
    local src="$target_dir/${pair%%:*}"
    local dest="${pair##*:}"
    [[ -e "$src" ]] && sudo ln -sfn "$src" "$dest"
  done
}


clear

cat <<"EOF"
 _____                                                                              _____
( ___ )----------------------------------------------------------------------------( ___ )
 |   |                                                                              |   |
 |   | ______                    ___           _       _____          _        _ _  |   |
 |   | | ___ \                  / _ \         | |     |_   _|        | |      | | | |   |
 |   | | |_/ /___  _   ___  __ / /_\ \_ __ ___| |__     | | _ __  ___| |_ __ _| | | |   |
 |   | |    // _ \| | | \ \/ / |  _  | '__/ __| '_ \    | || '_ \/ __| __/ _` | | | |   |
 |   | | |\ \ (_) | |_| |>  <  | | | | | | (__| | | |  _| || | | \__ \ || (_| | | | |   |
 |   | \_| \_\___/ \__,_/_/\_\ \_| |_/_|  \___|_| |_|  \___/_| |_|___/\__\__,_|_|_| |   |
 |___|                                                                              |___|
(_____)----------------------------------------------------------------------------(_____)
EOF

while true; do
  read -rp "Would you like to proceed with setup? (y/n): " answer
  case "$answer" in
  [Yy]*) break ;; # Proceed with the script
  *)
    echo "Exiting."
    exit 1
    ;; # Exit the script
  esac
done

# Create user folders
mkdir -p $HOME/Data
mkdir -p $HOME/.local/{bin,share/{backgrounds,themes,icons}}
mkdir -p $HOME/.config/{calibre,cava,gtk-3.0,gtk-4.0,'Code - OSS/User',zsh}

# Set global variables
set_variables

# Boot backup hook
setup_backup_hook

# Fix laptop lid acting like airplane mode key
echo "→ Fixing laptop lid acting like airplane mode key..."
sudo tee /etc/systemd/system/fix-lid-keys.service >/dev/null <<'EOF'
[Unit]
Description=Fix laptop lid keycodes

[Service]
Type=oneshot
ExecStart=/usr/bin/setkeycodes d7 240
ExecStart=/usr/bin/setkeycodes e058 142

[Install]
WantedBy=multi-user.target
EOF
# sudo -i -u root /bin/bash <<EOF
# mkdir -p /etc/rc.d
# echo "#!/usr/bin/env bash
# # Fix laptop lid acting like airplane mode key
# setkeycodes d7 240
# setkeycodes e058 142" > /etc/rc.d/rc.local
# EOF

# ZRAM configuration
echo "→ Configuring ZRAM..."
sudo tee /etc/systemd/zram-generator.conf >/dev/null <<'EOF'
[zram0]
zram-size = min(ram, 8192)
compression-algorithm = zstd
EOF

# Pacman eye-candy features
echo "→ Enabling colours and parallel downloads for pacman..."
sudo sed -Ei 's/^#(Color)$/\1/;s/^#(ParallelDownloads).*/\1 = 10/' /etc/pacman.conf

# Setup rust
echo "→ Installing Rust..."
sudo pacman -S --needed --noconfirm rustup
rustup default stable

# Install yay AUR Helper
if ! command -v yay >/dev/null 2>&1; then
  echo "→ Installing yay..."
  sudo pacman -S --needed --noconfirm base-devel
  rm -rf /tmp/yay
  git clone --depth 1 https://aur.archlinux.org/yay.git /tmp/yay || exit 1
  (
    cd /tmp/yay || exit 1
    makepkg -si --needed --noconfirm
  ) || exit 1
  rm -rf /tmp/yay
else
  echo "✓ Package yay is already installed"
fi


# Do an initial update
echo "→ Updating the system..."
yay -Syu --needed --noconfirm

# Install required packages
echo "→ Installing utility packages..."
install_packages "${packages_common_utils[@]}"

# Install window managers
install_window_managers

# Install fonts and missing firmware
echo "→ Installing fonts..."
install_packages "${packages_fonts[@]}"
echo "→ Installing potentially missing firmware..."
install_packages "${packages_firmware[@]}"

# Switch user and root shell to Zsh
echo "→ Switching user and root shell to Zsh..."
sudo chsh -s /usr/bin/zsh $USER
sudo chsh -s /usr/bin/zsh root

# Install processor microcode
install_microcode

# Setup Nvidia drivers
install_nvidia_drivers

# Install apps
install_apps

# Install gaming tools
install_gaming_tools

# Setup mandatory mpd folders and files
echo "→ Setting up MPD..."
setup_mpd
# Install flatpaks
# echo "→ Installing flatpaks..."
# sudo pacman -S --needed --noconfirm flatpak
# install_flatpaks

# Set right-click dragging to resize windows in GNOME
echo "→ Setting right-click dragging to resize windows in GNOME..."
gsettings set org.gnome.desktop.wm.preferences resize-with-right-button true

# Enable services
echo "→ Enabling systemctl services..."
systemctl --user enable pipewire.socket pipewire-pulse.socket wireplumber.service
if [[ "$choice_apps" == "Yes" ]]; then
  command -v syncthing >/dev/null 2>&1 && systemctl --user enable syncthing.service
fi
sudo systemctl enable greetd.service
sudo systemctl enable bluetooth
sudo systemctl enable fix-lid-keys.service
# sudo systemctl enable podman
# sudo systemctl enable ollama

# Install rouxshell
install_dotfiles || echo "⚠ Dotfiles installation encountered an error."

choice_reboot=$(gum choose "Yes" "No" --header "INSTALLATION IS COMPLETE. Would you like to reboot now?")
case "$choice_reboot" in
Yes)
  sudo reboot
  ;;
esac
