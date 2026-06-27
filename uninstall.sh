#!/bin/bash

echo "Uninstalling nvim and lazy vim..."

if command -v brew; then
	brew upgrade
	brew uninstall nvim
elif command -v apt; then
	rm -rf /opt/nvim-linux-x86_64
fi		

rm -rf ~/.config/nvim ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim /root/.config/nvim > /dev/null 2>&1

echo "Removal complete."
