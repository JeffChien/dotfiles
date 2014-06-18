
-- Standard awesome library
local awful = require("awful")
require("awful.autofocus")
-- Notification library
local naughty = require("naughty")
-- search path
package.path = awful.util.getdir('config') .. '/widgets/?.lua;' .. package.path
package.path = awful.util.getdir('config') .. '/widgets/?/?.lua;' .. package.path
--- {{{ loadrc
-- Simple function to load additional LUA files from rc/.
function loadrc(name, mod)
   local success
   local result

   -- Which file? In rc/ or in lib/?
   local path = awful.util.getdir("config") .. "/" ..
      (mod and "lib" or "rc") ..
      "/" .. name .. ".lua"

   -- If the module is already loaded, don't load it again
   if mod and package.loaded[mod] then return package.loaded[mod] end

   -- Execute the RC/module file
   success, result = pcall(function() return dofile(path) end)
   if not success then
      naughty.notify({ title = "Error while loading an RC file",
                       text = "When loading `" .. name ..
                           "`, got the following error:\n" .. result,
                        preset = naughty.config.presets.critical
                    })
      return print("E: error loading RC file '" .. name .. "': " .. result)
   end

   -- Is it a module?
   if mod then
      return package.loaded[mod]
   end

   return result
end
--- }}}
loadrc('errors')

-- Create cache directory
os.execute("test -d " .. awful.util.getdir("cache") ..
           " || mkdir -p " .. awful.util.getdir("cache"))


-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- global configs
config = {}
config.terminal = 'terminator'
config.editor = 'vim'
config.editor_cmd = config.terminal .. "-e " .. config.editor
config.browser = 'firefox'

-- Table of layouts to cover with awful.layout.inc, order matters.
config.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.fair,
    awful.layout.suit.floating,
}

--- remaining modules
loadrc('xrun')
loadrc('appearance')
loadrc('start')
loadrc('wallpaper')
loadrc('tag')
loadrc('menu')
loadrc('widgets')
loadrc('bindings')
loadrc('rules')
loadrc('signal')

-- Set keys
root.keys(config.keys.global)
root.buttons(config.mouse.global)
