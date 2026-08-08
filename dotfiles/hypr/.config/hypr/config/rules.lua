--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

local programs = require("config/programs")

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

hl.window_rule({
    -- Keep the session awake while a game, video, or presentation is fullscreen.
    name  = "fullscreen-idle-inhibit",
    match = { class = ".*" },

    idle_inhibit = "fullscreen",
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

hl.workspace_rule({
    workspace        = "special:terminal",
    on_created_empty = programs.terminal,
})

-- Smart gaps for single tiled windows and maximized workspaces.
-- Special workspaces retain their normal gaps and decoration.
hl.workspace_rule({ workspace = "w[tv1]s[false]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]s[false]", gaps_out = 0, gaps_in = 0 })

hl.window_rule({
    name        = "smart-gaps-single-border",
    match       = { float = false, workspace = "w[tv1]s[false]" },
    border_size = 0,
})
hl.window_rule({
    name     = "smart-gaps-single-rounding",
    match    = { float = false, workspace = "w[tv1]s[false]" },
    rounding = 0,
})
hl.window_rule({
    name        = "smart-gaps-maximized-border",
    match       = { float = false, workspace = "f[1]s[false]" },
    border_size = 0,
})
hl.window_rule({
    name     = "smart-gaps-maximized-rounding",
    match    = { float = false, workspace = "f[1]s[false]" },
    rounding = 0,
})

hl.window_rule({
    -- Keep Firefox Picture-in-Picture visible in the lower-right corner.
    name  = "firefox-picture-in-picture",
    match = {
        class         = "^firefox$",
        initial_title = "^Picture-in-Picture$",
    },

    float             = true,
    pin               = true,
    keep_aspect_ratio = true,
    size              = { "(monitor_w*0.25)", "(monitor_h*0.25)" },
    move              = { "(monitor_w-window_w-24)", "(monitor_h-window_h-24)" },
})

hl.window_rule({
    -- Center application confirmation and settings dialogs.
    name   = "center-modal-dialogs",
    match  = { modal = true },
    float  = true,
    center = true,
})

hl.window_rule({
    -- Float and center utility and settings applications
    name   = "float-utility-apps",
    match  = {
        class = "^(org.gnome.Calculator|org.gnome.DiskUtility|org.gnome.FileRoller|file-roller|pavucontrol|org.pulseaudio.pavucontrol|blueman-manager|nm-connection-editor)$",
    },
    float  = true,
    center = true,
})
