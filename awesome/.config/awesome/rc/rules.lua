local gears = require("gears")
local awful = require("awful")
-- Theme handling library
local beautiful = require("beautiful")
awful.rules = require("awful.rules")

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     size_hints_honor = false,
                     focus = awful.client.focus.filter,
                     keys = config.keys.client,
                     buttons = config.mouse.client } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "Smplayer" },
      properties = { floating = true } },
    -- web video in firefox
    { rule = { class = "Plugin-container" },
      properties = { floating = true } },
    -- web video in chrome
    { rule = { class = "Exe" },
      properties = { floating = true } },
    -- android screencast
    --{ rule = { class = "net-srcz-android-screencast-Main" },
      --properties = { floating = true } },
    -- top coder javaws 
    { rule = { class = "com-sun-javaws-Main" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
}
-- }}}
