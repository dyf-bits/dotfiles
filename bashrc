#
# ~/.bashrc
#
# Note: If this file does not exist in the home directory,
# add this line to the end of /etc/bash.bashrc :
# source "$HOME/.config/bash/bashrc"  # or your desired path

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='lsd --group-directories-first --icon=never'
alias vimrc='vim ~/.config/vim/vimrc'
#alias l='lsd --group-directories-first'
alias l='lsd --group-directories-first -l --date "+%F" --blocks name,size,date,permission'
alias grep='grep --color=auto'
alias lighty='lighttpd -D -f $HOME/.config/lighttpd.conf'
alias lconf='vim $HOME/.config/lighttpd.conf'
alias vim='nvim'
#alias man='batman'
#alias grep='batgrep'
# original PS: PS1='[\u@\h \W]\$ '
PS1='[\W]\$ '

export PATH=$HOME/code/apps:$HOME/code/bin:$PATH
export EDITOR=nvim
export TERMINAL=foot
export TASKRC=~/.config/task/taskrc
export TASKDATA=~/.config/task/task task list
export OLLAMA_MODELS=/mnt/projects/ollama-models
#if ! [[ "$(ps -p $(ps -p $(echo $$) -o ppid=) -o comm=)" =~ 'bicon'* ]]; then
#  bicon.bin
#fi

eval "$(zoxide init bash)"
eval "$(fzf --bash)"
eval "$(batpipe)"

# catppuccin theme for fzf
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--multi"

alias cd='z'
