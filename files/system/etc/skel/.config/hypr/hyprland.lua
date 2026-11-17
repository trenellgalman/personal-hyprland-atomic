--[[
    Hyprland Configuration
    Hyprland: 0.57.x
    Terminal: Ghostty
    Desktop Shell: Noctalia v5
]]

--------------------------------------------------
-- APPLICATIONS
--------------------------------------------------

local mainMod = "SUPER"
local terminal = "ghostty"
local noctalia = "noctalia msg "

--------------------------------------------------
-- GENERAL APPEARANCE
--------------------------------------------------

hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 10,
		border_size = 2,
		layout = "dwindle",
	},

	decoration = {
		rounding = 8,
		rounding_power = 2,

		active_opacity = 1.0,
		inactive_opacity = 1.0,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = 0xee1a1a1a,
		},

		blur = {
			enabled = true,
			size = 3,
			passes = 2,
			vibrancy = 0.15,
		},
	},

	input = {
		kb_layout = "us",
		follow_mouse = 1,
		sensitivity = 0,
	},

	dwindle = {
		preserve_split = true,
	},

	misc = {
		disable_hyprland_logo = true,
		force_default_wallpaper = 0,
	},
})

--------------------------------------------------
-- ENVIRONMENT
--------------------------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

--------------------------------------------------
-- AUTOSTART
--------------------------------------------------

hl.on("hyprland.start", function()
	hl.exec_cmd("noctalia")
end)

--------------------------------------------------
-- TERMINAL
--------------------------------------------------

-- Super + Enter: Open Ghostty
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))

--------------------------------------------------
-- NOCTALIA SHORTCUTS
--------------------------------------------------

-- Super + Space: Application launcher
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(noctalia .. "panel-toggle launcher"))

-- Super + S: Control center
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd(noctalia .. "panel-toggle control-center"))

-- Super + Comma: Settings
hl.bind(mainMod .. " + comma", hl.dsp.exec_cmd(noctalia .. "settings-toggle"))

-- Alt + Tab: Window switcher
hl.bind("ALT + Tab", hl.dsp.exec_cmd(noctalia .. "window-switcher hold"))

-- Alt + Shift + Tab: Reverse window switcher
hl.bind("ALT + SHIFT + Tab", hl.dsp.exec_cmd(noctalia .. "window-switcher hold reverse"))

--------------------------------------------------
-- WINDOW MANAGEMENT
--------------------------------------------------

-- Super + Q: Close active window gracefully
hl.bind(mainMod .. " + Q", hl.dsp.window.close())

-- Super + V: Toggle floating
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))

-- Super + F: Toggle fullscreen
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))

-- Super + P: Toggle pseudotiling
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

--------------------------------------------------
-- WORKSPACES
--------------------------------------------------

-- Super + 1 through 9: Switch workspace
-- Super + Shift + 1 through 9: Move window
for i = 1, 9 do
	local key = tostring(i)

	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))

	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

--------------------------------------------------
-- WINDOW FOCUS
--------------------------------------------------

hl.bind(mainMod .. " + LEFT", hl.dsp.focus({ direction = "left" }))

hl.bind(mainMod .. " + RIGHT", hl.dsp.focus({ direction = "right" }))

hl.bind(mainMod .. " + UP", hl.dsp.focus({ direction = "up" }))

hl.bind(mainMod .. " + DOWN", hl.dsp.focus({ direction = "down" }))

--------------------------------------------------
-- WINDOW MOVEMENT
--------------------------------------------------

hl.bind(mainMod .. " + SHIFT + LEFT", hl.dsp.window.move({ direction = "left" }))

hl.bind(mainMod .. " + SHIFT + RIGHT", hl.dsp.window.move({ direction = "right" }))

hl.bind(mainMod .. " + SHIFT + UP", hl.dsp.window.move({ direction = "up" }))

hl.bind(mainMod .. " + SHIFT + DOWN", hl.dsp.window.move({ direction = "down" }))

--------------------------------------------------
-- MOUSE WINDOW MANAGEMENT
--------------------------------------------------

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })

hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

--------------------------------------------------
-- MEDIA AND HARDWARE KEYS
--------------------------------------------------

-- Volume
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(noctalia .. "volume-up"), { locked = true, repeating = true })

hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(noctalia .. "volume-down"), { locked = true, repeating = true })

hl.bind("XF86AudioMute", hl.dsp.exec_cmd(noctalia .. "volume-mute"), { locked = true })

-- Display brightness
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(noctalia .. "brightness-up"), { locked = true, repeating = true })

hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(noctalia .. "brightness-down"), { locked = true, repeating = true })

--------------------------------------------------
-- NOCTALIA LAYER RULES
--------------------------------------------------

-- Noctalia handles its own surface animations.
-- Prevent additional Hyprland layer animations.

hl.layer_rule({
	name = "noctalia-no-anim",

	match = {
		namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$",
	},

	no_anim = true,
})
