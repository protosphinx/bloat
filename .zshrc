#!/usr/bin/env zsh
# bloat/.zshrc - everything you were told not to install.
#
# Order matters here: paths first, then options, then prompt, then aliases,
# then plugins, then per-machine overrides. Keep it that way.

# ---------------------------------------------------------------------------
# Paths.
# ---------------------------------------------------------------------------
typeset -U path PATH
path=(
    $HOME/bin
    $HOME/.local/bin
    $HOME/.cargo/bin
    /opt/homebrew/bin
    /opt/homebrew/sbin
    /usr/local/bin
    /usr/local/sbin
    /usr/bin
    /usr/sbin
    /bin
    /sbin
)
export PATH

# Editor.
export EDITOR=${EDITOR:-vim}
export VISUAL=$EDITOR

# Locale (sane defaults; override per-machine if needed).
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# ---------------------------------------------------------------------------
# History.
# ---------------------------------------------------------------------------
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE HIST_REDUCE_BLANKS
setopt SHARE_HISTORY APPEND_HISTORY HIST_VERIFY HIST_FIND_NO_DUPS

# ---------------------------------------------------------------------------
# Shell options.
# ---------------------------------------------------------------------------
setopt AUTO_CD              # 'foo' alone cd's into foo
setopt AUTO_PUSHD           # cd pushes the previous dir onto the stack
setopt PUSHD_IGNORE_DUPS    # never duplicate dirs in the stack
setopt EXTENDED_GLOB        # better globbing (#, ^, ~)
setopt INTERACTIVE_COMMENTS # # comments inside interactive shells
setopt NO_BEEP              # no audible bell, ever

# ---------------------------------------------------------------------------
# Completion.
# ---------------------------------------------------------------------------
autoload -Uz compinit && compinit -C
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# ---------------------------------------------------------------------------
# Prompt - minimal but git-aware.
# ---------------------------------------------------------------------------
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats ' %F{yellow}%b%f'
precmd() { vcs_info }
setopt PROMPT_SUBST
PROMPT='%F{cyan}%~%f${vcs_info_msg_0_} %F{magenta}»%f '

# ---------------------------------------------------------------------------
# Aliases - opinionated. Read once, override locally.
# ---------------------------------------------------------------------------

# Modern replacements for everyday tools.
command -v eza   >/dev/null && alias ls='eza --group-directories-first' \
                                  la='eza -la --git --group-directories-first' \
                                  ll='eza -l --git --group-directories-first' \
                                  tree='eza --tree'
command -v bat   >/dev/null && alias cat='bat --paging=never'
command -v fd    >/dev/null && alias find='fd'
command -v rg    >/dev/null && alias grep='rg'

# Git ergonomics.
alias g='git'
alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gcm='git commit -m'
alias gca='git commit --amend --no-edit'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gl='git log --oneline --decorate --graph -20'
alias gll='git log --oneline --decorate --graph --all -40'

# Cargo.
alias c='cargo'
alias ct='cargo test'
alias cc='cargo check'
alias cb='cargo build'
alias cr='cargo run'
alias cl='cargo clippy --all-targets'
alias cw='cargo watch -x test'

# Misc.
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias mkdir='mkdir -p'
alias h='history 50'
alias ports='lsof -iTCP -sTCP:LISTEN -P'
alias path='echo -e ${PATH//:/\\n}'

# ---------------------------------------------------------------------------
# Functions.
# ---------------------------------------------------------------------------

# mkcd: make a dir and cd into it.
mkcd() { mkdir -p "$1" && cd "$1" }

# extract: detect archive type and extract.
extract() {
    [[ -f "$1" ]] || { echo "extract: '$1' not a file"; return 1 }
    case "$1" in
        *.tar.bz2|*.tbz2) tar xjf "$1" ;;
        *.tar.gz|*.tgz)   tar xzf "$1" ;;
        *.tar.xz)         tar xJf "$1" ;;
        *.tar)            tar xf "$1" ;;
        *.zip)            unzip "$1" ;;
        *.gz)             gunzip "$1" ;;
        *.bz2)            bunzip2 "$1" ;;
        *.rar)            unrar x "$1" ;;
        *.7z)             7z x "$1" ;;
        *)                echo "extract: don't know how to handle '$1'"; return 1 ;;
    esac
}

# scratch: open a fresh scratch markdown file in the editor.
scratch() {
    local f="${TMPDIR:-/tmp}/scratch-$(date +%Y%m%d-%H%M%S).md"
    ${EDITOR:-vim} "$f"
}

# ---------------------------------------------------------------------------
# Tool integrations (lazy - only fire if installed).
# ---------------------------------------------------------------------------

# fzf: ctrl-r history, ctrl-t file picker.
[[ -f $HOME/.fzf.zsh ]] && source $HOME/.fzf.zsh

# zoxide: smarter cd. `z` jumps to most-frecent matching dir.
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"

# starship: alternative prompt, only if installed AND the user opts in.
[[ -n "$BLOAT_USE_STARSHIP" ]] && command -v starship >/dev/null && eval "$(starship init zsh)"

# direnv: per-dir env loading.
command -v direnv >/dev/null && eval "$(direnv hook zsh)"

# ---------------------------------------------------------------------------
# Per-machine overrides. Keep one .zshrc.local per host out of the repo.
# ---------------------------------------------------------------------------
[[ -f $HOME/.zshrc.local ]] && source $HOME/.zshrc.local
