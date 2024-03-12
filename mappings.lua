---@type MappingsTable
local M = {}

M.general = {
	n = {
		[";"] = { ":", "enter command mode", opts = { nowait = true } },
		["<C-m>"] = { ":Mason <CR>", "open Mason" },
		["<leader>l"] = { ":Lazy <CR>", "open Lazy" },
		["<leader>tt"] = {
			function()
				require("base46").toggle_transparency()
			end,
			"Toggle transparency",
		},
		["<leader>fp"] = {
			":lua require('telescope.builtin').lsp_document_symbols({ symbols='method' }) <CR>",
			"Search methods",
		},
	},
	v = {
		[">"] = { ">gv", "indent" },
	},
}

-- more keybinds!

return M
