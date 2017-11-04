PRIVATE_DIR=private
PURPLE=\033[35m
YELLOW=\033[3;33m
RESET=\033[0;0m

install: ## Symlink dotfiles
		@echo "$(PURPLE)Linking dotfiles...$(RESET)"
		@./tow bash/home git/home tmux/home
		@echo "$(PURPLE)Restart session or run $(YELLOW)source bashrc$(RESET) $(PURPLE)for changes to take effect$(RESET)"

setupmac: decrypt install ## Setup MacOS
		@echo "$(PURPLE)Setting up MacOS...$(RESET)"
		@./macos/setup
		@echo "$(PURPLE)Setting up iTerm2...$(RESET)"
		@curl -s -L https://iterm2.com/shell_integration/bash -o ~/.iterm2_shell_integration.bash
		@defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/.dotfiles/iterm2"
		@defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
		@echo "$(PURPLE)Installing Node.js...$(RESET)"
		@./bash/bin/update-node

uninstall: ## Delete symlinked dotfiles
		@echo "$(PURPLE)Unlinking dofiles...$(RESET)"
		@./tow --unlink bash/home git/home tmux/home
		@-rm -rf ~/.dotfiles/${PRIVATE_DIR}

# ‘private’ task for echoing instructions
_pwd_prompt:
		@echo "$(PURPLE)If you don't know the password you probably shouldn't.$(RESET)"

decrypt: _pwd_prompt ## Decrypt private directory
		@printf "$(YELLOW)"
		@-openssl cast5-cbc -d -in ${PRIVATE_DIR}.cat5 | tar xz
		@printf "$(RESET)"

encrypt: _pwd_prompt ## Encrypt private directory
		@tar cz ${PRIVATE_DIR} | openssl cast5-cbc -e -out ${PRIVATE_DIR}.cat5

help:
		@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "$(PURPLE)%-30s$(RESET) $(YELLOW)%s\n$(RESET)", $$1, $$2}'

.DEFAULT_GOAL := help
.PHONY: install setupmac uninstall _pwd_prompt decrypt encrypt help
