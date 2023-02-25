# My dotfiles

## Installing onto a new system

1. Clone the dotfiles into a bare repo
```fish
git clone --bare git@github.com:boenkyo/dots.git $HOME/.dots
```

2. Define a temporary alias
```fish
alias dots='/usr/bin/git --git-dir=$HOME/.dots/ --work-tree=$HOME'
```

3. Checkout the content to `$HOME`
```fish
dots checkout
```

4. Set git to hide untracked files
```fish
dots config --local status.showUntrackedFiles no
```
