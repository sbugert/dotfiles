.PHONY: install installmac _pwd_prompt decrypt encrypt help

PRIVATE_DIR=private

install: ## Symlink dotfiles
		ln -s ~/.dotfiles/bashrc ~/.bashrc
		ln -s ~/.dotfiles/bash_profile ~/.bash_profile
		ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf
		ln -s ~/.dotfiles/gitconfig ~/.gitconfig
		source ~/.bashrc
		base16_default-dark

installmac: decrypt install ## Symlink dotfiles with mac specifics
		ln -s ~/.dotfiles/gitconfig ~/.gitconfig

# ‘private’ task for echoing instructions
_pwd_prompt:
		@echo "\033[0;35mIf you don't know the password you probably shouldn't.\033[0m"

decrypt: _pwd_prompt ## Decrypt private directory
		openssl cast5-cbc -d -in ${PRIVATE_DIR}.cat5 | tar xz

encrypt: _pwd_prompt ## Encrypt private directory
		tar cz ${PRIVATE_DIR} | openssl cast5-cbc -e -out ${PRIVATE_DIR}.cat5

help:
		@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[35m%-30s\033[0m \033[33m%s\n\033[0m", $$1, $$2}'

.DEFAULT_GOAL := help
