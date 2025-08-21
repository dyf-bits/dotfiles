# for apple-silicon macs
alias brew='arch -arm64 brew'

alias ls="lsd --group-directories-first --icon never"
alias l="lsd --group-directories-first  --date +%Y/%m/%d --blocks name,size,date,permission"
alias vimrc="vim ~/.config/vim/vimrc"
alias phpdir="cd /opt/homebrew/var/www"
alias grep="grep --color=auto"

export MYVIMRC='~/.config/vim/vimrc'
export VIMINIT='source $MYVIMRC'
export PATH=$PATH:$HOME/Code/bin

# prompt code
# PS1='%/ >'
# PS1='%F{red}%B%(5~|%-1~/⋯/%3~|%4~)>%b%f' #~>
PS1='%F{red}%1~> %f'
RPROMPT='%t'

# This module allows adding functions that run before/after each command.
autoload -U add-zsh-hook

# Function to retrieve and display battery statistics in prompt.
function terminal_battery_stats {
    # pmset is a macOS cmd for power management and battery status.
	# awk formats the output into a useful string.
    bat_info=$(pmset -g batt | awk 'NR==2 {gsub(/;/,""); print $3 " " $4}')

    # Extract the battery percentage and state from the bat_info string.
    bat_percent=$(echo $bat_info | cut -d' ' -f1 | tr -d '%')
    bat_state=$(echo $bat_info | cut -d' ' -f2)

    if [ $bat_state = 'charging' ] || [ $bat_state = 'AC' ] || [ $bat_state = 'charged' ] || [ $bat_state = 'finishing' ]; then
        # If the battery is over 66%, don't display a battery prompt.
        if [ $bat_percent -gt 66 ]; then
            bat_prompt=""
        else
            bat_icon='🔌'
            bat_color='%F{green}'
            bat_prompt="〔$bat_color$bat_percent%%$bat_icon%f〕"
        fi
    else
        # If battery is discharging, choose an icon and color.
        if [ $bat_percent -le 33 ]; then
            bat_icon='🪫'
            bat_color='%F{red}'
        elif [ $bat_percent -gt 66 ]; then
            bat_icon='🔋'
            bat_color='%F{green}'
        else
            bat_icon='🔋'
            bat_color='%F{yellow}'
        fi
        # Format the prompt with the battery color, percentage, and icon.
        bat_prompt="〔$bat_color$bat_percent%%$bat_icon%f〕"
    fi

    # if current prompt already contains a battery remove it.
    if [[ "$RPROMPT" == *"〔"* ]]; then
        RPROMPT=${RPROMPT#*"〕"}
    fi

    # Add the new battery status to the prompt.
    RPROMPT="${bat_prompt}${RPROMPT}"
}

# run function before each command entered in the terminal.
add-zsh-hook precmd terminal_battery_stats

