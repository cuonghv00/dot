# 🚀 My dot

This repository contains my personal dotfiles and setup scripts for configuring a development environment on Ubuntu (with KDE, Pop!_OS, or similar).

---

## 📁 Structure

```
dot/
├── bootstrap/
│   ├── setup.sh             # Install dotfile configs (Zsh, tmux, fcitx5, etc.)
│   └── install-devtools.sh    # Install developer tools (Docker, kubectl, VSCode, etc.)
├── stow/
│   ├── zsh/
│   ├── git/
│   ├── tmux/
│   ├── starship/
│   └── alacritty/
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


### 2. Install CLI tools

```bash
bash bootstrap/install-cli-tools.sh
```

> Includes: Starship, tmux, alacritty, zsh, bat, eza, lazydocker

---

### 3. Install development tools

```bash
bash bootstrap/install-devtools.sh
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
