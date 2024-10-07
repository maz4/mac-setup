#!/bin/bash

if ! command -v brew &> /dev/null
then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "eval $(/opt/homebrew/bin/brew shellenv)" >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if ! command -v ansible &> /dev/null
then
    brew install ansible
fi

ansible-galaxy collection install community.general
ansible-playbook local.yaml -K --ask-vault-pass

if ! command -v lvim &> /dev/null
then
  echo "Install LunarVim"
  PIP_BREAK_SYSTEM_PACKAGES=1 LV_BRANCH='release-1.4/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.4/neovim-0.9/utils/installer/install.sh)
fi


# Copy oh-my-zsh themes
# Copy the theme throught the cp command
# theme has some characters that mess up with ansible copy function
if command -v zsh &> /dev/null
then
    echo "Copy oh-my-zsh theme"
    # cp ansible/templates/cobalt2.zsh-theme ~/.oh-my-zsh/themes
fi

# Style git log messages
if command -v git &> /dev/null
then
    echo "Style git log messages" 
    git config --global pretty.my format:'%C(yellow)%h %C(dim green)%ad %C(reset)| %C(cyan)%s%d %C(#667788)[%an]' --date=format:'%F %R'
    git config --global format.pretty my
fi

