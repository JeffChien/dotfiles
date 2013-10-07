-- Standard awesome library
local awful = require("awful")

-- set default
--local setDefault = {
    ----- default browser
   --"xdg-mime default " .. config.browser .. ".desktop x-scheme-handler/http",
   --"xdg-mime default " .. config.browser .. ".desktop x-scheme-handler/https",
   --"xdg-mime default " .. config.browser .. ".desktop text/html",
--}

--os.execute(table.concat(setDefault, ";"))


awful.util.spawn_with_shell(awful.util.getdir("config") .. '/scripts/autostart')
