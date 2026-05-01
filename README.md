<h1 align="center">bloat</h1>

<p align="center"><em>everything you were told not to install.</em></p>

---

Dotfiles. Maximalist. Unrepentant.

Minimalism is a lifestyle for people whose machines aren't load-bearing. This repo is the opposite: every alias, every plugin, every Claude Code rule, every shell function accreted while building things at speed.

## What's in here

```
.zshrc                  shell config: paths, history, prompt, aliases, fns
.gitconfig              git config + alias set; pulls in ~/.gitconfig.local
.gitignore_global       repo-agnostic excludes (DS_Store, swp, target/, ...)
.claude/CLAUDE.md       global Claude Code rules (no em dashes, etc.)
Brewfile                opinionated `brew bundle` of CLIs, casks, fonts
bin/scratch             open a fresh dated markdown file
bin/wd                  one-line "what dir am I in" summary
bin/yap                 lo-fi append-only journal at ~/.yap
install.sh              symlink everything into $HOME (idempotent, backs up)
```

## Install

```bash
git clone https://github.com/protosphinx/bloat ~/.bloat
cd ~/.bloat
./install.sh           # symlink dotfiles + bin/ scripts
./install.sh --brew    # also: brew bundle install
```

`install.sh` is idempotent. Pre-existing dotfiles are moved to `~/.bloat-backup-<timestamp>/` before being replaced; nothing is overwritten silently.

## Per-machine overrides

The dotfiles source local files at the end if they exist. Keep secrets and host-specific tweaks in:

- `~/.zshrc.local` (sourced from `.zshrc` last)
- `~/.gitconfig.local` (included from `.gitconfig` last)

Both are gitignored by `.gitignore_global` so you can't accidentally commit them upstream.

## Philosophy

Take what you want. Or don't. The configs are tuned for one operator; your mileage will vary.

Curator: [@protosphinx](https://x.com/protosphinx).
