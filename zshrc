#zmodload zsh/zprof

PROMPT='❯❯ '

ZSH=~/.config/zsh

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
  compinit -i
else
  compinit -C
fi

for plugin in $ZSH/plugins/*/*.plugin.zsh; do
  zcompile -R $plugin
  source $plugin
done

source ${ZSH}/aliases
source ${ZSH}/path

#zprof