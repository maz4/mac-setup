# Based on bira theme

setopt prompt_subst

() {

local PR_USER PR_USER_OP PR_PROMPT PR_HOST

  # Git: branch/detached head, dirty status
prompt_git() {
  local ref dirty
  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    ZSH_THEME_GIT_PROMPT_DIRTY='±'
    dirty=$(parse_git_dirty)
    ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git show-ref --head -s --abbrev |head -n1 2> /dev/null)"

    # Determine the color based on dirty status
    local color='%F{green}' # Default to green for clean status
    if [[ -n $dirty ]]; then
      color='%F{yellow}' # Change to yellow for dirty status
    fi

    # Output the formatted branch name with the appropriate color
    echo -n "${color}${ref/refs\/heads\// }$dirty%f"
  fi
}


  # Check the UID
  if [[ $UID -ne 0 ]]; then # normal user
    PR_USER_OP='%F{green}%#%f'
    PR_PROMPT='%f➤ %f'
  else # root
    PR_USER_OP='%F{red}%#%f'
    PR_PROMPT='%F{red}➤ %f'
  fi

  local return_code="%(?..%F{red}%? ↵%f)"

  # local user_host="${PR_USER}%F{cyan}@${PR_HOST}"
  local current_dir="%B%F{blue}%~%f%b"
  local git_branch='$(prompt_git)'

#  This indentation needs to be set in this way to allow the arrowto match up 
PROMPT="╭─${user_host} ${current_dir} \$(ruby_prompt_info) ${git_branch}
╰─$PR_PROMPT "
  RPROMPT="${return_code}"

  ZSH_THEME_GIT_PROMPT_PREFIX="%F{yellow}‹"
  ZSH_THEME_GIT_PROMPT_SUFFIX="› %f"
  ZSH_THEME_RUBY_PROMPT_PREFIX="%F{red}‹"
  ZSH_THEME_RUBY_PROMPT_SUFFIX="›%f"
}

