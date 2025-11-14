-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 70
config.initial_rows = 16

-- or, changing the font size and color scheme.
config.window_background_opacity = 0.9
config.font_size = 10
config.color_scheme = "Tokyo Night"
config.font = wezterm.font_with_fallback({
  {
    family = "JetBrains Mono",
    weight = "Medium",
    harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
  },
})

config.keys = {
  -- split pane in the the specified direction
  {
    key = "h",
    mods = "CTRL",
    action = act.SplitPane({
      direction = "Left",
      size = { Percent = 50 },
    }),
  },
  {
    key = "j",
    mods = "CTRL",
    action = act.SplitPane({
      direction = "Down",
      size = { Percent = 50 },
    }),
  },
  {
    key = "k",
    mods = "CTRL",
    action = act.SplitPane({
      direction = "Up",
      size = { Percent = 50 },
    }),
  },
  {
    key = "l",
    mods = "CTRL",
    action = act.SplitPane({
      direction = "Right",
      size = { Percent = 50 },
    }),
  },
  -- move to the pane in the specified direction
  {
    key = "h",
    mods = "ALT",
    action = act.ActivatePaneDirection("Left"),
  },
  {
    key = "j",
    mods = "ALT",
    action = act.ActivatePaneDirection("Down"),
  },
  {
    key = "k",
    mods = "ALT",
    action = act.ActivatePaneDirection("Up"),
  },
  {
    key = "l",
    mods = "ALT",
    action = act.ActivatePaneDirection("Right"),
  },
}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  config.default_domain = "WSL:Ubuntu"
end

-- Finally, return the configuration to wezterm:
return config
