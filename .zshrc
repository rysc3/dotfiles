if [[ "$USER" == "ryanscherbarth" ]]; then
  PS1='%F{blue}ry%F{default}@%B%2~%b
%F{blue}%F{default}'

  PROMPT_SP=""

  # Add one empty line after each command's output
  precmd() {
    print
  }

else
  PS1='%F{blue}%n%F{default}@%B%2~%b
%F{blue}%F{default}'

  PROMPT_SP=""
fi

# Add two spaces before the text you type
RPROMPT='  '

# Set java version to azul17 for cs351 and like everything else:
export JAVA_HOME='/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home'

# Tmux Aliases 
alias tml='tmux ls'
alias tma='tmux attach -t'


[ -f "/Users/ry/.ghcup/env" ] && . "/Users/ry/.ghcup/env" # ghcup-env
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true

alias dc='docker-compose'
alias tml='tmux ls'
alias tma='tmux attach -t'
alias python='python3'
alias pip='pip3'
