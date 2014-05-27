-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")

-- {{{ Wallpaper
local wall_d = os.getenv("HOME") .. "/Pictures"
for s = 1, screen.count() do
    local wall_s = wall_d .. "/screen-" .. tostring(s) .. ".jpg"
    if not awful.util.file_readable(wall_s) then
        wall_s = beautiful.wallpaper
    end
    gears.wallpaper.maximized(wall_s, s, true)
end
-- }}}
