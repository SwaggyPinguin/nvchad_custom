---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<C-m>"] = { ":Mason <CR>", "open Mason"},
    ["<leader>l"] = { ":Lazy <CR>", "open Lazy"}
  },
  v = {
    [">"] = { ">gv", "indent"},
  },
}

-- more keybinds!

return M
