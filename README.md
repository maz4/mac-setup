# Mac Setup

This repo will automatically setups a mac with the applications which i use on a daily basis.

Make sure you are logged in to apple App Store. Mas-cli tool needs user authentication from the app store to install app store apps.

To run use `./install.sh`

## iTerm2 ZSH setup

Settings file

## Git manual setup

### Git Log styling

Now done visa install.sh script but i'll keep it for reference

```
git config --global pretty.my format:'%C(yellow)%h %C(dim green)%ad %C(reset)| %C(cyan)%s%d %C(#667788)[%an]' --date=format:'%F %R'
git config --global format.pretty my


// Windows additional step
git config --global log.date format-local:'%F %R’
```

### Create ssh keys

Run command: `ssh-keygen -t rsa -b 4096 -C "your_email@example.com"`. During the process you will be asked about location whereto store keys put in location `/Users/{user}/.ssh/id_rsa_github` for github and `/Users/{user}/.ssh/id_rsa_gitlab` for gitlab

[atlassian generate ssh keys](https://www.atlassian.com/git/tutorials/git-ssh)

### Manage multiple git accounts

```
// location -> ~/Users/{username}/.ssh/
# File name `config`
# SSH config for multiple git hosting accounts

# Personal github account
Host github.com
 HostName github.com
 User maz4
 IdentityFile ~/.ssh/id_rsa_github

# Work gitlab account
Host gitlab.com
 HostName gitlab.com
 User Marcin
 IdentityFile ~/.ssh/id_rsa_gitlab
```

The bellow files should be generated:

```
~/Users/{user}/.ssh/id_rsa_github - rsa private key
~/Users/{user}/.ssh/id_rsa_github.pub - ssh-rsa
~/Users/{user}/.ssh/id_rsa_gitlab - rsa private key
~/Users/{user}/.ssh/id_rsa_gitlab.pub - ssh-rsa
```

Run command ssh-add `~/.ssh/id_rsa_github` and `~/.ssh/id_rsa_gitlab` to add new keys.

[stack overflow post](https://stackoverflow.com/questions/3225862/multiple-github-accounts-ssh-config)

## VS code setup

### Launching from the command line

[vs code docs](https://code.visualstudio.com/docs/setup/mac#_launching-from-the-command-line)

```
cat << EOF >> ~/.zprofile
# Add Visual Studio Code (code)
export PATH="\$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
EOF
```

## ZSH custom functions for quicker git branch management

Add at the end of your `~/.zshrc` file

```
# custom functions
cyan=`tput setaf 6`
yellow=`tput setaf 3`
green=`tput setaf 2`
bold=`tput bold`
reset=`tput sgr0`

# show all branches === git branch
b() {
  (git for-each-ref --sort=-committerdate refs/heads/ --format=${green}'%(authordate:short) '${reset}${bold}${cyan}'%(objectname:short)'${reset}${yellow}' %(refname:short)'${reset}' ('${green}'%(committerdate:relative)'${reset}')' $@ | nl)
}

# delete branch from the list displayed by `b` command example -> `bd 1`

bd() {
  git branch -D `git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname:short)' | sed -n ${1}p`
}

# checkout branch with branch displayed by the `b` command example `bc 1`

bc() {
  git checkout `git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname:short)' | sed -n ${1}p`
}
```
