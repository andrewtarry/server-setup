#!/usr/bin/env bash

EMAIL=$1
USERNAME=$2

sudo apt update

printf "Installing neovim\n"
sudo apt install -y lua5.1 luajit wget

ARCH=$(uname -m)

if [ "$ARCH" == "arm64" ] || [ "$ARCH" == "aarch64" ]; then
	printf "Building neovim"

	sudo apt install -y ninja-build gettext cmake unzip curl

	git clone https://github.com/neovim/neovim
	cd neovim
	git checkout stable
	make CMAKE_BUILD_TYPE=RelWithDebInfo
	sudo make install
	cd -
	rm -rf neovim

elif ! [ -f "$HOME/.nvim-linux64" ]; then

	wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
	tar -xzvf nvim-linux64.tar.gz
	mv nvim-linux64 "$HOME/.nvim-linux64"
	echo 'export PATH=$HOME/.nvim-linux64/bin:$PATH' >>"$HOME/.bash_rc"
	export PATH="$HOME/.nvim-linux64/bin:$PATH"
fi

printf "Configuring Git\n"

git config --global core.editor "vim"
git config --global core.editor "vim"
git config --global core.editor "vim"
git config --global user.email "$EMAIL"
git config --global user.name "$USERNAME"

printf "Configuring Neovim\n"
NVIM_DIR="$HOME/.config/nvim"
mkdir -p "$NVIM_DIR"
mkdir -p "$NVIM_DIR/lua"
touch "$NVIM_DIR/init.lua"

cp ./init.lua "$NVIM_DIR/init.lua"
