#!/bin/sh
{ # do not allow partial exection

set -eu
cd

echo "Installing Epeli's Vim configuration"

backup () {
    if [ -e $1 ] ; then
        backup_name="${1}_backup_by_epeli_$(date +"%F_%H-%M-%S")"
        echo "Creating backup for $1 -> $backup_name"
        mv "$1" "$backup_name"
    fi
}

install_packages=""

install_if_missing() {
    dpkg -s $1 > /dev/null 2>&1 || {
        read -p "sudo apt-get install $1 y/n? [n]>" install_it
        if [ "$install_it" = "y" ]; then
            install_packages="$install_packages $1"
        fi
    }
}


if [ -x "$(which apt-get)" ]; then
    install_if_missing vim-nox
    install_if_missing git
    install_if_missing tmux
fi


echo
read -p "Create in subshell y/n? [n]>" use_subshell
[ "$use_subshell" = "" ] && use_subshell="n"

if [ "$use_subshell" = "y" ]; then
    default_subshell_loc="$HOME/epeli"
    read -p "Where? [$default_subshell_loc]>" subshell_loc
    [ "$subshell_loc" = "" ] && subshell_loc=$default_subshell_loc
    [ -e "$subshell_loc" ] && echo "That file/dir already exists!" && exit 1

    mkdir -p $subshell_loc
    cd $subshell_loc
    echo ". $HOME/.bashrc" > ".bashrc"
    echo ". $subshell_loc/.bashrc" > ".bash_profile"

    cat > $subshell_loc/login<<EOF
#!/bin/sh
export HOME=$subshell_loc
echo
echo "Starting new bash shell with Vim superpowers!"
echo
exec bash --login
EOF
chmod +x $subshell_loc/login
export HOME="$subshell_loc"
fi

# Neovim installation
read -p "Neovim? y/n? [y]>" neovim
[ "$neovim" = "" ] && neovim="y"


read -p "Bash config? y/n? [y]>" dotfiles
[ "$dotfiles" = "" ] && dotfiles="y"

if [ "$install_packages" != "" ]; then
    sudo apt-get install -y $install_packages
fi

backup $HOME/.vim
backup $HOME/.vimrc

git clone http://github.com/epeli/vimconfig.git $HOME/.vim
cd $HOME/.vim
git remote add sshorigin git@github.com:epeli/vimconfig.git

chmod +x $HOME/.vim/bin/*
ln -fs $HOME/.vim/init.vim $HOME/.vimrc

echo



if [ "$neovim" = "y" ]; then
    mkdir -p "$HOME/.config"
    cp -a "$HOME/.vim" "$HOME/.config/nvim"
fi

echo
if [ "$use_subshell" = "y" ]; then
    # Always install other dotfiles for subshells. Cannot conflict.
    $HOME/.vim/bin/dotfiles-install
    echo
    echo "Cool, Vim config installed to a subhell in $HOME/.vim"
    echo "Use $subshell_loc/login to activate the subshell and Vim config."
else
    if [ "$dotfiles" = "y" ]; then
        $HOME/.vim/bin/dotfiles-install
    fi
fi



}
