#!/bin/bash

DEPS="neovim git ripggrep fd lazygit"

echo "==== Installing dependencies ==="

if command -v brew &> /dev/null; then
    PKG_MAN="brew"
    brew upgrade
    brew install nvim git lazygit ripggrep fd
elif command -v apt-get &> /dev/null; then
    apt install git ripgrep fd-find
   
    # Install nvim
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
    sudo rm -rf /opt/nvim-linux-x86_64
    sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

    echo "export PATH=\"$PATH:/opt/nvim-linux-x86_64/bin\"" >> ~/.bashrc

    # 1. Download the latest version metadata and binary archive 
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": *"v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"

    # 2. Extract the binary
    tar xf lazygit.tar.gz lazygit

    # 3. Install it system-wide
    sudo install lazygit /usr/local/bin/

    # 4. Clean up the downloaded archive
    rm lazygit.tar.gz lazygit
else
    echo "No supported package manager found."
    exit 1
fi

if [ $? -ne 0 ]; then
    echo "Dependency installation failed." >&2
    exit 1
fi

mv ~/.config/nvim{,.bak}

# optional but recommended
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}

echo "=== Cloning LazyVim repository ==="

git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

echo "Installation complete. To begin, run nvim"


