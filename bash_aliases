alias reload='source ~/.bashrc'
alias fh='open -a Finder .'
alias flush='dscacheutil -flushcache'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- -='cd -'
alias sl=ls
if [ "$(uname)" == "Darwin" ]; then
   alias ls='ls -G'
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
   alias ls='ls --color=auto'
fi
alias la='ls -AF'
alias ll='ls -alh'
alias l='ls -a'
alias l1='ls -1'
alias q='exit'
alias c='clear'
alias gs='git status'

alias resetsound='sudo killall coreaudiod'

function swap()
{
  tmpfile=$(mktemp $(dirname "$1")/XXXXXX)
  mv "$1" "$tmpfile" && mv "$2" "$1" &&  mv "$tmpfile" "$2"
}

function eject()
{
  osascript -e 'tell application "Finder" to eject (every disk whose ejectable is true)'
}

selected() {
    osascript <<EOT
        tell application "Finder"
            set theFiles to selection
            set theList to ""
            repeat with aFile in theFiles
                set theList to theList & POSIX path of (aFile as alias) & "\n"
            end repeat
            theList
        end tell
EOT
}

function finder_path {
    osascript -e 'tell application "Finder"'\
        -e "if (${1-1} <= (count Finder windows)) then"\
        -e "get POSIX path of (target of window ${1-1} as alias)"\
        -e 'else' \
        -e 'get POSIX path of (desktop as alias)'\
        -e 'end if' \
        -e 'end tell';
}



# log vim keystrokes for science
alias vim='vim -w ~/.vimlog "$@"'
alias v='vim'
