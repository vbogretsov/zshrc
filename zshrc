#zmodload zsh/zprof

export LANG=en_US.UTF-8
export HISTSIZE=999999999
export SAVEHIST=$HISTSIZE
export PAGER=less
export EDITOR=nvim

export CLICOLOR=1
#               1 2 3 4 5 6 7 8 9 10
export LSCOLORS=exFxcxdxbxgxgxbxbxexex

# PROMPT='❯❯ '
PROMPT='❯ '

ZSH=~/.config/zsh
AUTOENV_FILES=(.venv/bin/activate environ)

setopt rm_star_silent

autoload -U compaudit compinit

[[ -f ~/.zcompdump ]] && zcompile -R ~/.zcompdump

for plugin in $ZSH/plugins/*; do
  fpath=($plugin $fpath)
done

for config_file in $ZSH/lib/*.zsh; do
  source $config_file
  zcompile -R $config_file
done

if [[ $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.zcompdump) ]]; then
  compinit -u
else
  compinit -C
fi

for plugin in $ZSH/plugins/*/*.plugin.zsh; do
  zcompile -R $plugin
  source $plugin
done

export KEYTIMEOUT=1

if [ -z "$TMUX" ] && [ -z $NVIM ]; then
  tmux -2 attach -t main || tmux -2 new -s main
else
  source ${ZSH}/aliases
fi

#zprof
