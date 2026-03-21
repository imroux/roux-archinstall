#!/usr/bin/env bash

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
  # System utils & networking
  "pacman-contrib"
  "curl"
  "wget"
  "net-tools"
  "unzip"
  "rsync"
  "glibc"
  "pkgconf-pkg-config"
  "brightnessctl"
  "bluez"
  "bluez-utils"
  "blueman"
  "iwd"
  "wireless_tools"
  # "rofi-bluetooth-git"
  "networkmanager-dmenu"
  "network-manager-applet"
  "openvpn"
  "networkmanager-openvpn"
  "rofi-power-menu"
  "sddm"
  "ntfs-3g"
  "acpi"
  "libva-nvidia-driver"
  "zstd"
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
  "gtk4"
  "ark"
  "ffmpegthumbnailer"
  "ffmpegthumbs"
  "sshpass"
  "wtype"
  "dosfstools"
  "exfatprogs"

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

  # Power management
  "tlp"
  "thermald"

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
  "deno"
  "bun-bin"
  "uv"
  "python-pip"
  "python-pipx"
  "python3-gobject"
  "dart-sass"

  # Container management
  "podman"

  # Shell & terminal utils
  "zsh"
  "starship"
  "fzf"
  "zoxide"
  "mlocate"
  "less"
  "ripgrep"
  "lsd"
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
  "adw-gtk-theme"
  "bibata-cursor-theme"
  "tela-circle-icon-theme-dracula"
  "matugen"
  "quickshell-git"
  "qt5ct-kde"
  "qt6ct-kde"
)

packages_common_x11=(
  "xorg"
  "xsel"
  "dex"
  "xdotool"
  "xclip"
  "cliphist"
  "xinput"
  "rofi"
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
  "cliphist"
  "rofi-wayland"
  "rofi"
  "waybar"
  "mako"
  "swww"
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
  "ghostty"
  "alacritty"

  # Web browsers
  "firefox"
  "librewolf-bin"
  "brave-bin"
  "zen-browser-bin"

  # Text & hex editors
  "neovim"
  "vim"
  "nano"
  "code"
  "code-marketplace"
  "ghex"

  # Media players & radios
  "mpd"
  "mpc"
  "rmpc"
  "mpv"
  "shortwave"
  "aimp"

  # File managers
  "dolphin"
  "nautilus"
  "yazi"

  # Password managers
  "keepassxc"

  # Readers & image viewers
  "foliate"
  "mcomix"
  "okular"
  "libreoffice-fresh"
  "obsidian"
  "gwenview"

  # Messengers
  "discord"
  "franz-bin"
  "halloy-bin"

  # Disk space visualizers
  "filelight"
  "ncdu"
  "gdu"

  # File transfer
  "filezilla"
  "syncthing"

  # Disk management & ISO writers
  "gnome-disk-utility"
  "gnome-multi-writer"

  # AI
  "ollama-cuda"

  # Other
  "imagemagick"
  "qbittorrent"
  "nicotine+"
  "amule"
  "qalculate-gtk"
  "clock-rs-git"
  "czkawka-gui-bin"
  "yt-dlp"
  "youtube-dl-gui-bin"
)

packages_fonts=(
  "ttf-hack-nerd"
  "noto-fonts"
  "noto-fonts-cjk"
  "noto-fonts-emoji"
  "noto-fonts-extra"
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
  "nvidia-dkms"
  "lib32-nvidia-utils"
  "nvidia-utils"
  "nvidia-settings"
)

set_variables() {
  sudo pacman -S --needed --noconfirm gum

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
mkdir /etc/pacman.d/hooks
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

install_misc() {
  # Rofi Power Menu
  pipx install git+https://github.com/cjbassi/rofi-power

  # SpotDL
  pipx install spotdl
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
  mkdir -p /home/$USER/.local/share/mpd/playlists
  touch /home/$USER/.local/share/mpd/{database,state,sticker.sql}

  systemctl --user enable --now mpd.service
  mpc update
}

install_flatpaks() {
  flatpak install flathub com.github.tchx84.Flatseal --assumeyes
}

install_dotfiles() {
  case "$choice_dotfiles" in
  Yes)
    echo "→ Installing rouxshell..."

    cd /home/$USER || exit
    case "$choice_wallpapers" in
    Yes)
      git clone --depth 1 --recurse-submodules https://github.com/imroux/rouxshell.git /home/$USER/.local/share/rouxshell
      ;;
    No)
      git clone --depth 1 https://github.com/imroux/rouxshell.git /home/$USER/.local/share/rouxshell
      ;;
    esac
    cd /home/$USER/.local/share/rouxshell || exit
    stow . -t /home/$USER

    matugen image /home/$USER/.local/share/backgrounds/arcane/jinx_18.png
    bat cache --build
    sudo flatpak override --filesystem=xdg-data/themes
    flatpak install org.gtk.Gtk3theme.adw-gtk3 org.gtk.Gtk3theme.adw-gtk3-dark --assumeyes

    # Link user configs with root configs
    sudo mkdir /root/.config
    sudo ln -sf /home/$USER/.local/share/rouxshell/.zshrc /root/.zshrc
    sudo ln -s /home/$USER/.local/share/rouxshell/.config/zsh /root/.config/zsh
    sudo ln -sf /home/$USER/.local/share/rouxshell/.config/starship.toml /root/.config/starship.toml
    sudo ln -s /home/$USER/.local/share/rouxshell/.config/nvim /root/.config/nvim
    # sudo mkdir -p /root/.cache/wal
    # sudo ln -s /home/$USER/.local/share/rouxshell/.cache/wal/colors-wal.vim /root/.cache/wal/colors-wal.vim

    return 0
    ;;
  No)
    echo "→ Skipping installation of rouxshell..."
    return 0
    ;;
  esac
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
mkdir -p /home/$USER/Data
mkdir -p /home/$USER/.local/{bin,share/{backgrounds,themes,icons}}
mkdir -p /home/$USER/.config/{calibre,cava,gtk-3.0,gtk-4.0,'Code - OSS/User',zsh}

# Set global variables
set_variables

# Boot backup hook
setup_backup_hook

# Fix laptop lid acting like airplane mode key
echo "→ Fixing laptop lid acting like airplane mode key..."
sudo -i -u root /bin/bash <<EOF
mkdir /etc/rc.d
echo "#!/usr/bin/env bash
# Fix laptop lid acting like airplane mode key
setkeycodes d7 240
setkeycodes e058 142" > /etc/rc.d/rc.local
EOF

# ZRAM configuration
echo "→ Configuring ZRAM..."
sudo echo "[zram0]
zram-size = min(ram, 8192)" >/etc/systemd/zram-generator.conf

# Pacman eye-candy features
echo "→ Enabling colours and parallel downloads for pacman..."
sudo sed -Ei 's/^#(Color)$/\1/;s/^#(ParallelDownloads).*/\1 = 10/' /etc/pacman.conf

# Setup rust
echo "→ Installing Rust..."
sudo pacman -S --needed --noconfirm rustup
rustup default stable

# Install yay AUR Helper
check_yay="$(sudo pacman -Qs yay | grep "yay")"
if [ -z "${check_yay}" ]; then
  echo "→ Installing yay..."
  sudo pacman -S --needed --noconfirm git base-devel
  git clone --depth 1 https://aur.archlinux.org/yay.git /tmp/yay
  cd /tmp/yay
  makepkg -si --needed --noconfirm
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

# Install miscellaneous packages
install_misc

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
echo "→ Installing flatpaks..."
sudo pacman -S --needed --noconfirm flatpak
install_flatpaks

# Set right-click dragging to resize windows in GNOME
echo "→ Setting right-click dragging to resize windows in GNOME..."
gsettings set org.gnome.desktop.wm.preferences resize-with-right-button true

# Update tealdeer cache
echo "→ Updating tealdeer cache..."
tldr --update

# Enable services
echo "→ Enabling systemctl services..."
systemctl --user enable pipewire
systemctl --user enable syncthing
sudo systemctl enable sddm
sudo systemctl enable bluetooth
sudo systemctl enable podman
sudo systemctl enable ollama
## Thermal monitoring and overheat prevention
sudo systemctl enable tlp
sudo systemctl enable thermald

# Install rouxshell
until install_dotfiles; do :; done

choice_reboot=$(gum choose "Yes" "No" --header "INSTALLATION IS COMPLETE. Would you like to reboot now?")
case "$choice_reboot" in
Yes)
  sudo reboot
  ;;
esac
