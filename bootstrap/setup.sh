#!/bin/bash
set -euo pipefail

DOTFILES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
STOW_PACKAGES=(alacritty bash tmux zsh)

function backup_and_stow() {
  for pkg in "${STOW_PACKAGES[@]}"; do
    echo "[*] Processing package: $pkg"
    find "$DOTFILES_DIR/stow/$pkg" -type f -print0 | while IFS= read -r -d '' file; do
      rel_path="${file#"$DOTFILES_DIR"/stow/"$pkg"/}"
      target="$HOME/$rel_path"

      if [ -f "$target" ] && [ ! -L "$target" ]; then
        echo "    -> Backing up existing file: $target"
        mv "$target" "$target.bak"
      fi
    done

    stow --no-folding -d "$DOTFILES_DIR/stow" -t "$HOME" "$pkg"

  done
}

function install_dependencies() {
  echo "[+] Installing required packages..."
  sudo apt update
  sudo apt install -y stow zsh tmux alacritty bat eza git curl fcitx5 fcitx5-unikey ca-certificates
}

function configure_fcitx5() {
  echo "[+] Configuring environment variables for fcitx5..."
  grep -qxF 'export GTK_IM_MODULE=fcitx' ~/.profile || echo 'export GTK_IM_MODULE=fcitx' >> ~/.profile
  grep -qxF 'export QT_IM_MODULE=fcitx' ~/.profile || echo 'export QT_IM_MODULE=fcitx' >> ~/.profile
  grep -qxF 'export XMODIFIERS=@im=fcitx' ~/.profile || echo 'export XMODIFIERS=@im=fcitx' >> ~/.profile
}

function install_starship() {
  echo "[+] Installing Starship prompt..."
  curl -sS https://starship.rs/install.sh | sh -s -- -y
}


function change_default_shell() {
  echo "[+] Setting Zsh as default shell..."
  if [[ "$SHELL" != *zsh ]]; then
    # shellcheck disable=SC2046
    chsh -s $(which zsh)
  fi
}

function install_ubuntumono_nerd_font() {
  mkdir -p ~/.local/share/fonts
  cd ~/.local/share/fonts

  wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/UbuntuMono.zip

  unzip -o UbuntuMono.zip -d UbuntuMono
  rm UbuntuMono.zip
  fc-cache -fv
}

function main() {
  # install_dependencies
  # install_ubuntumono_nerd_font
  backup_and_stow
  # install_starship
  # configure_fcitx5
  # change_default_shell
  echo "[✔] Setup complete! Please log out and log back in to apply fcitx5 and dotfiles configuration."
}

main
