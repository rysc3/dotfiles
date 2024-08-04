# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='\[\033[0;32m\]\u@\h:\[\033[1;37m\][\[\033[1;37m\]ser\[\033[1;37m\]]\[\033[1;37m\]:\[\033[1;34m\]\w\[\033[1;37m\]\$\[\033[0m\] '

else
    PS1='\[\033[01;34m\](ser)\[\033[0m\]\[\033[01;34m\]\u@\h:\[\033[01;34m\]\w\[\033[01;34m\]\$\[\033[0m\] '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


git_branch() {
 	local branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
 	if [ -n "$branch" ]; then
   	echo "[$branch]"
 	fi
}

function bash_prompt() {
 	local git_branch=$(git_branch)
 	PS1='${debian_chroot:+($debian_chroot)}${blu}${git_branch}${pur} \W${grn} \$ ${clr}'
}	

export PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[1;37m\][\[\033[1;37m\]ser\[\033[1;37m\]]:\[\033[01;34m\]\w\[\033[00m\] \$(git_branch)\$ "

# function to change brightness on mac
brightness() {
  if ! [[ $1 =~ ^[0-9]+$ ]]; then 
    echo "Usage: $ brightness <input>"
    return 1;
  fi

  max=$(cat /sys/class/backlight/gmux_backlight/max_brightness)
  
  if (( $1 < 0 || $1 > max )); then 
    echo "Enter range from 0 to $max"
    return 1;
  fi

  echo $1 | sudo tee /sys/class/backlight/gmux_backlight/brightness
}

# My custom things:
  # aliases 

  alias c='clear'
  alias dc='docker-compose'
	alias dcu='docker compose up'
	alias dcd='docker-compose down --remove-orphans'
	alias ll='ls -lrt'
	alias bridges='sshpass -p $(cat ~/.ssh/bridges-ssh.pass) ssh bridges'
	
	# tmux things 
	alias tml='tmux ls'
	alias tma='tmux attach -t'

	# run speed test using speedtest-cli tool
	alias speed='speedtest-cli'

  # re-initialize dotfiles directory since I remove it all the time becuase its annoying lol
  alias dotinit='function git_init() {
		if [ -d .git ]; then 
			echo "you already have a .git mane"
		else 
			git init 
			git remote add origin git@github.com:rysc3/dotfiles.git
			git branch -M main
		fi 
  }; git_init'
	alias gitp='git push --set-upstream origin main'

	# aliases for CARC hpc
	alias jobs='watch squeue --me'

  ## Aliases for ISC24 Competition
  alias bridges='sshpass -p $(cat ~/.ssh/passwords/bridges-ssh.pass) ssh bridges'
  alias levante='sshpass -p $(cat ~/.ssh/passwords/levante-ssh.pass) ssh levante'
  ## End ISC24


# added by Anaconda3 2018.12 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/home/ryserver/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/home/ryserver/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/ryserver/anaconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/home/ryserver/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<



[ -f "/home/ryserver/.ghcup/env" ] && . "/home/ryserver/.ghcup/env" # ghcup-env

# initialize spack
. ~/spack/share/spack/setup-env.sh

## Add iterm2 support (run on remote host)
# curl -L https://iterm2.com/shell_integration/install_shell_integration.sh | bash
##
