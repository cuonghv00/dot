#!/bin/bash

# bootstrap/install_devtools.sh - Install development tools on Ubuntu (KDE-based)

set -euo pipefail

SUDO=""
if [[ $EUID -ne 0 ]]; then
  SUDO="sudo"
fi

APT_PACKAGES=()

function install_virtualbox() {
  echo "[+] Installing VirtualBox..."
  command -v virtualbox >/dev/null || APT_PACKAGES+=(virtualbox)
}

function install_vagrant() {
  echo "[+] Configuring Vagrant repository..."
  if [[ ! -f /etc/apt/sources.list.d/hashicorp.list ]]; then
    wget -O - https://apt.releases.hashicorp.com/gpg | $SUDO gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | $SUDO tee /etc/apt/sources.list.d/hashicorp.list
  fi
  command -v vagrant >/dev/null || APT_PACKAGES+=(vagrant)
}


function install_docker() {
  echo "[+] Configuring Docker repository..."
  $SUDO install -m 0755 -d /etc/apt/keyrings
  $SUDO curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  $SUDO chmod a+r /etc/apt/keyrings/docker.asc

  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo \""${UBUNTU_CODENAME:-$VERSION_CODENAME}"\") stable" | \
    $SUDO tee /etc/apt/sources.list.d/docker.list > /dev/null

  if ! command -v docker >/dev/null; then
    APT_PACKAGES+=(docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin)
  fi
}

function install_kubectl() {
  echo "[+] Installing kubectl..."
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  $SUDO install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
  rm kubectl
}

function install_minikube() {
  echo "[+] Installing minikube..."
  curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
  $SUDO install minikube-linux-amd64 /usr/local/bin/minikube
  rm minikube-linux-amd64
}

function install_k9s() {
  echo "[+] Installing k9s..."
  latest=$(curl -s https://api.github.com/repos/derailed/k9s/releases/latest | grep 'browser_download_url.*Linux_amd64.tar.gz"' | cut -d '"' -f 4)
  curl -LO "$latest"
  tar -xzf k9s_Linux_amd64.tar.gz k9s
  $SUDO mv k9s /usr/local/bin/
  rm k9s_Linux_amd64.tar.gz
}

function install_lazydocker() {
  VERSION=$(curl -sL -H 'Accept: application/json' https://github.com/jesseduffield/lazydocker/releases/latest | grep -Po '"tag_name": *"\K.*?(?=")')
  FILE="lazydocker_${VERSION//v/}_$(uname -s)_x86.tar.gz"
  curl -L -o lazydocker.tar.gz "https://github.com/jesseduffield/lazydocker/releases/download/${VERSION}/${FILE}"
  tar xzvf lazydocker.tar.gz lazydocker
  chmod +x lazydocker
  mv lazydocker "$HOME/.local/bin/"
  rm -f lazydocker.tar.gz
}


function install_vscode() {
  echo "[+] Configuring Visual Studio Code repository..."
  if [[ ! -f /etc/apt/sources.list.d/vscode.list ]]; then
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    $SUDO install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
    $SUDO sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    rm packages.microsoft.gpg
  fi
  command -v code >/dev/null || APT_PACKAGES+=(code)
}

function install_firefox() {
  echo "[+] Configuring Firefox repository..."
  $SUDO install -d -m 0755 /etc/apt/keyrings
  if [[ ! -f /etc/apt/keyrings/packages.mozilla.org.asc ]]; then
    wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | $SUDO tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
  fi
  gpg --quiet --import-options import-show --dry-run --import /etc/apt/keyrings/packages.mozilla.org.asc | \
    grep -q "35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3" && echo "Fingerprint OK" || echo "Fingerprint mismatch"
  echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | \
    $SUDO tee /etc/apt/sources.list.d/mozilla.list > /dev/null
  echo 'Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000' | $SUDO tee /etc/apt/preferences.d/mozilla
  command -v firefox >/dev/null || APT_PACKAGES+=(firefox)
}

function main() {
  install_virtualbox
  install_vagrant
  install_docker
  install_vscode
  install_firefox
  $SUDO apt-get update
  if [[ ${#APT_PACKAGES[@]} -gt 0 ]]; then
    $SUDO apt-get install -y "${APT_PACKAGES[@]}"
  fi
  install_kubectl
  install_minikube
  install_k9s
  install_lazydocker
  $SUDO usermod -aG docker "$USER"
  echo "[✔] All development tools installed successfully!"
}

main
