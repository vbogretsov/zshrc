# https://unix.stackexchange.com/questions/547/make-my-zsh-prompt-show-mode-in-vi-mode/1019

bindkey -v

function zle-line-init zle-keymap-select {
    # PROMPT=${${KEYMAP/vicmd/'%F{blue}❯❯ %F{default}'}/(main|viins)/'%F{default}❯❯ %F{default}'}
    # PROMPT=${${KEYMAP/vicmd/'%F{blue}'"$PROMPT"'%F{default}'}/(main|viins)/'%F{default}'"$PROMPT"'%F{default}'}
    RPROMPT=${${KEYMAP/vicmd/'[vi]'}/(main|viins)/''}
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

bindkey "^q" vi-cmd-mode