local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local vicious = require("vicious")
local calendar2 = require("calendar2")
local alsawidget = require("simpleVolume")
local blingbling = require("blingbling")

config.screen = {}
for s = 1, screen.count() do
    config.screen[s] = {}
end

local launcher = {}
local layoutbox = {}
local taglist = {}
local tasklist = {}
local promptbox = {}
local textclock = {}
local memwidget = {}
local cpuwidget = {}

-- widgets {{{
-- {{{textclock widget
textclock = awful.widget.textclock()
calendar2.addCalendarToWidget(textclock)
-- }}}

-- {{{ memory widget
memwidget = wibox.widget.textbox()
vicious.register(memwidget, vicious.widgets.mem, "$1% ($2MB) | ", 13)
-- }}}

-- {{{ CPU usage widget
cpuwidget = wibox.widget.textbox()
vicious.register(cpuwidget, vicious.widgets.cpu, "CPU:$1% | ", 13)
-- }}}

-- {{{ launcher
launcher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = config.menu.main })
-- }}}

-- {{{ taglist
taglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
for s = 1, screen.count() do
    -- Create a taglist widget
    taglist[s] = awful.widget.taglist(s,
                                    awful.widget.taglist.filter.all,
                                    taglist.buttons)
end
-- }}}

-- {{{ prompbox
for s = 1, screen.count() do
    promptbox[s] = awful.widget.prompt()
end
-- }}}

-- {{{ layoutbox
for s = 1, screen.count() do
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    layoutbox[s] = awful.widget.layoutbox(s)
    layoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(config.layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(config.layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(config.layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(config.layouts, -1) end)))
end
-- }}}

--- {{{ tasklist
tasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a tasklist widget
    tasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist.buttons)
end
--- }}}
-- }}} widgets

--- container {{{
--- {{{ top bar
for s = 1, screen.count() do
    -- Create the wibox container
    config.screen[s].topbar = awful.wibox({ position = "top", screen = s })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(launcher)
    left_layout:add(taglist[s])
    left_layout:add(promptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    right_layout:add(cpuwidget)
    right_layout:add(memwidget)
    right_layout:add(textclock)
    right_layout:add(alsawidget.bar)
    right_layout:add(layoutbox[s])

    if s == 1 then right_layout:add(wibox.widget.systray()) end

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_right(right_layout)

    config.screen[s].topbar:set_widget(layout)
end
--- }}}
--- {{{ bottom bar
for s = 1, screen.count() do
    -- Create the taskbox
    local center_layout = wibox.layout.align.horizontal()
    config.screen[s].bottom_bar = awful.wibox({ position = "bottom", screen = s })
    config.screen[s].bottom_bar:set_widget(tasklist[s])
end
--- }}}
--- }}} container
