# Path to your oh-my-zsh installation.
export ZSH="/Users/marcinzasadzki/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="cobalt2"
# ZSH_THEME="jonathan"
ZSH_THEME="gnzh"

# Which plugins would you like to load?
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

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

# push to remote and set the remote
function cp() {
    # Check if the current directory is part of a Git repository
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo "Error: Not a git repository (or any of the parent directories)."
        return 1
    fi

    # Get the current branch name
    local branch_name
    branch_name="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
    
    # Check if the command to get branch name succeeded
    if [ -z "$branch_name" ] || [ "$branch_name" = "HEAD" ]; then
        echo "Error: No current branch detected. Are you in a detached HEAD state?"
        return 1
    fi

    # Check if the current branch has an upstream set
    if git rev-parse --abbrev-ref --symbolic-full-name @{u} > /dev/null 2>&1; then
        # If upstream is set, perform a regular git push
        git push
    else
        # If no upstream, set it with the custom format and push
        # The format is "marcin/MM-18005_" followed by the branch name
        git push --set-upstream origin "${branch_name}"
    fi
}

# git commmit with jira issue prepend from branch name
function cm() {
    # Check if the current directory is part of a Git repository
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo "Error: Not a git repository (or any of the parent directories)."
        return 1
    fi

    # Get the current branch name
    local branch_name
    branch_name=$(git symbolic-ref --short HEAD 2>/dev/null)

    # Check if the branch name was successfully retrieved
    if [ -z "$branch_name" ]; then
        echo "Error: Cannot determine the current branch."
        return 1
    fi

    # Extract the identifier from the branch name
    local identifier
    if [[ $branch_name =~ .*/(MM-[0-9]+|no-issue)_ ]]; then
        # Extract the identifier using cut command
        identifier=$(echo $branch_name | cut -d '_' -f 1 | cut -d '/' -f 2)
        git commit -m "[$identifier] $1"
    else
        # If the branch name does not match the pattern, just use the original commit message
        git commit -m "$1"
    fi
}

# Ger Github PR link
function pl() {
  local branch=${1:-$(git rev-parse --abbrev-ref HEAD)}
  local repo_url=$(git config --get remote.origin.url)

  # Convert SSH URL to HTTPS URL for GitHub
  local https_repo_url=${repo_url/git@github.com:/https://github.com/}
  https_repo_url=${https_repo_url%.git}
  
  local pr_link="${https_repo_url}/compare/${branch}?expand=1"

  echo "Pull Request Link for branch '${branch}':"
  echo $pr_link
}

# Aliases
# edit zshrc in a new vs code window
alias ez="code -n ~/.zshrc"

# shortern calling yarn
alias y="yarn"

# init jump
eval "$(jump shell zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh