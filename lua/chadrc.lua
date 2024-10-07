-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
  -- theme = "onedark",

  hl_override = {
    CursorLine = {
      bg = "black2",
    },
    Comment = {
      italic = true,
    },
  },
  hl_add = {
    NvimTreeOpenedFolderName = { fg = "green", bold = true },
  },
}

M.base46 = {
  theme = "yoru",
  theme_toggle = { "yoru", "one_light" },
}

return M
