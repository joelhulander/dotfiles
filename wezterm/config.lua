local wezterm = require 'wezterm'

local config = {}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.default_prog = {"pwsh.exe"}
elseif wezterm.target_triple == "aarch64-apple-darwin" then
	config.default_prog = { "/bin/zsh", "-l", "-i" }
else
	config.default_prog = {"/bin/bash"}
end

-- Catppuccin Macchiato colors
local colors = {
  rosewater = "#f4dbd6",
  flamingo = "#f0c6c6",
  pink = "#f5bde6",
  mauve = "#c6a0f6",
  red = "#ed8796",
  maroon = "#ee99a0",
  peach = "#f5a97f",
  yellow = "#eed49f",
  green = "#a6da95",
  teal = "#8bd5ca",
  sky = "#91d7e3",
  sapphire = "#7dc4e4",
  blue = "#8aadf4",
  lavender = "#b7bdf8",
  text = "#cad3f5",
  subtext1 = "#b8c0e0",
  subtext0 = "#a5adcb",
  overlay2 = "#939ab7",
  overlay1 = "#8087a2",
  overlay0 = "#6e738d",
  surface2 = "#5b6078",
  surface1 = "#494d64",
  surface0 = "#363a4f",
  base = "#24273a",
  mantle = "#1e2030",
  crust = "#181926",
}

-- Tab bar configuration
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_max_width = 32
config.window_decorations = "RESIZE"
config.native_macos_fullscreen_mode = true

config.initial_cols = 130
config.initial_rows = 45

config.window_padding = {
  left = 10,
  right = 10,
  top = 10,  -- This could be causing extra space at the top
  bottom = 10,
}

-- Color scheme
config.color_scheme = 'Catppuccin Macchiato'

-- Tab bar colors
config.colors = {
  tab_bar = {
    background = colors.mantle,
    active_tab = {
      bg_color = colors.blue,
      fg_color = colors.mantle,
    },
    inactive_tab = {
      bg_color = colors.surface0,
      fg_color = colors.subtext1,
    },
    inactive_tab_hover = {
      bg_color = colors.surface1,
      fg_color = colors.text,
    },
    new_tab = {
      bg_color = colors.surface0,
      fg_color = colors.subtext1,
    },
    new_tab_hover = {
      bg_color = colors.surface1,
      fg_color = colors.text,
    },
  },
}

config.font = wezterm.font("Hack Nerd Font", {weight="Regular", stretch="Normal", style="Normal"})
config.font_size = 12

-- Custom tab title format
wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local title = ' ' .. tab.active_pane.title .. ' '
  return {
    {Text=title},
  }
end)

return config
