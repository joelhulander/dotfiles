local wezterm = require 'wezterm'
local act = wezterm.action

local config = {}
-- Use config builder object if possible
if wezterm.config_builder then config = wezterm.config_builder() end

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.default_prog = {"pwsh.exe"}
elseif wezterm.target_triple == "aarch64-apple-darwin" then
	config.default_prog = { "/bin/zsh", "-l", "-i" }
	config.native_macos_fullscreen_mode = true
else
	config.default_prog = {"/bin/bash"}
end

wezterm.on('update-right-status', function(window)
	window:set_right_status(window:active_workspace())

	local prefix = ""

	if window:leader_is_active() then
		prefix = " " .. utf8.char(0x1f30a) -- ocean wave
	end

	window:set_left_status(wezterm.format {
		{ Text = prefix },
	})
end)


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

config.show_new_tab_button_in_tab_bar = false

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.show_tabs_in_tab_bar = false
config.tab_max_width = 32
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.9

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

-- Dim inactive panes
config.inactive_pane_hsb = {
	saturation = 0.80,
	brightness = 0.55
}

config.font = wezterm.font("Hack Nerd Font", {weight="Regular", stretch="Normal", style="Normal"})
config.font_size = 12
config.debug_key_events = true

-- Keys
config.leader = { key = "'", mods = "CTRL", timeout_milliseconds = 1500 }
config.keys = {
	-- Send C-a when pressing C-a twice
	{ key = "c",          mods = "LEADER",      action = act.ActivateCopyMode },
	{ key = "phys:Space", mods = "LEADER",      action = act.ActivateCommandPalette },

	-- Pane keybindings
	{ key = "s",          mods = "LEADER",      action = act.SplitVertical { domain = "CurrentPaneDomain" } },
	{ key = "v",          mods = "LEADER",      action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
	{ key = "h",          mods = "LEADER",      action = act.ActivatePaneDirection("Left") },
	{ key = "n",          mods = "LEADER",      action = act.ActivatePaneDirection("Down") },
	{ key = "e",          mods = "LEADER",      action = act.ActivatePaneDirection("Up") },
	{ key = "i",          mods = "LEADER",      action = act.ActivatePaneDirection("Right") },
	{ key = "q",          mods = "LEADER",      action = act.CloseCurrentPane { confirm = true } },
	{ key = "m",          mods = "LEADER",      action = act.TogglePaneZoomState },
	{ key = "o",          mods = "LEADER",      action = act.RotatePanes "Clockwise" },
	-- We can make separate keybindings for resizing panes

	-- Tab keybindings
	{ key = "t",          mods = "LEADER",      action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "[",          mods = "LEADER",      action = act.ActivateTabRelative(-1) },
	{ key = "]",          mods = "LEADER",      action = act.ActivateTabRelative(1) },
	{ key = "phys:Tab",   mods = "LEADER",      action = act.ShowTabNavigator },

	{
		key = "f",
		mods = "LEADER",
		action = act.PromptInputLine {
			description = wezterm.format {
				{ Attribute = { Intensity = "Bold" } },
				{ Foreground = { AnsiColor = "Fuchsia" } },
				{ Text = "Renaming Tab Title...:" },
			},
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:active_tab():set_title(line)
				end
			end)
		}
	},

	-- Or shortcuts to move tab w/o move_tab table. SHIFT is for when caps lock is on
	{ key = "{", mods = "LEADER|SHIFT", action = act.MoveTabRelative(-1) },
	{ key = "}", mods = "LEADER|SHIFT", action = act.MoveTabRelative(1) },

	-- Workspace
	{ key = "w", mods = "LEADER",       action = act.ShowLauncherArgs { flags = "FUZZY|WORKSPACES" } },
	{
		key = 'k',
		mods = 'LEADER',
		action = act.PromptInputLine {
			description = wezterm.format {
				{ Attribute = { Intensity = 'Bold' } },
				{ Foreground = { AnsiColor = 'Fuchsia' } },
				{ Text = 'Enter name for new workspace' },
			},
			action = wezterm.action_callback(function(window, pane, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:perform_action(
						act.SwitchToWorkspace {
							name = line,
						},
						pane
					)
				end
			end),
		},
	},
	{
		key = "r",
		mods = "LEADER",
		action = act.PromptInputLine {
			description = wezterm.format {
				{ Attribute = { Intensity = 'Bold' } },
				{ Foreground = { AnsiColor = 'Fuchsia' } },
				{ Text = 'Enter new name for workspace' },
			},
			action = wezterm.action_callback(function(window, pane, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					wezterm.mux.rename_workspace(
						wezterm.mux.get_active_workspace(),
						line
					)
				end
			end),
		},
	}
}

for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = act.ActivateTab(i - 1)
	})
end

return config
