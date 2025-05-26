export ROSCONSOLE_CONFIG_FILE="$HOME/.ros/rosconsole.config"
export EDITOR="nvim"

# alias sd="exit"
alias ..="cd ../"
alias ...="cd ../../"
alias ....="cd ../../../"
alias a="z"

# C++
alias ga="g++ -Wall -Wextra -pthread -std=c++2a -fconcepts main.cpp"
alias ag="./a.out"
alias sf="g++ -Wall -Wextra -pthread -std=c++2a -fconcepts main.cpp && ./a.out"

# Git
alias gfo="git fetch origin"
alias gl="git log --oneline --graph"
alias gb="git branch -vv"
alias gd="git diff"
alias gres="git restore ."
alias gcf="git clean -f ."
alias gp="git pull"
alias gsb="git switch -"

# General
alias py="python3"
alias xo="xdg-open"
alias gre="grep -rin"
alias sb=". ~/.bashrc"
alias sz="du -h --max-depth=0"
alias ??="echo $?"
alias ey="echo yes"
alias tmux="TERM=screen-256color-bce tmux"
alias bnw="brave-browser --new-window"
alias rmbil="rm -rf build install log"
alias xcli="xclip -sel clipboard"
alias bbr="rlwrap bb"
alias n="nvim"
alias ls="eza"

