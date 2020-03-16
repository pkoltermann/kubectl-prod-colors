autoload -U add-zsh-hook

add-zsh-hook precmd _zsh_kubectl_prod_colors_precmd

function _zsh_kubectl_prod_colors_precmd() {

    if [ -z "$ZSH_PROD_COLORS_MATCHER" ]; then 
        ZSH_PROD_COLORS_MATCHER="prod"
    fi

    if [[ $(kubectl config current-context) == *"$ZSH_PROD_COLORS_MATCHER"* ]]; then 

        if [ -z "$ZSH_PROD_COLORS_BG" ]; then
            ZSH_PROD_COLORS_BG='%{$bg[red]%}'
        fi

        if [ -z "$OLD_PROMPT" ]; then
            OLD_PROMPT=$PROMPT
            OLD_RPROMPT=$RPROMPT
        fi

        PROMPT=$PROMPT$ZSH_PROD_COLORS_BG
        RPROMPT='%{$reset_color%}'$RPROMPT
    else 
        if [ -n "$OLD_PROMPT" ]; then 
            PROMPT=$OLD_PROMPT
            RPROMPT=$OLD_RPROMPT
        fi
    fi   
    return 0
}
