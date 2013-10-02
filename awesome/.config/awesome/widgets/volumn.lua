-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")

cardid  = 0
channel = "Master"
function volume (mode, widget)
   if mode == "update" then
             local fd = io.popen("amixer -c " .. cardid .. " -- sget " .. channel)
             local status = fd:read("*all")
             fd:close()

       local vol = string.match(status, "(%d?%d?%d)%%")
       vol = string.format("% 3d", vol)

       status = string.match(status, "%[(o[^%]]*)%]")

       if string.find(status, "on", 1, true) then
           vol = vol .. "%"
       else
           vol = vol .. "M"
       end
       widget.text = vol
   elseif mode == "up" then
       io.popen("amixer -q -c " .. cardid .. " sset " .. channel .. " 5%+"):read("*all")
       volume("update", widget)
   elseif mode == "down" then
       io.popen("amixer -q -c " .. cardid .. " sset " .. channel .. " 5%-"):read("*all")
       volume("update", widget)
   else
       io.popen("amixer -c " .. cardid .. " sset " .. channel .. " toggle"):read("*all")
       volume("update", widget)
   end
end
