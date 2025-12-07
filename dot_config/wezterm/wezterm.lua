local wezterm = require 'wezterm'
local act = wezterm.action

local config = {}

local projects_file = io.open(wezterm.home_dir .. '/.config/personal/wezterm-settings.json', 'r')
local projects_table

if projects_file then
	local content = projects_file:read("*a")
	projects_file:close()
	projects_table = wezterm.json_parse(content)
end

-- Use config builder object if possible
if wezterm.config_builder then config = wezterm.config_builder() end

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.default_prog = {"pwsh.exe"}
	config.win32_system_backdrop = "Acrylic"
elseif wezterm.target_triple == "aarch64-apple-darwin" then
	config.default_prog = { "/bin/zsh", "-l", "-i" }
	config.native_macos_fullscreen_mode = true
	config.macos_window_background_blur = 50
elseif wezterm.target_triple == "x86_64-unknown-linux-gnu" then
	config.enable_wayland = false
	-- config.default_prog = { "/usr/bin/zsh", "-l", "-i" }
	config.default_prog = { "/usr/bin/nu", "-l", "-i" }
else
	config.default_prog = {"/bin/bash"}
end

wezterm.on('update-right-status', function(window)
	-- window:set_right_status(window:active_workspace())

	local prefix = ""

	if window:leader_is_active() then
		prefix = " " .. utf8.char(0x1f30a) -- ocean wave
	end

	window:set_left_status(wezterm.format {
		{ Text = prefix },
	})
end)


-- local mux = wezterm.mux

-- wezterm.on('gui-attached', function()
--
-- 	for i, v in ipairs(projects_table) do
-- 		wezterm.log_info('Opening', v.name, 'path:', v.path)
-- 		mux.spawn_window {
-- 			set_environment_variables = { PATH = '/opt/homebrew/bin:' .. os.getenv('PATH') },
-- 			workspace = v.name,
-- 			cwd = v.path,
-- 			args = { 'nvim' },
-- 		}
-- 	end
--
-- 	local dir = wezterm.home_dir
-- 	mux.spawn_window {
-- 		set_environment_variables = { PATH = '/opt/homebrew/bin:' .. os.getenv('PATH') },
-- 		workspace = 'yazi',
-- 		cwd = dir,
-- 		args = { 'yazi' },
-- 	}
--
-- end)

-- Tab bar configuration

config.show_new_tab_button_in_tab_bar = false
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.show_tabs_in_tab_bar = false
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.9

config.initial_cols = 130
config.initial_rows = 45

config.window_padding = {
	left = 20,
	right = 20,
	top = 10,
	bottom = 0,
}

-- Color scheme
config.color_scheme = 'Catppuccin Mocha'

config.colors = {
	tab_bar = {
		background = 'rgba(0,0,0,0)'
	}
}

-- Dim inactive panes
config.inactive_pane_hsb = {
	saturation = 0.80,
	brightness = 0.55
}

config.font = wezterm.font("JetBrainsMono NF", {weight="Regular", stretch="Normal", style="Normal"})
config.font_size = 16
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

-- Keys
config.leader = { key = "'", mods = "CTRL", timeout_milliseconds = 1501 }
config.keys = {
	-- Send C-a when pressing C-a twice
	{ key = "c",          mods = "LEADER",      action = act.ActivateCopyMode },
	{ key = "phys:Space", mods = "LEADER",      action = act.ActivateCommandPalette },
	{ key = 'U', mods = 'CTRL|SHIFT', action = act.DisableDefaultAssignment },

	-- Pane keybindings
	{ key = "v",          mods = "LEADER",      action = act.SplitVertical { domain = "CurrentPaneDomain" } },
	{ key = "s",          mods = "LEADER",      action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
	{ key = "h",          mods = "LEADER",      action = act.ActivatePaneDirection("Left") },
	{ key = "n",          mods = "LEADER",      action = act.ActivatePaneDirection("Down") },
	{ key = "e",          mods = "LEADER",      action = act.ActivatePaneDirection("Up") },
	{ key = "i",          mods = "LEADER",      action = act.ActivatePaneDirection("Right") },
	{ key = "q",          mods = "LEADER",      action = act.CloseCurrentPane { confirm = true } },
	{ key = "z",          mods = "LEADER",      action = act.TogglePaneZoomState },
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
	-- {
	-- 	key = 'h',
	-- 	mods = 'CTRL|SHIFT',
	-- 	action = act.SwitchToWorkspace {
	-- 		name = 'default',
	-- 	},
	-- },
	-- {
	-- 	key = 'n',
	-- 	mods = 'CTRL|SHIFT',
	-- 	action = act.SwitchToWorkspace {
	-- 		name = 'coding',
	-- 	},
	-- },
	-- {
	-- 	key = 'e',
	-- 	mods = 'CTRL|SHIFT',
	-- 	action = act.SwitchToWorkspace {
	-- 		name = 'notes',
	-- 	},
	-- },
	-- {
	-- 	key = 'y',
	-- 	mods = 'CTRL|SHIFT',
	-- 	action = act.SwitchToWorkspace {
	-- 		name = 'yazi',
	-- 	},
	-- },
	-- {
	-- 	key = 'n',
	-- 	mods = 'LEADER',
	-- 	action = act.PromptInputLine {
	-- 		description = wezterm.format {
	-- 			{ Attribute = { Intensity = 'Bold' } },
	-- 			{ Foreground = { AnsiColor = 'Fuchsia' } },
	-- 			{ Text = 'Enter name for new workspace' },
	-- 		},
	-- 		action = wezterm.action_callback(function(window, pane, line)
	-- 			if line then
	-- 				window:perform_action(
	-- 					act.SwitchToWorkspace {
	-- 						name = line,
	-- 					},
	-- 					pane
	-- 				)
	-- 			end
	-- 		end),
	-- 	},
	-- },
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
