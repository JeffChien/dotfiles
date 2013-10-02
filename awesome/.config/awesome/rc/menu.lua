local awful = require("awful")
local menubar = require("menubar")
local beautiful = require("beautiful")

config.menu = {}

-- {{{ Menu
-- Create a laucher widget and a main menu
local awesome_menu_items = {
   { "manual", config.terminal .. " -e man awesome" },
   { "edit config", config.editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

config.menu.main = awful.menu({ items = { { "awesome", awesome_menu_items, beautiful.awesome_icon },
                                    { "open terminal", config.terminal },
                                    { "Log out", awful.util.getdir("config") .. '/scripts/shutdown_dialog' },
                                  }
                        })

-- Menubar configuration
menubar.utils.terminal = config.terminal -- Set the terminal for applications that require it
-- }}}
