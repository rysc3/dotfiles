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
