local awful = require("awful")

tags = {
    names = { "➊", "➋", "➌", "➍", "➎", "➏", "➐", "➑", "➒", "➓" }
    }
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag(tags.names, s, config.layouts[1])
end
