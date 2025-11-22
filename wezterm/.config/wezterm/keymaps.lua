local wezterm = require("wezterm")
local act = wezterm.action

return {
  -- split pane in the the specified direction
  { key = "h", mods = "CTRL", action = act.SplitPane({ direction = "Left", size = { Percent = 50 } }) },
  { key = "j", mods = "CTRL", action = act.SplitPane({ direction = "Down", size = { Percent = 50 } }) },
  { key = "k", mods = "CTRL", action = act.SplitPane({ direction = "Up", size = { Percent = 50 } }) },
  { key = "l", mods = "CTRL", action = act.SplitPane({ direction = "Right", size = { Percent = 50 } }) },

  -- move to the pane in the specified direction
  { key = "h", mods = "ALT", action = act.ActivatePaneDirection("Left") },
  { key = "j", mods = "ALT", action = act.ActivatePaneDirection("Down") },
  { key = "k", mods = "ALT", action = act.ActivatePaneDirection("Up") },
  { key = "l", mods = "ALT", action = act.ActivatePaneDirection("Right") },

  { key = "w", mods = "ALT", action = act.CloseCurrentPane({ confirm = false }) },
  { key = "w", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
  { key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
  { key = "N", mods = "LEADER", action = act.ActivateTabRelative(-1) },
  { key = "g", mods = "LEADER", action = act.ShowTabNavigator },
  {
    key = ",",
    mods = "LEADER",
    action = act.PromptInputLine({
      description = "Enter new name for tab:",
      action = wezterm.action_callback(function(window, pane, line)
        if not (line and line:match("^%s*$")) then
          window:active_tab():set_title(line)
        end
      end),
    }),
  },

  -- key tables config
  { key = "r", mods = "LEADER", action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }) },
}
