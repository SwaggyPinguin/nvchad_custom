local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

	-- Override plugin definition options

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- format & linting
			{
				"jose-elias-alvarez/null-ls.nvim",
				config = function()
					require "custom.configs.null-ls"
				end,
			},
		},
		config = function()
			require "plugins.configs.lspconfig"
			require "custom.configs.lspconfig"
		end, -- Override to setup mason-lspconfig
	},

	-- override plugin configs
	{
		"williamboman/mason.nvim",
		opts = overrides.mason,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		opts = overrides.treesitter,
	},

	{
		"nvim-tree/nvim-tree.lua",
		opts = overrides.nvimtree,
	},

	-- Install a plugin
	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		config = function()
			require("better_escape").setup()
		end,
	},

	-- GitHub Copilot
	{
		"zbirenbaum/copilot.lua",
		event = "InsertEnter",
		opts = overrides.copilot,
		config = function()
			require "custom.configs.copilot"
		end,
	},

	-- Yuck.vim - For EWW syntax highlighting
	{
		"elkowar/yuck.vim",
		ft = { "eww", "yuck" },
	},

	-- Transparent background
	-- {
	-- 	"xiyaowong/nvim-transparent",
	-- 	config = function()
	-- 		require "custom.configs.transparent"
	-- 	end,
	-- 	lazy = false,
	-- },

	-- Gruvbox theme
	-- {
	-- 	"ellisonleao/gruvbox.nvim",
	-- 	priority = 1000,
	-- 	lazy = false,
	-- 	config = function()
	-- 		require "custom.configs.gruvbox"
	-- 	end,
	-- },

	-- nui.nvim
	-- { "MunifTanjim/nui.nvim", lazy = true },

	-- {
	-- 	"rcarriga/nvim-notify",
	-- 	config = require("notify").setup {
	-- 		background_colour = "#000000",
	-- 	},
	-- 	keys = {
	-- 		{
	-- 			"<leader>un",
	-- 			function()
	-- 				require("notify").dismiss { silent = true, pending = true }
	-- 			end,
	-- 			desc = "Dismiss all Notifications",
	-- 		},
	-- 	},
	-- 	opts = {
	-- 		timeout = 3000,
	-- 		max_height = function()
	-- 			return math.floor(vim.o.lines * 0.75)
	-- 		end,
	-- 		max_width = function()
	-- 			return math.floor(vim.o.columns * 0.75)
	-- 		end,
	-- 		on_open = function(win)
	-- 			vim.api.nvim_win_set_config(win, { zindex = 100 })
	-- 		end,
	-- 	},
	-- 	lazy = true,
	-- },

	-- noice.nvim - new ui
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		config = function()
			require "custom.configs.noice"
		end,
		opts = {
			-- stylua: ignore
			keys = {
				{ "<S-Enter>",   function() require("noice").redirect(vim.fn.getcmdline()) end,                 mode = "c",                 desc = "Redirect Cmdline" },
				{ "<leader>snl", function() require("noice").cmd("last") end,                                   desc = "Noice Last Message" },
				{ "<leader>snh", function() require("noice").cmd("history") end,                                desc = "Noice History" },
				{ "<leader>sna", function() require("noice").cmd("all") end,                                    desc = "Noice All" },
				{ "<leader>snd", function() require("noice").cmd("dismiss") end,                                desc = "Dismiss All" },
				{ "<c-f>",       function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,  silent = true,              expr = true,              desc = "Scroll forward",  mode = { "i", "n", "s" } },
				{ "<c-b>",       function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true,              expr = true,              desc = "Scroll backward", mode = { "i", "n", "s" } },
			},
		},
		dependencies = {
			{
				"MunifTanjim/nui.nvim",
				lazy = true,
			},
			{
				"rcarriga/nvim-notify",
				config = function()
					require("notify").setup {
						background_colour = "#000000",
					}
				end,
				keys = {
					{
						"<leader>un",
						function()
							require("notify").dismiss { silent = true, pending = true }
						end,
						desc = "Dismiss all Notifications",
					},
				},
				opts = {
					timeout = 3000,
					max_height = function()
						return math.floor(vim.o.lines * 0.75)
					end,
					max_width = function()
						return math.floor(vim.o.columns * 0.75)
					end,
					on_open = function(win)
						vim.api.nvim_win_set_config(win, { zindex = 100 })
					end,
				},
				lazy = true,
			},
		},
	},

	-- Tmux navigation
	-- {
	-- 	"christoomey/vim-tmux-navigator",
	-- 	lazy = false,
	-- 	cmd = {
	-- 		"TmuxNavigateLeft",
	-- 		"TmuxNavigateDown",
	-- 		"TmuxNavigateUp",
	-- 		"TmuxNavigateRight",
	-- 		"TmuxNavigatePrevious",
	-- 	},
	-- 	keys = {
	-- 		{ "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
	-- 		{ "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
	-- 		{ "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
	-- 		{ "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
	-- 		{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
	-- 	},
	-- },

	-- Dap configs
	{
		"mfussenegger/nvim-dap",

		dependencies = {

			-- fancy UI for the debugger
			{
				"rcarriga/nvim-dap-ui",
				-- stylua: ignore
				keys = {
					{ "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
					{ "<leader>de", function() require("dapui").eval() end,     desc = "Eval",  mode = { "n", "v" } },
				},
				opts = {},
				config = function(_, opts)
					-- setup dap config by VsCode launch.json file
					-- require("dap.ext.vscode").load_launchjs()
					local dap = require "dap"
					local dapui = require "dapui"
					dapui.setup(opts)
					dap.listeners.after.event_initialized["dapui_config"] = function()
						dapui.open {}
					end
					dap.listeners.before.event_terminated["dapui_config"] = function()
						dapui.close {}
					end
					dap.listeners.before.event_exited["dapui_config"] = function()
						dapui.close {}
					end
				end,
			},

			-- virtual text for the debugger
			{
				"theHamsta/nvim-dap-virtual-text",
				opts = {},
			},

			-- which key integration
			{
				"folke/which-key.nvim",
				optional = true,
				opts = {
					defaults = {
						["<leader>d"] = { name = "+debug" },
					},
				},
			},

			-- mason.nvim integration
			{
				"jay-babu/mason-nvim-dap.nvim",
				dependencies = "mason.nvim",
				cmd = { "DapInstall", "DapUninstall" },
				opts = {
					-- Makes a best effort to setup the various debuggers with
					-- reasonable debug configurations
					automatic_installation = true,

					-- You can provide additional configuration to the handlers,
					-- see mason-nvim-dap README for more information
					handlers = {},

					-- You'll need to check that you have the required things installed
					-- online, please don't ask me how to install them :)
					ensure_installed = {
						-- Update this to ensure that you have the debuggers for the langs you want
					},
				},
			},
		},

		-- stylua: ignore
		keys = {
			{ "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
			{ "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
			{ "<leader>dc", function() require("dap").continue() end,                                             desc = "Continue" },
			{ "<leader>da", function() require("dap").continue({ before = get_args }) end,                        desc = "Run with Args" },
			{ "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
			{ "<leader>dg", function() require("dap").goto_() end,                                                desc = "Go to line (no execute)" },
			{ "<leader>di", function() require("dap").step_into() end,                                            desc = "Step Into" },
			{ "<leader>dj", function() require("dap").down() end,                                                 desc = "Down" },
			{ "<leader>dk", function() require("dap").up() end,                                                   desc = "Up" },
			{ "<leader>dl", function() require("dap").run_last() end,                                             desc = "Run Last" },
			{ "<leader>do", function() require("dap").step_out() end,                                             desc = "Step Out" },
			{ "<leader>dO", function() require("dap").step_over() end,                                            desc = "Step Over" },
			{ "<leader>dp", function() require("dap").pause() end,                                                desc = "Pause" },
			{ "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "Toggle REPL" },
			{ "<leader>ds", function() require("dap").session() end,                                              desc = "Session" },
			{ "<leader>dt", function() require("dap").terminate() end,                                            desc = "Terminate" },
			{ "<leader>dw", function() require("dap.ui.widgets").hover() end,                                     desc = "Widgets" },
		},

		config = function()
			local dap = require "dap"
			dap.adapters.php = {
				type = "executable",
				command = "node",
				args = { "/home/noah/.config/vscode-php-debug/out/phpDebug.js" },
			}
			dap.configurations.php = {
				{
					type = "php",
					request = "launch",
					name = "Listen for Xdebug",
					port = 9003,
					pathMappings = {
						["/var/www/bmc"] = "${workspaceFolder}",
					},
				},
			}
			-- require("configs.dap.php")

			-- local Config = require("lazyvim.config")
			-- vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
			--
			-- for name, sign in pairs(Config.icons.dap) do
			--   sign = type(sign) == "table" and sign or { sign }
			--   vim.fn.sign_define(
			--     "Dap" .. name,
			--     { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
			--   )
			-- end
		end,
	},

	{
		"stevearc/conform.nvim",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local conform = require "conform"

			conform.setup {
				formatters_by_ft = {
					php = { "php" },
				},
				format_on_save = {
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				},
				notify_on_error = true,
				formatters = {
					php = {
						command = "php-cs-fixer",
						args = {
							"fix",
							"$FILENAME",
							"--config=/home/ndahms/.vscode/.proofit.php-cs.php",
							"--allow-risky=yes", -- if you have risky stuff in config, if not you dont need it.
						},
						stdin = false,
					},
				},
			}
		end,
	},

	-- To make a plugin not be loaded
	-- {
	--   "NvChad/nvim-colorizer.lua",
	--   enabled = false
	-- },

	-- All NvChad plugins are lazy-loaded by default
	-- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
	-- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
	-- {
	--   "mg979/vim-visual-multi",
	--   lazy = false,
	-- }
}

return plugins
