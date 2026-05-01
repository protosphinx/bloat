# bloat/Brewfile - everything you were told not to install.
#
# `brew bundle install` reads this; tagged sections let you opt out of
# whole groups via:
#     brew bundle install --no-lock
#     BUNDLE_TAGS=core brew bundle install
#
# Most of these are well-justified. The ones that aren't are honest about it.

# ---------------------------------------------------------------------------
# Tap.
# ---------------------------------------------------------------------------
tap "homebrew/bundle"
tap "homebrew/services"

# ---------------------------------------------------------------------------
# Core CLI - the things that should ship in the OS.
# ---------------------------------------------------------------------------
brew "coreutils"      # GNU versions of ls, dd, etc. Mac defaults are BSD.
brew "findutils"      # gfind, gxargs.
brew "gnu-sed"
brew "moreutils"      # sponge, ts, vipe.
brew "gawk"
brew "watch"

# ---------------------------------------------------------------------------
# Modern replacements - the "don't install these" tier that you should install.
# ---------------------------------------------------------------------------
brew "bat"            # cat with syntax highlighting.
brew "eza"            # ls successor.
brew "fd"             # find successor.
brew "ripgrep"        # grep successor.
brew "fzf"            # fuzzy finder.
brew "zoxide"         # smart cd.
brew "jq"             # JSON pipelines.
brew "yq"             # YAML/TOML pipelines.
brew "htop"
brew "btop"           # if you want the prettier htop.
brew "tldr"
brew "tree"
brew "wget"
brew "curl"

# ---------------------------------------------------------------------------
# Dev.
# ---------------------------------------------------------------------------
brew "git"
brew "git-delta"      # better diff renderer.
brew "gh"             # GitHub CLI.
brew "lazygit"        # TUI git frontend; controversial, install anyway.
brew "neovim"
brew "tmux"
brew "tmuxinator"
brew "direnv"

# ---------------------------------------------------------------------------
# Languages and toolchains.
# ---------------------------------------------------------------------------
brew "rustup"         # 'rustup-init' actually; for rustc/cargo.
brew "node"
brew "pnpm"
brew "uv"             # python package + project manager.
brew "go"

# ---------------------------------------------------------------------------
# Cloud / containers.
# ---------------------------------------------------------------------------
brew "kubectl"
brew "k9s"
brew "awscli"
cask "docker"
cask "orbstack"       # docker desktop alternative.

# ---------------------------------------------------------------------------
# Editor / IDE.
# ---------------------------------------------------------------------------
cask "ghostty"        # the only terminal that has earned its bloat.
cask "visual-studio-code"
cask "raycast"

# ---------------------------------------------------------------------------
# Fonts.
# ---------------------------------------------------------------------------
cask "font-jetbrains-mono-nerd-font"
cask "font-fira-code-nerd-font"

# ---------------------------------------------------------------------------
# Apps.
# ---------------------------------------------------------------------------
cask "rectangle"      # window snapping; you'll forget you have it.
cask "stats"          # menubar system monitor.
cask "the-unarchiver"
