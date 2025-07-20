# Dotfiles

This repository contains my personal dotfiles, with a focus on Neovim configuration and helper scripts. The `kicknvim` plugin suite is included as a Git submodule.


## Quick Start

### 1. Clone the Repo with Submodules

```bash
git clone --recurse-submodules https://github.com/IstiCusi/dotfiles.git ~/dotfiles
```

This will pull down the main repo **and** initialize `scripts/kicknvim` at the commit referenced in `.gitmodules`.

### 2. (Optional) Sparse-Checkout Only Neovim Config

If you want **only** the `~/.config/nvim` subtree (and its submodules) without the rest:

```bash
git clone --filter=blob:none --sparse https://github.com/IstiCusi/dotfiles.git ~/dotfiles
cd ~/dotfiles
git sparse-checkout set .config/nvim
git submodule update --init --recursive .config/nvim/scripts/kicknvim
```

### 3. Symlink Into Your Home Directory

```bash
ln -s ~/dotfiles/.config/nvim ~/.config/nvim
```

Now Neovim will load your version-controlled config directly.

## Updating

- **Main repo**  
  ```bash
  cd ~/dotfiles
  git pull --recurse-submodules
  ```
- **Kicknvim submodule** (after upstream changes)  
  ```bash
  cd ~/.config/nvim/scripts/kicknvim
  git pull
  cd ~/dotfiles
  git add .config/nvim/scripts/kicknvim
  git commit -m "Update kicknvim submodule"
  git push
  ```

## Plugin Management

Inside Neovim, use your Lazy.nvim commands:

```vim
:Lazy install     " Install or update all plugins
:Lazy clean       " Remove plugins no longer in your config
```

## Tips

- Enable automatic submodule recursion:  
  ```bash
  git config --global clone.recurseSubmodules true
  git config --global submodule.recurse true
  ```
