############################################################################
# User configuration
################################################################################
set -x BUN_INSTALL "$HOME/.bun"
set -x EDITOR nvim
set -x XDG_CONFIG_HOME "$HOME/.config"

# Default hostname for gh cli
set -x GH_HOST "github.com"

set -x d (date +'%Y-%m-%d')
set -x dt (date +'%Y-%m-%d-%H-%M')

alias kcontext="kubectl config view --minify --output 'jsonpath={..context}'"
abbr -a -g k kubectl
abbr -a -g kctx kubectx
abbr -a -g kgp "kubectl get pods"
abbr -a -g klf "kubectl logs -f"
abbr -a -g kns kubens

# lsd and the search for god
abbr -a -g ll "lsd -lAh"
abbr -a -g llt "lsd -lAh --tree"
abbr -a -g llt2 "lsd -lAh --tree --depth 2"
abbr -a -g llt3 "lsd -lAh --tree --depth 3"

abbr gti git
abbr g1 "git log --oneline --decorate --color -1"
abbr g2 "git log --oneline --decorate --color -2"
abbr g3 "git log --oneline --decorate --color -3"
abbr g4 "git log --oneline --decorate --color -4"
abbr g5 "git log --oneline --decorate --color -5"
abbr g6 "git log --oneline --decorate --color -6"
abbr g7 "git log --oneline --decorate --color -7"
abbr g8 "git log --oneline --decorate --color -8"
abbr g9 "git log --oneline --decorate --color -9"
abbr g10 "git log --oneline --decorate --color -10"
abbr gdc "git diff --cached"
abbr gpsup "git push --set-upstream origin (git rev-parse --abbrev-ref HEAD)"
abbr gcob "git checkout -b"

# Add git files that have been modified
# alias gac="git add (git ls-files -m)"

# Git function to show files changed in commit
function gitf
    set -l commit_hash "$1"

    if [ -z "$commit_hash" ]
        echo "Enter the commit hash as the first argument."
        # no longer true!
        # echo "One way to do this is with \`gitl 10\`."
    end
end

# Git list branches by date, with colors
function gitbd
    git for-each-ref \
        --sort=committerdate refs/heads/ \
        --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'
end

################################################################################
# Tmux
################################################################################
abbr ta "tmux attach -t"
abbr tls "tmux ls"
# rename tmux pane (not the window!)
# function rename_tmux_pane
#   set -l pane_name "$1"
#   printf '\033]2;%s\033\\' "$pane_name"
# end

# Dumb aliases
# abbr grev="grep -v"

# Create new git repo and sync with github
function new_repo
    set -l new_dir "$1"

    mkdir "$new_dir"
    cd "$new_dir"
    git init .
    gh repo create
end

# Exa
abbr -a -g e "eza --icons --git --classify --sort type"
abbr -a -g ee "eza --icons --git --classify -l --sort type"
abbr -a -g ela "eza --icons --git --classify --long --all --sort type"
abbr -a -g et "eza --icons --git --classify --tree --sort type"
abbr -a -g eta "eza --icons --git --classify --tree --all --sort type --level"
abbr -a -g etl "eza --icons --git --classify --tree --git-ignore --level"
abbr -a -g etl1 "eza --icons --git --classify --tree --git-ignore --level 1"
abbr -a -g etl2 "eza --icons --git --classify --tree --git-ignore --level 2"
abbr -a -g etl3 "eza --icons --git --classify --tree --git-ignore --level 3"
abbr -a -g etl4 "eza --icons --git --classify --tree --git-ignore --level 4"
abbr -a -g etal "eza --icons --git --classify --tree -all --level type"
abbr -a -g ett "eza --icons --git -l -s type"

###############################################################################
# Terraform and terragrunt abbreviations
###############################################################################
abbr -a -g tf terraform
abbr -a -g tg terragrunt

###############################################################################
# Neovim
###############################################################################
abbr -a -g nvrl "nvr -l"

###############################################################################
# FZF
###############################################################################
# Override the default fzf options for fzf.fish
# https://github.com/PatrickF1/fzf.fish
export FZF_DEFAULT_OPTS='
  --border=none
  --height=40%
  --no-mouse'
# --preview-window=:hidden'
abbr -a -g vimf "vim (fzf --height 40%)"
fzf --fish | source

function bind_bang
    switch (commandline -t)[-1]
        case '!'
            commandline -t $history[1]
            commandline -f repaint
        case '*'
            commandline -i !
    end
end

function bind_dollar
    switch (commandline -t)[-1]
        case '!'
            commandline -t ''
            commandline -f history-token-search-backward
        case '*'
            commandline -i '$'
    end
end

function fish_user_key_bindings
    bind ! bind_bang
    bind '$' bind_dollar
end

function new_pr_msg_only
    set -l filename "$HOME/github-messages/"(date +'%Y-%m-%d-%H-%M')"-"(git rev-parse --abbrev-ref HEAD)".md"
    vim "$filename"
end

function new_pr_msg
    set -l filename $argv[1]
    #set -l branch $argv[2]

    if [ -z $filename ]
        set filename "$HOME/github-messages/"(date +'%Y-%m-%d-%H-%M')"-"(git rev-parse --abbrev-ref HEAD)".md"
        vim $filename
    end

    # Use hub to open the PR
    # TODO: Change this to use gh instead
    hub pull-request --push --file $filename --browse --draft
end

function gh_new_repo
    set -l repo_name $argv[1]
    set -l repo_desc $argv[2]

    mkdir -p $repo_name
    gh repo create $repo_name \
        --description $repo_desc \
        --private \
        --confirm
    cd $repo_name
end

# Add the bin directory containing psql to the $PATH
# fish_add_path /usr/local/opt/libpq/bin
# fish_add_path "$GOBIN"
fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/bin"
fish_add_path "$HOME/.config/emacs/bin"
fish_add_path /opt/homebrew/bin
fish_add_path "$HOME/.cargo/env.fish"
fish_add_path "$HOME/.krew/bin"
fish_add_path /opt/homebrew/opt/openjdk@17/bin
fish_add_path /opt/homebrew/opt/curl/bin
fish_add_path /opt/homebrew/Cellar/mysql-client/8.2.0/bin
fish_add_path "$BUN_INSTALL/bin"
set -gx CPPFLAGS "-I/opt/homebrew/opt/openjdk@17/include"

# function compare_sha256
#   if [ $# -ne 2 ]
#     echo "ERROR: Please pass the arguments \$input_download_file and \$input_checksum_file"
#     exit 1
#   end
#
#   set input_download_file "$1"
#   set input_checksum_file "$2"
#
#   set input_download_file "(awk '{print $1}' $input_download_file)"
#   set input_checksum_file "(awk '{print $1}' $input_checksum_file)"
#
#   if [ $input_download_file != $input_checksum_file ]
#     echo "ERROR: Input file does not match checksum"
#     exit 1
#   end
# end

# customize the fish greeting
set fish_greeting ''

# Enable colorized pass/fail output for pre-commit
export PRE_COMMIT_COLOR=always

abbr -a -g weather "curl wttr.in"

# bat config
export BAT_THEME="tokyonight_day"

# doom emacs client alias
# alias emacs="emacsclient --create-frame --alternate-editor=emacs"

# Local AWS testing with LocalStack
export LOCALSTACK_AUTH_TOKEN="$(cat ~/.localstack)"
