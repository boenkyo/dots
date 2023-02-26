# Greeting
set fish_greeting

# Abbreviations
abbr -a v nvim
abbr -a s source

# Cursor
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual block

# Variables
set -gx EDITOR nvim

set -gx XDG_DATA_HOME   "$HOME/.local/share"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_STATE_HOME  "$HOME/.local/state"

set -gx GOPATH "$HOME/.go"
set -gx GOBIN "$HOME/.go/bin"

source $XDG_CONFIG_HOME/fish/aliases.fish

# PATH
fish_add_path "$HOME/.go/bin"
