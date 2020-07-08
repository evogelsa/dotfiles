

# #---Bash Settings---#


# If not running interactively, don't do anything
case $- in
   *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth # ignore duplicates in history
shopt -s histappend # append to history
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s checkwinsize # check window size update lines and cols
set -o vi # vim mode
bind 'set show-mode-in-prompt on'
bind '"jj":vi-movement-mode'

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# #---Path Settings---#


export VISUAL=/usr/bin/vim
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/go/bin
export GOPATH=$HOME/go


# #---Prompt Settings---#


force_color_prompt=yes
if [ -n "$force_color_prompt" ]; then
   if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
      color_prompt=yes
   else
      color_prompt=
   fi
fi
if [ "$color_prompt" = yes ]; then
   PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[00m\]@\[\033[01;35m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
   PS1="\[\033[01;32m\]\u\[\033[00m\]@\[\033[01;35m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
fi
unset color_prompt force_color_prompt


# #---Aliases---#


# check for bash alias file
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if type nvim > /dev/null 2>&1; then # alias vim to nvim if available
    alias vim='nvim'
fi

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls -alhF'
alias la='ls -A'
alias l='ls -CF'
alias silo="ssh -X evogelsa@silo.sice.indiana.edu"
alias siloftp="sftp evogelsa@silo.sice.indiana.edu"
alias vi=vim
alias vg="valgrind --leak-check=yes --malloc-fill=0x88 --track-origins=yes"
alias compile_only="gcc -Wall -Wpedantic -g -c"
alias compile="gcc -Wall -Wpedantic -g -o"
alias py="python3"
alias py3="python3"
alias ipy="ipython"
alias pip="pip3"
alias chrome="/opt/google/chrome/google-chrome"
alias ..="cd .."
alias tree="tree -C"
alias dirtree="tree -Cd"
alias arduino="/usr/bin/arduino-1.8.9-linux64/arduino-1.8.9/arduino"
alias androidstudio="/usr/bin/android-studio/bin/studio.sh"
alias "n."="nautilus ."
alias tron="ssh sshtron.zachlatta.com"
alias crt="cool-retro-term -e tmux"
alias emacs="echo \"haha nice try\"; sleep .5; vim $@"
alias whatsTakingUpSpace="sudo du -cha --max-depth=1 . | grep -E \"M|G\""
alias swagger="docker run --rm -it -e GOPATH=$HOME/go:/go -v $HOME:$HOME -w $(pwd) quay.io/goswagger/swagger"
alias icat="kitty +kitten icat"
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"


# #---Function Definitions---#


[ -f ~/.fzf.bash ] && source ~/.fzf.bash

extract()
{
   if [ -f $1 ] ; then
      case $1 in
         *.tar.bz2)   tar xjf $1 ;;
         *.tar.gz)    tar xzf $1 ;;
         *.bz2)       bunzip2 $1 ;;
         *.rar)       rar x $1 ;;
         *.gz)        gunzip $1 ;;
         *.tar)       tar xvf $1 ;;
         *.tbz2)      tar xjf $1 ;;
         *.tgz)       tar xzf $1 ;;
         *.zip)       unzip $1 -d ${1%.*};;
         *.Z)         uncompress $1 ;;
         *.7z)        7za x $1 ;;
         *.xz)        xz -d $1 ;;
         *)           echo "'$1' cannot be extracted via extract()" ;;
      esac
   else
      echo "'$1' is not a valid file"
   fi
}

md2pdf()
{
   if [ -f $1 ] ; then
      if [ $2 ] ; then
         pandoc $1 -o $2
      else
         pandoc $1 -o ${1%.*}.pdf
      fi
   else
      echo "'$1' is not a valid file"
   fi
}


# #---Extra---#

# grab colors from wal and print neofetch for coolness
cat ~/.cache/wal/sequences &
source ~/.cache/wal/colors-tty.sh
neofetch
