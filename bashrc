# If not running interactively, don't do anything
if [[ $- != *i* ]]; then return; fi

DOTFILES="$HOME/.dotfiles"

# source fasd from scripts/ if not installed globally
if hash fasd 2>/dev/null; then :
else
  . "$DOTFILES/scripts/fasd"
fi

BASE16_SHELL=$DOTFILES/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
base16_default-dark

# https://github.com/mrzool/bash-sensible
. $DOTFILES/scripts/sensible.bash

. $DOTFILES/bash_aliases
. $DOTFILES/private/bash_aliases 2> /dev/null

# get random emoji for prompt 💩
. ~/.dotfiles/emojis
EMOJI="$(getRandomEmoji)  "

# https://github.com/git/git/tree/master/contrib/completion
. "$DOTFILES/scripts/git-completion.bash"
. "$DOTFILES/scripts/git-prompt.sh"
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_DESCRIBE_STYLE=branch
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWUPSTREAM="auto git"

# show number of jobs backgrounded via 'ctrl-z' in bash prompt
function getBackgroundJobs {
  JOBS_COUNT=$(jobs -s | wc -l | xargs)
  [ "$JOBS_COUNT" == "1" ] && printf "\b₁"
  [ "$JOBS_COUNT" == "2" ] && printf "\b₂"
  [ "$JOBS_COUNT" == "3" ] && printf "\b₃"
  [ "$JOBS_COUNT" -gt "3" ] && printf "\b₊"
}

PROMPT_COMMAND+='&& __git_ps1 "$EMOJI\[$(tput setaf 5)\]$(getBackgroundJobs)\[$(tput setaf 3)\]\[$(tput setaf 6)\]\w\[$(tput sgr0)\]" "\[$(tput setaf 3)\] \\\$ \[$(tput sgr0)\]" " |%s|"'

# https://github.com/clvv/fasd
eval "$(fasd --init auto)"

# setup MacOS specific config
if [ "$(uname)" == "Darwin" ]; then
  . "$DOTFILES/osxrc"
fi

export PATH=$PATH:$DOTFILES/bin

export EDITOR=vim
