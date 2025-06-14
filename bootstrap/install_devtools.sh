#!/bin/bash

# bootstrap/install_devtools.sh - Install development tools on Ubuntu (KDE-based)

set -e

function install_virtualbox() {
  echo "[+] Installing VirtualBox and Vagrant..."
  sudo apt install -y virtualbox vagrant
}

function install_vagrant() {
  echo "[+] Installing Vagrant from official HashiCorp repository..."
  wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
  sudo apt update
  sudo apt install -y vagrant
}


function install_docker() {
  echo "[+] Installing Docker CE from official repository..."
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc

  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo \""${UBUNTU_CODENAME:-$VERSION_CODENAME}"\") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  sudo apt-get update
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  sudo usermod -aG docker "$USER"
}

function install_kubectl() {
  echo "[+] Installing kubectl..."
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
  rm kubectl
}

function install_minikube() {
  echo "[+] Installing minikube..."
  curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
  sudo install minikube-linux-amd64 /usr/local/bin/minikube
  rm minikube-linux-amd64
}

function install_k9s() {
  echo "[+] Installing k9s..."
  latest=$(curl -s https://api.github.com/repos/derailed/k9s/releases/latest | grep 'browser_download_url.*Linux_amd64.tar.gz"' | cut -d '"' -f 4)
  curl -LO "$latest"
  tar -xzf k9s_Linux_amd64.tar.gz k9s
  sudo mv k9s /usr/local/bin/
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
  echo "[+] Installing Visual Studio Code..."
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
  sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
  sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg]     https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
  sudo apt update
  sudo apt install -y code
  rm packages.microsoft.gpg
}

function install_firefox() {
  echo "[+] Installing Firefox from Mozilla official APT repository..."
  sudo install -d -m 0755 /etc/apt/keyrings
  wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
  gpg --quiet --import-options import-show --dry-run --import /etc/apt/keyrings/packages.mozilla.org.asc | \
    grep -q "35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3" && echo "Fingerprint OK" || echo "Fingerprint mismatch"
  echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | \
    sudo tee /etc/apt/sources.list.d/mozilla.list > /dev/null
  echo 'Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000' | sudo tee /etc/apt/preferences.d/mozilla
  sudo apt-get update
  sudo apt-get install -y firefox
}

function main() {
  sudo apt update
  install_virtualbox
  install_vagrant
  install_docker
  install_kubectl
  install_minikube
  install_k9s
  install_lazydocker
  install_vscode
  install_firefox
  echo "[✔] All development tools installed successfully!"
}

main
