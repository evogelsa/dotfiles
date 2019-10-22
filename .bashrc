### Section: Terminal config settings and tmux

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
HISTCONTROL=ignoreboth
# append to the history file, don't overwrite it
shopt -s histappend
# set history size and history file size
HISTSIZE=1000
HISTFILESIZE=2000
# check the window size after each command and, update lines and cols if needed
shopt -s checkwinsize
# emulate vi in bash and add vi keybinds
set -o vi
bind 'set show-mode-in-prompt on'
bind '"jj":vi-movement-mode'
export VISUAL=/usr/bin/vim
export ANDROID_HOME=~/Android/Sdk
export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
export JAVA_HOME=/usr/lib/jvm/default-java


### Section: Prompt settings

# force color prompt on
force_color_prompt=yes
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
# set prompt and colors
if [ "$color_prompt" = yes ]; then
   PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[00m\]@\[\033[01;35m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
   PS1="\[\033[01;32m\]\u\[\033[00m\]@\[\033[01;35m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
fi
unset color_prompt force_color_prompt

### Section: Aliasses

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
# enable programmable completion features (you don't need to enable
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

### Section: Alias definitions.

# check for bash alias file
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
# ls shortcuts
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
# easy login to silo
alias silo="ssh -X evogelsa@silo.sice.indiana.edu"
alias siloftp="sftp evogelsa@silo.sice.indiana.edu"
alias vi=vim
# valgrind checker for memory leaks and improper memory usage
alias vg="valgrind --leak-check=yes --malloc-fill=0x88 --track-origins=yes"
# compiles <filename.c> and stores as <filename.o>
alias compile="gcc -Wall -Wpedantic -ansi -g -c"
# links <filename.o> to system libs and makes executable
alias link="gcc -ansi -g -o"
# compiles and links in one step
alias linkcompile="gcc -Wall -Wpedantic -ansi -g -o"
alias py="python3"
alias py3="python3"
alias ipy="ipython"
alias pip="pip3"
alias chrome="/opt/google/chrome/google-chrome"
alias ..="cd .."
# tree defaults with color flag
alias tree="tree -C"
alias dirtree="tree -Cd"
alias arduino="/usr/bin/arduino-1.8.9-linux64/arduino-1.8.9/arduino"
alias androidstudio="/usr/bin/android-studio/bin/studio.sh"
#  clears in tmux
alias ""="clear"
alias "n."="nautilus ."
alias tron="ssh sshtron.zachlatta.com"

### Section: Function definitions

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
# fuzzy finder
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# convert mdown + latex to pdf for notes
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
