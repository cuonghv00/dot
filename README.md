# 🚀 My dot

This repository contains my personal dotfiles and setup scripts for configuring a development environment on Ubuntu (with KDE, Pop!_OS, or similar).

---

## 📁 Structure

```
dot
├── bootstrap
│   ├── install_devtools.sh
│   └── setup.sh
├── README.md
└── stow
    ├── alacritty
    ├── bash
    ├── git
    ├── k9s
    ├── starship
    ├── tmux
    ├── vim
    ├── vscode
    └── zsh
```

---

## ⚙️ Setup Instructions

### 1. Clone and run config setup

```bash
git clone https://github.com/cuonghv00/dot.git ~/dot
cd ~/dot
bash bootstrap/setup.sh
```

> This will install Zsh, apply stow configs, and set up `fcitx5` for Vietnamese input.

---

### 2. Install development tools

```bash
bash bootstrap/install_devtools.sh
```

> Includes: VirtualBox, Vagrant, Docker, kubectl, Minikube, k9s, VSCode, Firefox.

## 🧩 Dependencies

- `stow`
- `zsh`
- `tmux`
- `git`
- `fcitx5`
- `starship`
- `curl`, `wget`, `unzip`

---

## 💡 Notes

- After installing Docker, **log out and log back in** to apply group membership.
- Use `stow <package>` to enable configs individually if needed.

---

## 📌 Author

Cuong – [@cuonghv00](https://github.com/cuonghv00)
