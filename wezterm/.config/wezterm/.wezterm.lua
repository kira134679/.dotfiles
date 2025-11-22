-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 80
config.initial_rows = 24

-- or, changing the font size and color scheme.
config.window_background_opacity = 0.9
config.font_size = 10
config.use_fancy_tab_bar = false
config.color_scheme = "Tokyo Night"
config.font = wezterm.font_with_fallback({
  {
    family = "JetBrains Mono",
    weight = "Medium",
    harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
  },
})

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }

-- merge all keys config
local keys = require("keymaps")

config.keys = config.keys or {}

for _, key in ipairs(keys) do
  table.insert(config.keys, key)
end

-- merge all key tables config
local key_tables = require("key_tables")

config.key_tables = config.key_tables or {}

for name, key_bindings in pairs(key_tables) do
  config.key_tables[name] = key_bindings
end

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  config.default_prog = { "D:\\Application\\Git\\bin\\bash.exe", "--login", "-i" }
  config.wsl_domains = {
    {
      name = "wsl",
      distribution = "Ubuntu",
      username = "seika",
      default_cwd = "~",
      default_prog = { "zsh" },
    },
  }
end

-- Finally, return the configuration to wezterm:
return config
