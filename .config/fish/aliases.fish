alias cp 'cpz'
alias rm 'rmz'
alias rf 'rmz'

alias difff 'difft --color auto --background light --display side-by-side'

alias fd 'fd -HI'
alias rg 'rg --hidden --no-ignore'
alias ls 'eza \
    --all \
    --icons=auto \
    --hyperlink \
    --git \
    --group-directories-first \
    --long --no-permissions --no-user \
'
alias lsa 'eza -la'

alias mount 'sudo mount --mkdir'
    
alias g '/usr/bin/env git'
alias git "echo 'use g instead' "

alias c '/usr/bin/env cargo'
alias cargo "echo 'use c ' "

alias i "sudo pacman -S"

alias refish 'source ~/.config/fish/config.fish'

function mkcd
    mkdir -p $argv; and cd $argv
end

function cncd
    cargo new $argv; and cd $argv
end

function n
    if test (count $argv) -gt 0
        nvim $argv
    else
        nvim .
    end
end

function e
    cd $argv; and nvim .
end

function weightlog
    set date (date +'%d-%m-%y-%T')
    echo "$date: $argv" | tee -a "$HOME/repos/weight log"
end

function read_later
    echo "$argv" | tee -a "$HOME/repos/notes/reading_list.md"
end

function bc 
    ./x build --incremental --keep-stage-std 1 --skip-stage0-validation
end


function xbless
    ./x test $argv --bless
end

function rc
    build/host/stage1/bin/rustc $argv
end
