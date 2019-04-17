# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# start running tmux by default but check tmux exists and its interative shell
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux attach
fi

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
   PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[00m\]@\[\033[01;35m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
   PS1="\[\033[01;32m\]\u\[\033[00m\]@\[\033[01;35m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
fi
unset color_prompt force_color_prompt

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

set -o vi
bind 'set show-mode-in-prompt on'
bind '"jj":vi-movement-mode'
export VISUAL=/usr/bin/vim

#### Alias definitions.

# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
# easy login to silo
alias silo="ssh -X  evogelsa@silo.sice.indiana.edu"
alias siloftp="sftp evogelsa@silo.sice.indiana.edu"
alias vi=vim
# checks for memory leaks
alias vg="valgrind --leak-check=yes --malloc-fill=0x88 --track-origins=yes"
# compiles <filename.c> and stores as <filename.o>
alias compile="gcc -Wall -Wpedantic -ansi -g -c"
# links <filename.o> to system libs and makes executable
# link <executable> <object file> <object file2> ...
alias link="gcc -ansi -g -o"
# compiles and links in one step
# linkcompile <executable> <file.c>
alias linkcompile="gcc -Wall -Wpedantic -ansi -g -o"
alias py="python3"
alias py3="python3"
alias pip=pip3
alias chrome="/opt/google/chrome/google-chrome"
alias ..="cd .."
# tree defaults with color flag
alias tree="tree -C"
alias dirtree="tree -Cd"
alias arduino="/usr/bin/arduino-1.8.9-linux64/arduino-1.8.9/arduino"


#### Function definitions

# simple extract all function
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
         *.zip)       unzip $1 ;;
         *.Z)         uncompress $1 ;;
         *.7z)        7za x $1 ;;
         *.xz)        xz -d $1 ;;
         *)           echo "'$1' cannot be extracted via extract()" ;;
      esac
   else
      echo "'$1' is not a valid file"
   fi
}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

mdown2pdf()
{
   if [ -f $1 ] ; then
      pandoc $1 -o $2
   else
      echo "'$1' is not a valid file"
   fi
}
