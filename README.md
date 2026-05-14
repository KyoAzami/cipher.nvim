# cipher-0  NeoVim configuration

*A minimalist yet powerful NeoVim configuration for modern development*

## ✨ Features

- **Dark-themed** with optimal contrast for eye comfort
- **Modular design** for easy customization
- **Multi-language support** with emphasis on:
  - Web Development (HTML/CSS/JS/TS)
  - Rust (with full LSP support)
  - Python, Go, and other systems languages
- **Performance-optimized** with lazy-loaded plugins
- **Batteries-included** but stays lightweight

## 🚀 Installation

### Prerequisites
- **Neovim** ≥ 0.11.0
- **Git**
- A **Nerd Font** installed (recommended: [CaskaydiaCove Mono](https://www.jetbrains.com/lp/mono/))

### 1. Clone the Repository

Clone this configuration into your Neovim config path (`~/.config/nvim`). 
*(Note: Make sure to back up or remove any existing `~/.config/nvim` folder before cloning).*

**Recommended (SSH):**
```bash
git clone git@github.com:KyoAzami/cipher.nvim.git ~/.config/nvim/
```

**Alternative (HTTPS):**
```bash
git clone https://github.com/KyoAzami/cipher.nvim.git ~/.config/nvim
```

### 2. Install system Dependencies (Mason & LSP)

To ensure that Mason (the package manager for Neovim) can properly compile and install Language Servers (like `pyright`, `ts_ls`, `html`, etc.), you need some basic system tools (`Node.js`, `npm`, `Python`, etc.).

We've included a script that automatically detects your Linux distribution (`Arch`, `Debian/Ubuntu`, `Fedora`, `or openSUSE`) and installs the required dependencies for you.

```bash
cd ~/.config/nvim
chmod +x install_mason_deps.sh
./install_mason_deps.sh
```

### 3. First launch

Once the dependencies are installed, simply launch Neovim:

```bash
nvim
```

On the first run, `lazy.nvim` will automatically download and install all the required plugins, and Mason will begin setting up your language servers in the background. Grab a coffee, let it finish, and you're ready to code!
