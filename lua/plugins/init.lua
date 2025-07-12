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
	{ "echasnovski/mini.nvim", version = false },
	{ "chrisgrieser/nvim-genghis" },
	{ "echasnovski/mini.map", version = false },
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
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
	{ "nvchad/volt", lazy = true },
	{ "nvchad/menu", lazy = true },
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				dependencies = "rafamadriz/friendly-snippets",
				opts = { history = true, updateevents = "TextChanged,TextChangedI" },
				config = function(_, opts)
					require("luasnip").config.set_config(opts)
					require("nvchad.configs.luasnip")
				end,
			},

			{
				"windwp/nvim-autopairs",
				opts = {
					fast_wrap = {},
					disable_filetype = { "TelescopePrompt", "vim" },
				},
				config = function(_, opts)
					require("nvim-autopairs").setup(opts)

					local cmp_autopairs = require("nvim-autopairs.completion.cmp")
					require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
				end,
			},

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
	},
	{
		"IogaMaster/neocord",
		event = "VeryLazy",
	},

	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {},
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
			{
				"<leader>-",
				"<cmd>Yazi<cr>",
				desc = "Open yazi at the current file",
			},
			{
				"<leader>cw",
				"<cmd>Yazi cwd<cr>",
				desc = "Open the file manager in nvim's working directory",
			},
			{
				"<c-up>",
				"<cmd>Yazi toggle<cr>",
				desc = "Resume the last yazi session",
			},
		},
		---@type YaziConfig
		opts = {
			open_for_directories = false,
			keymaps = {
				show_help = "<f1>",
			},
		},
	},

	{
		"MeanderingProgrammer/render-markdown.nvim",
		lazy = false, -- force immediate loading
		ft = { "markdown" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
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
