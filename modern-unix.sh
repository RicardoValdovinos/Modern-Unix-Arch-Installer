#!/usr/bin/env bash

preinstalls() {
	echo "Getting ready to install Modern Unix tools..."
	pacman -Syu --noconfirm # Update system
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh # Rust
	pacman -Syu --noconfirm libxcb # broot
	pacman -S --noconfirm go nodejs
}

configure_go() {
	echo "Exporting go path..."
	echo "export GOPATH=$HOME/DOcuments/Programming/go" >> ~/.zshrc
	echo "export PATH=$PATH:$GOROOT/bin:$GOPATH/bin" >> ~/.zshrc
}

pacman_installs() {
	echo "Installing tools using pacman..."
	pacman -S --noconfirm bat exa git-delta duf fd ripgrep the_silver_searcher fzf jq bottom gping procs xh zoxide hyperfine
}

rust_installs() {
	echo "Installing rust based tools..."
	cargo install du-dust choose sd
	cargo install --locked broot
}

go_installs() {
	echo "Installing go based tools..."
	go install github.com/cheat/cheat/cmd/cheat@latest
	go install github.com/rs/curlie@latest
}

npm_installs() {
	echo "Installing nodejs based tools..."
	npm install -g tldr
}

configure_delta() {
	echo "Configuring delta..."

	git_delta_config="[core]
		pager = delta

	[interactive]
		diffFilter = delta --color-only

	[delta]
		navigate = true    # use n and N to move between diff sections
		light = false      # set to true if you're in a terminal w/ a light background color (e.g. the default macOS terminal)

	[merge]
		conflictstyle = diff3

	[diff]
		colorMoved = default"
	echo $"git_delta_config" >> ~/.gitconfig
}

configure_fzf() {
	echo "Configuring fzf..."
	echo "source /usr/share/fzf/key-bindings.zsh" >> ~/.zshrc
	echo "source /usr/share/fzf/completion.zsh" >> ~/.zshrc
}

configure() {
	echo "Configuring install..."
	configure_delta
	configure_fzf
}

setup_aliases() {
	echo "Adding aliases to ~/.zshrc"
	echo "# aliases" >> ~/.zshrc
	echo "alias ls=\"exa --color --icons\"" >> ~/.zshrc
	echo "alias cat=bat" >> ~/.zshrc
	echo "alias du=dust" >> ~/.zshrc
	echo "alias df=duf" >> ~/.zshrc
	echo "alias df=duf" >> ~/.zshrc
	echo "alias tree=br" >> ~/.zshrc
	echo "alias find=fd" >> ~/.zshrc
	echo "alias grep=rg" >> ~/.zshrc
	echo "alias awk=ag" >> ~/.zshrc
	echo "alias cut=choose" >> ~/.zshrc
	echo "alias sed=sd" >> ~/.zshrc
	echo "alias top=btm" >> ~/.zshrc
	echo "alias ping=gping" >> ~/.zshrc
	echo "alias ps=procs" >> ~/.zshrc
	echo "alias curl=curlie" >> ~/.zshrc
	echo "alias curl=curlie" >> ~/.zshrc
	source ~/.zshrc
}

main() {
	echo "Executing script..."
	preinstalls
	configure_go
	pacman_installs
	rust_installs
	go_installs
	configure
	setup_aliases
}

main
