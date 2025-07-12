return {

	{
		"stevearc/conform.nvim",
		event = "BufWritePre", -- enable format on save
		opts = {
			format_on_save = function(bufnr)
				-- Enable for specific filetypes only
				local ft = vim.bo[bufnr].filetype
				return ft == "lua" or ft == "nix"
			end,

			formatters_by_ft = {
				lua = { "stylua" },
				nix = { "alejandra" },
				javascript = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				markdown = { "prettier" },
			},
			formatters = {
				alejandra = {
					command = "alejandra",
					args = { "-q" },
					stdin = true,
				},
				stylua = {
					command = "stylua",
					args = { "-" },
					stdin = true,
				},
			},
		},
	},

	{ import = "nvchad.blink.lazyspec" },
	{ "chrisgrieser/nvim-genghis" },
	{ "elentok/format-on-save.nvim" },
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = function(_, opts)
			-- Other blankline configuration here
			return require("indent-rainbowline").make_opts(opts)
		end,
		dependencies = {
			"TheGLander/indent-rainbowline.nvim",
		},
	},
	-- nvim v0.8.0
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- setting the keybinding for LazyGit with 'keys' is recommended in
		-- order to load the plugin when the command is run for the first time
		keys = {
			{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
	{ "nvchad/volt", lazy = true },
	{ "nvchad/menu", lazy = true },
	-- load luasnips + cmp related in insert mode only
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{
				-- snippet plugin
				"L3MON4D3/LuaSnip",
				dependencies = "rafamadriz/friendly-snippets",
				opts = { history = true, updateevents = "TextChanged,TextChangedI" },
				config = function(_, opts)
					require("luasnip").config.set_config(opts)
					require("nvchad.configs.luasnip")
				end,
			},

			-- autopairing of (){}[] etc
			{
				"windwp/nvim-autopairs",
				opts = {
					fast_wrap = {},
					disable_filetype = { "TelescopePrompt", "vim" },
				},
				config = function(_, opts)
					require("nvim-autopairs").setup(opts)

					-- setup cmp for autopairs
					local cmp_autopairs = require("nvim-autopairs.completion.cmp")
					require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
				end,
			},

			-- cmp sources plugins
			{
				"saadparwaiz1/cmp_luasnip",
				"hrsh7th/cmp-nvim-lua",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
			},
		},
		opts = function()
			return require("nvchad.configs.cmp")
		end,
	},

	{
		"jake-stewart/multicursor.nvim",
		branch = "1.0",
		config = function()
			require("configs.multicursor")
		end,
	},
	{
		"vyfor/cord.nvim",
		build = ":Cord update",
		event = "VeryLazy",
		-- opts = {}
	},
	{
		"IogaMaster/neocord",
		event = "VeryLazy",
	},

	-- lazy.nvim
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},

	{
		"neovim/nvim-lspconfig",
		name = "lspconfig.nixd",
		ft = { "nix" },
		opts = {
			settings = {
				nixd = {
					formatting = {
						command = { "alejandra" },
					},
				},
			},
		},
		config = function(_, opts)
			require("lspconfig").nixd.setup(opts)
		end,
	},
	---@type LazySpec
	{
		"mikavilpas/yazi.nvim",
		event = "VeryLazy",
		keys = {
			-- 👇 in this section, choose your own keymappings!
			{
				"<leader>-",
				"<cmd>Yazi<cr>",
				desc = "Open yazi at the current file",
			},
			{
				-- Open in the current working directory
				"<leader>cw",
				"<cmd>Yazi cwd<cr>",
				desc = "Open the file manager in nvim's working directory",
			},
			{
				-- NOTE: this requires a version of yazi that includes
				-- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
				"<c-up>",
				"<cmd>Yazi toggle<cr>",
				desc = "Resume the last yazi session",
			},
		},
		---@type YaziConfig
		opts = {
			-- if you want to open yazi instead of netrw, see below for more info
			open_for_directories = false,
			keymaps = {
				show_help = "<f1>",
			},
		},
	},

	{
		"MeanderingProgrammer/render-markdown.nvim",
		lazy = false, -- force immediate loading
		-- Still restrict commands if needed by filetype:
		ft = { "markdown" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			-- You can use either mini.nvim or nvim-web-devicons:
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("render-markdown").setup({
				file_types = { "markdown" }, -- ensure this matches your buffers
				log_level = "debug", -- for more detailed logs
			})
		end,
	},

	{
		"mattn/emmet-vim",
		lazy = false, -- Ensures Emmet loads on start
	},
}
