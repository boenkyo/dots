local wezterm = require('wezterm')

local gruvbox =
  wezterm.color.get_builtin_schemes()['Gruvbox dark, pale (base16)']
gruvbox.background = '#282828'

return {
  automatically_reload_config = true,

  -- Font
  font = wezterm.font('Fantasque Sans Mono'),
  font_size = 14,

  -- Lines
  line_height = 1.2,

  -- Color scheme
  color_schemes = {
    ['Gruvbox'] = gruvbox,
  },
  color_scheme = 'Gruvbox',

  -- Tab bar
  hide_tab_bar_if_only_one_tab = true,
  tab_bar_at_bottom = true,
  use_fancy_tab_bar = false,

  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
}
