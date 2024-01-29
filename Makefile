SHELL=/bin/zsh

KERN = $(shell uname)
GIT_HASH ?= $(shell git log --format="%h" -n 1)

IS_CPAIR ?= $(shell echo $CPAIR)
INFRA_DIR ?= $(shell pwd)
CONTROLLER_CONFIGS ?= $(shell pwd)/controller_configs
ZSH_CONFIGS ?= $(shell pwd)/controller_configs/zsh
VIM_CONFIGS ?= $(shell pwd)/controller_configs/vim

.PHONY: install_zsh install_aws install_aws_mac install_aws_linux install_nvim_mac

copy_reference:
	cp -rf $(CONTROLLER_CONFIGS)/reference/ ~/reference/ 

update-notes:
	# This updates notes, like todo, info, references.
	# if notes exist in home then copy them into the kubelab	
	if [ -f $$HOME/zsh/todo.zsh ]; then \
		cp -rf $$HOME/zsh/todo.zsh $(ZSH_CONFIGS)/todo.zsh; \
	fi
	if [ -f $$HOME/zsh/info.zsh ]; then \
		cp -rf $$HOME/zsh/info.zsh $(ZSH_CONFIGS)/info.zsh; \
	fi

backup-configs:
	cp -rf ~/zsh/*.zsh controller_configs/zsh/backup/
	cp -rf ~/.zshrc controller_configs/zsh/backup/
	cp -rf ~/.tmux.conf controller_configs/tmux/tmux.conf
	cp -rf ~/.config/nvim/init.vim controller_configs/vim/backup/

install_colorls:
	# Check if this needs to be installed
	$(eval colorls_bin := $(shell which colorls | grep -v 'not'))
	if [ -z $(colorls_bin) ]; then \
		sudo gem install addressable; \
		sudo gem install public_suffix; \
		sudo gem install colorls; \
	fi
	

install_oh-my-zsh:
	if ! [ -f ~/.oh-my-zsh/README.md ]; then \
		echo "oh-my-zsh does not exist"; \
		sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"; \
	fi

update-active-tmux-configs:
	make copy_reference
	cp -rf $(CONTROLLER_CONFIGS)/tmux/tmux.conf ~/.tmux.conf

update-active-zsh-configs:
	make copy_reference
	make install_colorls
	make install_oh-my-zsh
	make update-notes
	cp -rf $(CONTROLLER_CONFIGS)/zsh/zshrc ~/.zshrc
	cp -rf $(CONTROLLER_CONFIGS)/zsh/*.zsh ~/zsh/


update-active-nvim-configs:
	make copy_reference
	rm -rf ~/.config/nvim/*
	mkdir -p ~/.config/nvim/lua/config
	mkdir -p ~/.config/nvim/lua/plugins
	mkdir -p ~/.config/nvim/lua/utils
	make update-notes
	cp -rf $(VIM_CONFIGS)/*.lua ~/.config/nvim/
	cp -rf $(VIM_CONFIGS)/lua/config/* ~/.config/nvim/lua/config/
	cp -rf $(VIM_CONFIGS)/lua/plugins/* ~/.config/nvim/lua/plugins/
	cp -rf $(VIM_CONFIGS)/lua/utils/* ~/.config/nvim/lua/utils/
	cp -rf $(VIM_CONFIGS)/lua/snippets ~/.config/nvim/

# Push the changes from here to the system
update-active-configs:
	make update update-active-configs
	make update-active-nvim-configs


create-vms:
	vboxmanage createvm --name "kube-controller" --ostype Ubuntu_64 --register
	vboxmanage createvm --name "kube-worker" --ostype Ubuntu_64 --register

configure-vms:
	vboxmanage modifyvm "kube-controller" --cpus 1 --memory 4096 --vram 128 --graphicscontroller vmsvga --usbohci on --mouse usbtablet
	vboxmanage modifyvm "kube-worker" --cpus 1 --memory 4096 --vram 128 --graphicscontroller vmsvga --usbohci on --mouse usbtablet

create-controller-drive-files:
	vboxmanage createhd --filename kube-controller.vdi --size 20480 --variant Standard

create-worker-drive-files:
	vboxmanage createhd --filename kube-controller.vdi --size 20480 --variant Standard
	
install_zsh_plug:
	curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

install_zsh_linux:
	sudo apt-get install zsh
	make install_zsh_plug
	chsh -s /bin/zsh

install_zsh_mac:
	brew install zsh
	make install_zsh_plug
	chsh -s /bin/zsh
	# defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false              # For VS Code
	# defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false      # For VS Code Insider
	# defaults write com.vscodium ApplePressAndHoldEnabled -bool false                      # For VS Codium
	# defaults write com.microsoft.VSCodeExploration ApplePressAndHoldEnabled -bool false   # For VS Codium Exploration users
	# defaults delete -g ApplePressAndHoldEnabled  

install_aws_mac:
	curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
	sudo installer -pkg AWSCLIV2.pkg -target /

install_aws_linux:
	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
	unzip awscliv2.zip

	AWS_BIN=$(shell which aws)
	$(eval aws_bin := $(shell which aws))
	$(eval aws_bin_dir := $(shell dirname $(aws_bin)))

	$(eval aws_install_bin := $(shell readlink $(aws_bin)))
	$(eval aws_install_dir := $(shell dirname  $(aws_install_bin)))

	if [ -z "$(aws_bin)" ]; then \
			sudo ./aws/install; \
	else \
			sudo ./aws/install --bin-dir $(aws_install_dir) --install-dir $(aws_install_dir) --update; \
	fi
	@echo installing $(AWS_BIN) - $(aws_bin) $(aws_bin_dir)  $(aws_install_dir) to $(aws_install_dir)



install_nvim:
	if [[ $(KERN) = "Linux" ]]; then; echo "Installing on Linux"; fi
	if [[ $(KERN) = "Darwin" ]]; then; echo "Installing on Mac"; fi
	@ echo $(KERN)
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	rm -rf ~/nvim
	sudo rm -f /usr/local/bin/nvim

	sudo apt install nodejs npm -y
	sudo npm i -g pyright
	pip install neovim
	sudo gem install neovim
	npm install -g neovim
	pip install typing-extensions

	# https://github.com/nanotee/nvim-lua-guide/
	mkdir -p ~/.config/nvim/lua

	if [[ $(KERN) = "Darwin" ]] ; then \
			pip install xattr; \
			curl -LO https://github.com/neovim/neovim/releases/download/v0.9.5/nvim-macos.tar.gz; \
			xattr -c ./nvim.tar.gz; \
			tar -xzvf nvim-macos.tar.gz; \
			mv nvim-macos nvim; \
			rm -f nvim-macos.tar.gz; \
	fi

	if [[ $(KERN) = "Linux" ]] ; then \
			curl -LO https://github.com/neovim/neovim/releases/download/v0.9.5/nvim-linux64.tar.gz; \
			tar -xzvf nvim-linux64.tar.gz; \
			mv nvim-linux64/ nvim; \
			rm -f nvim-linux64.tar.gz; \
			sudo apt-get install ripgrep; \
	fi

	mv nvim ~
	sudo ln -s ~/nvim/bin/nvim /usr/local/bin/nvim

mac_aps:
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew install npm

setup_mac:
	if [[ $(KERN) = "Darwin" ]]; then \
		sudo apt install neovim luarocks python3-venv bat -y; \
		make update-active-configs; \
		make install_zsh_mac; \
		make install_colorls; \
		make install_nvim; \
		make install_aws_mac; \
	else \
		echo "System type is not mac"; \
	fi

install_bat_linux:
	$(eval bat_bin := $(shell which batcat))
	if [ -z $(bat_bin) ]; then \
		sudo apt update; \
		sudo apt install bat -y; \
		sudo ln -s $(bat_bin) /usr/local/bin/bat; \
	fi
	sudo ln -s $(which batcat) /usr/local/bin/bat

install_cargo:
	curl https://sh.rustup.rs -sSf | sh
	source "$$HOME/.cargo/env"

setup_linux:
	if [[ $(KERN) = "Linux" ]]; then \
		sudo apt install neovim luarocks python3-venv bat -y; \
		make install_cargo
		make install_oh-my-zsh; \
		make install_bat_linux; \
		make update-active-configs; \
		make install_zsh_linux; \
		make install_colorls; \
		make install_nvim; \
		make install_aws_linux; \
	else \
		echo "System type is not linux"; \
	fi
