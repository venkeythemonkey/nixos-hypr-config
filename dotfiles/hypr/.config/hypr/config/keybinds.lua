---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local programs = require("config/programs")


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(programs.terminal), { description = "Open terminal" })
local closeWindowBind = hl.bind(mainMod .. " + C", hl.dsp.window.close(), { description = "Close active window" })
-- closeWindowBind:set_enabled(false)
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd("loginctl lock-session"), { description = "Lock session" })
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd(programs.sessionMenu), { description = "Open session menu" })
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(programs.fileManager), { description = "Open file manager" })
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(programs.clipboard), { description = "Open clipboard history" })
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.window.float({ action = "toggle" }), { description = "Toggle floating window" })
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(programs.appLauncher), { description = "Open application launcher" })
hl.bind(mainMod .. " + TAB", hl.dsp.exec_cmd(programs.windowSwitcher), { description = "Open window switcher" })
hl.bind(mainMod .. " + grave", hl.dsp.focus({ workspace = "previous" }), { description = "Open previous workspace" })
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo(), { description = "Toggle pseudotiling" })
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"), { description = "Toggle dwindle split direction" })    -- dwindle only

-- Take an interactive screenshot
hl.bind("Print",         hl.dsp.exec_cmd(programs.screenshotRegion), { description = "Capture screen region" })
hl.bind("SHIFT + Print", hl.dsp.exec_cmd(programs.screenshotFull),   { description = "Capture a monitor" })

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }),  { description = "Focus left" })
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }), { description = "Focus right" })
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }),    { description = "Focus up" })
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }),  { description = "Focus down" })

-- Move windows with mainMod + Shift + arrow keys
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ direction = "left" }),  { description = "Move window left" })
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }), { description = "Move window right" })
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.move({ direction = "up" }),    { description = "Move window up" })
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.move({ direction = "down" }),  { description = "Move window down" })

-- Resize windows with mainMod + Control + arrow keys
hl.bind(mainMod .. " + CTRL + left",  hl.dsp.window.resize({ x = -30, y = 0, relative = true }), { repeating = true, description = "Resize window left" })
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.resize({ x = 30,  y = 0, relative = true }), { repeating = true, description = "Resize window right" })
hl.bind(mainMod .. " + CTRL + up",    hl.dsp.window.resize({ x = 0, y = -30, relative = true }), { repeating = true, description = "Resize window up" })
hl.bind(mainMod .. " + CTRL + down",  hl.dsp.window.resize({ x = 0, y = 30,  relative = true }), { repeating = true, description = "Resize window down" })

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i}),             { description = "Open workspace " .. i })
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }),      { description = "Move window to workspace " .. i })
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("terminal"),               { description = "Toggle terminal scratchpad" })
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:terminal" }),    { description = "Move window to terminal scratchpad" })

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }), { description = "Open next workspace" })
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }), { description = "Open previous workspace" })

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true, description = "Drag window" })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize window" })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true, description = "Raise volume" })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true, description = "Lower volume" })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true, description = "Toggle audio mute" })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true, description = "Toggle microphone mute" })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true, description = "Raise display brightness" })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true, description = "Lower display brightness" })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true, description = "Play next track" })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true, description = "Toggle media playback" })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true, description = "Toggle media playback" })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true, description = "Play previous track" })
