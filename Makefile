.PHONY: store install default

targets += $(HOME)/.vim/pack
targets += $(HOME)/.local/bin/shell-bar

rcfiles = .gitconfig .bashrc .vimrc .npmrc

default:
	@echo "Run 'make store' or 'make install'."

store: vim-packages.toml
	cp $(patsubst %,$(HOME)/%,$(rcfiles)) .

vim-packages.toml: $(HOME)/.vim
	./scripts/list-vim-packages.sh > vim-packages.toml

install: $(targets)
	cp $(rcfiles) ~

$(HOME)/.vim/pack: vim-packages.toml
	./scripts/install-vim-packages.sh < vim-packages.toml

$(HOME)/.local/bin/shell-bar:
	mkdir -p ~/.local/src && cd ~/.local/src
	git clone git@github.com:jhidding/shell-bar.git
	cd shell-bar && make install
	cd ~/.local/pkg && stow shell-bar

