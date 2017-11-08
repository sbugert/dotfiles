PRIVATE_DIR=private
PURPLE=\033[35m
YELLOW=\033[3;33m
RESET=\033[0;0m

installdotfiles: ## Symlink dotfiles
		@printf "$(PURPLE)Linking dotfiles$(RESET)\n"
		@./tow link bash/home git/gitconfig tmux/tmux.conf
		@printf "$(PURPLE)Restart session or run $(YELLOW)source bashrc$(RESET) $(PURPLE)for changes to take effect$(RESET)\n"

installnode: ## Install Node.js
		@printf "$(PURPLE)Installing Node.js$(RESET)\n"
		@./bash/bin/update-node

setupmac: decrypt installdotfiles installnode ## Setup MacOS
		@printf "$(PURPLE)Setting up MacOS$(RESET)\n"
		@./macos/setup
		@printf "$(PURPLE)Setting up iTerm2$(RESET)\n"
		@curl -s -L https://iterm2.com/shell_integration/bash -o ~/.iterm2_shell_integration.bash
		@defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/.dotfiles/iterm2"
		@defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
		@tic iterm2/xterm-256color-italic.terminfo

uninstalldotfiles: ## Delete symlinked dotfiles
		@printf "$(PURPLE)Unlinking dofiles$(RESET)\n"
		@./tow unlink bash/home git/gitconfig tmux/tmux.conf
		@-rm -rf ~/.dotfiles/${PRIVATE_DIR}

# ‘private’ task for echoing instructions
_pwd_prompt:
		@printf "$(PURPLE)If you don't know the password you probably shouldn't.$(RESET)\n"

decrypt: _pwd_prompt ## Decrypt private directory
		@printf "$(YELLOW)"
		@-openssl cast5-cbc -d -in ${PRIVATE_DIR}.cat5 | tar xz
		@printf "$(RESET)"

encrypt: _pwd_prompt ## Encrypt private directory
		@tar cz ${PRIVATE_DIR} | openssl cast5-cbc -e -out ${PRIVATE_DIR}.cat5

help:
		@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "$(PURPLE)%-30s$(RESET) $(YELLOW)%s\n$(RESET)", $$1, $$2}'

.DEFAULT_GOAL := help
.PHONY: installdotfiles installnode setupmac uninstalldotfiles _pwd_prompt decrypt encrypt help
