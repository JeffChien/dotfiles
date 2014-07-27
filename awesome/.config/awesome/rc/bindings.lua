local awful = require("awful")
local beautiful = require("beautiful")
local hints = require("hints")
local quake = require("quake")

local quakeconsole = {}
for s=1, screen.count() do
    quakeconsole[s] = quake({
        terminal = 'uxterm',
        height = 0.25,
        screen = s
    })
end

-- must after beatuful.init()
hints.init()

config.keys = {}
config.mouse = {}

-- {{{ Mouse bindings
config.mouse.global = awful.util.table.join(
    awful.button({ }, 3, function () config.menu.main:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
)
-- }}}

--- {{{ global keymap
config.keys.global = awful.util.table.join(
    awful.key({ modkey,           }, "q",  function() quakeconsole[mouse.screen]:toggle() end      ),
    awful.key({ modkey,           }, ",",  awful.tag.viewprev       ),
    awful.key({ modkey,           }, ".",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),
    awful.key({ modkey,           }, "g", function() hints.focus() end),
    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () config.menu.main:show({keygrabber=true}) end),
    awful.key({ "Mod1" }, "Escape",
        function ()
            awful.menu.menu_keys.down = { "Down", "Alt_L" }
            local cmenu = awful.menu.clients({width=500}, {keygrabber=true, coords={x=525, y=300}})
        end
    ),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(config.terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q",     function ()
            if os.getenv("DESKTOP_SESSION") == "awesome-gnome" then
                os.execute("/usr/bin/gnome-session-quit")
            else
                awesome.quit()
            end
        end),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.025)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.025)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(config.layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(config.layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),


    -- Run or raise applications with dmenu
    awful.key({ modkey },            "r",     function ()
        awful.util.spawn("/usr/local/bin/dmenu_run -fn 'LiHei Pro-11' -b -i -p 'Run command:' -nb '" ..
            beautiful.bg_normal .. "' -nf '" .. beautiful.fg_normal ..
            "' -sb '" .. beautiful.bg_focus ..
            "' -sf '" .. beautiful.fg_focus .. "'")
        end),
    --- Move focus window with keyboard {{{
    awful.key({ modkey }, "Down",  function () awful.client.moveresize(  0,  20,   0,   0) end),
    awful.key({ modkey }, "Up",    function () awful.client.moveresize(  0, -20,   0,   0) end),
    awful.key({ modkey }, "Left",  function () awful.client.moveresize(-20,   0,   0,   0) end),
    awful.key({ modkey }, "Right", function () awful.client.moveresize( 20,   0,   0,   0) end),
    ---}}}
    --- Reisze focus window with keyboard {{{
    awful.key({ modkey, "Shift" }, "Down",  function () awful.client.moveresize(  0,   0,   0,  40) end),
    awful.key({ modkey, "Shift" }, "Up",    function () awful.client.moveresize(  0,   0,   0, -40) end),
    awful.key({ modkey, "Shift" }, "Left",  function () awful.client.moveresize(  0,   0, -20,   0) end),
    awful.key({ modkey, "Shift" }, "Right", function () awful.client.moveresize(  0,   0,  20,   0) end),
    awful.key({ modkey }, "Next",  function () awful.client.moveresize( 20,  20, -40, -40) end),
    awful.key({ modkey }, "Prior", function () awful.client.moveresize(-20, -20,  40,  40) end),
    ---}}}

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)

)

config.keys.client = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey, "Shift"   }, "t",
            function (c)
                if c.titlebar then
                    awful.titlebar.remove(c)
                else
                    awful.titlebar.add(c, { modkey = modkey })
                end
            end),
    awful.key({ modkey, "Shift"   }, ",",
       function (c)
           local maxtag = #awful.tag.gettags(mouse.screen)
           local curidx = awful.tag.getidx()
           if curidx == 1 then
               awful.client.movetotag(tags[mouse.screen][maxtag])
           else
               awful.client.movetotag(tags[mouse.screen][curidx - 1])
           end
           awful.tag.viewprev(mouse.screen)
       end),
    awful.key({ modkey, "Shift"   }, ".",
       function (c)
           local maxtag = #awful.tag.gettags(mouse.screen)
           local curidx = awful.tag.getidx()
           if curidx == maxtag then
               awful.client.movetotag(tags[mouse.screen][1])
           else
               awful.client.movetotag(tags[mouse.screen][curidx + 1])
           end
           awful.tag.viewnext(mouse.screen)
       end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(10, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    config.keys.global = awful.util.table.join(config.keys.global,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      local tag = awful.tag.gettags(client.focus.screen)[i]
                      if client.focus and tag then
                          awful.client.movetotag(tag)
                     end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      local tag = awful.tag.gettags(client.focus.screen)[i]
                      if client.focus and tag then
                          awful.client.toggletag(tag)
                      end
                  end))
end

config.mouse.client = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))
--- }}}
