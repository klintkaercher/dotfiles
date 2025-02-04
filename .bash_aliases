export ROSCONSOLE_CONFIG_FILE="$HOME/.ros/rosconsole.config"
export EDITOR="nvim"

# Bash exit and cd
alias qw="exit"
# alias sd="exit"
alias ..="cd ../"
alias ...="cd ../../"
alias ....="cd ../../../"

# C++
alias ga="g++ -Wall -Wextra -pthread -std=c++2a -fconcepts main.cpp"
alias ag="./a.out"
alias sf="g++ -Wall -Wextra -pthread -std=c++2a -fconcepts main.cpp && ./a.out"

# Rust
alias ca="cargo build"
alias sfs="cargo run"

# Git
alias gs="git status"
alias gfo="git fetch origin"
alias gl="git log --oneline"
alias gl3="git log --oneline | head -n 3"
alias gll="git log --oneline --graph"
alias gb="git branch"
alias gsf="git show --pretty=\"\" --name-only"
alias gd="git diff"

# Catkin
#alias cbt="catkin build --this"
alias cbtn="catkin build --this --no-deps"

# General
alias py="python3"
alias xo="xdg-open"
alias gre="grep -rin"
alias sb=". ~/.bashrc"
alias fin="find . -name"
alias sz="du -h --max-depth=0"
alias ??='echo $?'
alias ey='echo "yes"'
alias da="docker attach"
alias tmux="TERM=screen-256color-bce tmux"
alias tl="tmux ls"
alias bat="batcat"
alias bnw="brave-browser --new-window"
alias rmbil="rm -rf build install log"
alias xcli="xclip -sel clipboard"
alias bbr="rlwrap bb"

