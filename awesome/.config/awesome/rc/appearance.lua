-- Theme handling library
local beautiful = require("beautiful")
-- Standard awesome library
local awful = require("awful")

-- Themes define colours, icons, and wallpapers
beautiful.init(awful.util.getdir("config") .."/themes/default/theme.lua")
awesome.font = "monospace 11"
theme.font = "monospace 11"
