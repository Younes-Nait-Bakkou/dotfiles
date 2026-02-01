-- lua/custom/highlights.lua
-- Defines custom highlight groups to be merged by NvChad.

local M = {}

M.ui = {
  -- Add new highlight groups using hl_add.
  hl_add = {
    RECORDFLAG = { fg = "red", bold = true },
  },
}

return M
