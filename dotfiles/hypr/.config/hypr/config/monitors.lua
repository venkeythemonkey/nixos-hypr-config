------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

local laptop_output = "eDP-1"
local tv_description = "LG Electronics LG TV SSCR2 0x01010101"
local tv_output = "desc:" .. tv_description
local tv_activation_delay_ms = 5000
local noctalia_refresh_delay_ms = 1000
local pending_tv_activation
local pending_noctalia_refresh

local function has_active_monitor(predicate)
    for _, monitor in ipairs(hl.get_monitors()) do
        if predicate(monitor) then
            return true
        end
    end

    return false
end

local function laptop_is_active()
    return has_active_monitor(function(monitor)
        return monitor.name == laptop_output
    end)
end

local function tv_is_active()
    return has_active_monitor(function(monitor)
        return monitor.description == tv_description
    end)
end

local function physical_monitor_is_active()
    return has_active_monitor(function(monitor)
        return monitor.name ~= "FALLBACK"
    end)
end

local function set_monitor_rule(output, disabled)
    hl.monitor({
        output   = output,
        mode     = "preferred",
        position = "auto",
        scale    = 1,
        disabled = disabled,
    })
end

local function set_laptop_disabled(disabled)
    if laptop_is_active() == (not disabled) then
        return false
    end

    set_monitor_rule(laptop_output, disabled)
    return true
end

local function cancel_pending_noctalia_refresh()
    if pending_noctalia_refresh then
        pending_noctalia_refresh:set_enabled(false)
        pending_noctalia_refresh = nil
    end
end

local function schedule_noctalia_bar_refresh()
    cancel_pending_noctalia_refresh()

    pending_noctalia_refresh = hl.timer(function()
        pending_noctalia_refresh = nil
        hl.exec_cmd("if command -v noctalia >/dev/null 2>&1; then noctalia msg bar-hide && noctalia msg bar-show; fi")
    end, {
        timeout = noctalia_refresh_delay_ms,
        type = "oneshot",
    })
end

local function cancel_pending_tv_activation()
    if pending_tv_activation then
        pending_tv_activation:set_enabled(false)
        pending_tv_activation = nil
    end
end

local function activate_tv_profile()
    pending_tv_activation = nil

    if not tv_is_active() or not laptop_is_active() then
        return
    end

    if set_laptop_disabled(true) then
        schedule_noctalia_bar_refresh()
    end
end

local function schedule_tv_activation()
    if not tv_is_active() or not laptop_is_active() then
        return
    end

    if pending_tv_activation and pending_tv_activation:is_enabled() then
        return
    end

    pending_tv_activation = hl.timer(activate_tv_profile, {
        timeout = tv_activation_delay_ms,
        type = "oneshot",
    })
end

local function reconcile_monitor_profile()
    if not physical_monitor_is_active() then
        cancel_pending_tv_activation()
        cancel_pending_noctalia_refresh()
        return
    end

    if tv_is_active() then
        schedule_tv_activation()
    else
        cancel_pending_tv_activation()
        if set_laptop_disabled(false) then
            schedule_noctalia_bar_refresh()
        end
    end
end

-- Safe defaults for unknown outputs plus stable rules for this laptop and TV.
set_monitor_rule("", false)
set_monitor_rule(tv_output, false)
set_monitor_rule(laptop_output, tv_is_active() and not laptop_is_active())

hl.on("hyprland.start", reconcile_monitor_profile)
hl.on("config.reloaded", reconcile_monitor_profile)
hl.on("monitor.added", reconcile_monitor_profile)
hl.on("monitor.layout_changed", reconcile_monitor_profile)

hl.on("monitor.removed", function(monitor)
    if monitor.description == tv_description then
        cancel_pending_tv_activation()
        if set_laptop_disabled(false) then
            schedule_noctalia_bar_refresh()
        end
        return
    end

    reconcile_monitor_profile()
end)
