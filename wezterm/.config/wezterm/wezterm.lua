local wezterm = require('wezterm')
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = "Catppuccin Frappe"
config.font = wezterm.font('SauceCodePro Nerd Font Mono')
config.font_size = 15

return config
