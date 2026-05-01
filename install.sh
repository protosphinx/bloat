#!/usr/bin/env bash
# install.sh - symlink dotfiles into $HOME and (optionally) install Brewfile.
#
# Idempotent: re-running is safe. Existing files are backed up to
# ~/.bloat-backup-<timestamp>/ before being replaced.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.bloat-backup-$(date +%Y%m%d-%H%M%S)"

dotfiles=(
    .zshrc
    .gitconfig
)

claude_files=(
    .claude/CLAUDE.md
)

backup_then_link() {
    local src="$REPO_DIR/$1"
    local dst="$HOME/$1"
    if [[ -e "$dst" && ! -L "$dst" ]]; then
        mkdir -p "$BACKUP_DIR/$(dirname "$1")"
        mv "$dst" "$BACKUP_DIR/$1"
        echo "  backed up existing $dst -> $BACKUP_DIR/$1"
    elif [[ -L "$dst" ]]; then
        rm "$dst"
    fi
    mkdir -p "$(dirname "$dst")"
    ln -s "$src" "$dst"
    echo "  linked $src -> $dst"
}

echo "==> Linking dotfiles"
for f in "${dotfiles[@]}"; do
    backup_then_link "$f"
done

echo "==> Linking Claude rules"
for f in "${claude_files[@]}"; do
    backup_then_link "$f"
done

echo "==> Linking bin/"
mkdir -p "$HOME/.local/bin"
for script in "$REPO_DIR"/bin/*; do
    if [[ -f "$script" ]]; then
        local_name="$(basename "$script")"
        target="$HOME/.local/bin/$local_name"
        [[ -L "$target" ]] && rm "$target"
        ln -s "$script" "$target"
        chmod +x "$script"
        echo "  linked $script -> $target"
    fi
done

if [[ "${1:-}" == "--brew" ]]; then
    echo "==> Installing Brewfile"
    if ! command -v brew >/dev/null; then
        echo "  brew not found; install from https://brew.sh first"
        exit 1
    fi
    brew bundle --file="$REPO_DIR/Brewfile"
fi

if [[ -d "$BACKUP_DIR" ]]; then
    echo
    echo "Backups: $BACKUP_DIR"
fi
echo "Done. Open a new shell."
