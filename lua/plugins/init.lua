return {

  {
    "folke/snacks.nvim",
    event = "VimEnter",
    opts = {
      indent = { enabled = true },
      bigfile = { enabled = true },
      quickfile = { enabled = false },
      input = { enabled = true },
      notifier = { enabled = false },
      notify = { enabled = false },
      scope = { enabled = true },
      lazygit = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      scroll = {
        enabled = true,
      },
      zen = { enabled = true },
      terminal = {
        enabled = true,
        win = {
          style = "float",
          border = "rounded",
          width = math.floor(vim.o.columns * 0.8),
          height = math.floor(vim.o.lines * 0.8),
        },
      },

      dashboard = {
        enabled = true,
        preset = {
          keys = {
            {
              icon = " ",
              key = "f",
              desc = "Find File",
              action = ":lua Snacks.dashboard.pick('files')",
            },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            {
              icon = " ",
              key = "w",
              desc = "Find Text",
              action = ":lua Snacks.dashboard.pick('live_grep')",
            },
            {
              icon = " ",
              key = "r",
              desc = "Recent Files",
              action = ":lua Snacks.dashboard.pick('oldfiles')",
            },
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', { cwd = vim.fn.stdpath('config') })",
            },
            { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = true },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
          header = [[

          ▄▄▄▄▄███████████████████▄▄▄▄▄     
        ▄██████████▀▀▀▀▀▀▀▀▀▀██████▀████▄   
       █▀████████▄             ▀▀████ ▀██▄  
      █▄▄██████████████████▄▄▄         ▄██▀ 
       ▀█████████████████████████▄    ▄██▀  
         ▀████▀▀▀▀▀▀▀▀▀▀▀▀█████████▄▄██▀    
           ▀███▄              ▀██████▀      
             ▀██████▄        ▄████▀         
                ▀█████▄▄▄▄▄▄▄███▀           
                  ▀████▀▀▀████▀             
                    ▀███▄███▀               
                       ▀█▀                  
           ]],
        },
        sections = {
          { section = "header" },
          {
            pane = 2,
            section = "terminal",
            cmd = "colorscript -e square",
            height = 5,
            padding = 1,
          },
          { section = "keys", gap = 1, padding = 1 },
          {
            pane = 2,
            icon = " ",
            title = "Recent Files",
            section = "recent_files",
            indent = 2,
            padding = 1,
          },
          { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          {
            pane = 2,
            icon = " ",
            title = "Git Status",
            section = "terminal",
            enabled = function()
              return Snacks.git.get_root() ~= nil
            end,
            cmd = "git status --short --branch --renames",
            height = 5,
            padding = 1,
            ttl = 5 * 60,
            indent = 3,
          },
          { section = "startup" },
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    event = "VeryLazy",
    opts = {
      notify_on_error = true,
      lsp_fallback = true,
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
      formatters_by_ft = {
        ["html"] = { "prettier", "prettierd", stop_after_first = true },
        ["css"] = { "prettier", "prettierd", stop_after_first = true },
        ["c"] = { "clang-format" },
        ["cpp"] = { "clang-format" },
        ["go"] = { "gofmt" },
        ["java"] = { "google-java-format" },
        ["python"] = { "ruff" },
        ["lua"] = { "stylua" },
        ["yaml"] = { "prettier", "prettierd", stop_after_first = true },
        ["rust"] = { "rustfmt" },
        ["markdown"] = { "prettier", "prettierd", stop_after_first = true },
        ["markdown.mdx"] = { "prettier", "prettierd", stop_after_first = true },
        ["javascript"] = { "prettier", "prettierd", stop_after_first = true },
        ["javascriptreact"] = { "prettier", "prettierd", stop_after_first = true },
        ["typescript"] = { "prettier", "prettierd", stop_after_first = true },
        ["typescriptreact"] = { "prettier", "prettierd", stop_after_first = true },
        ["json"] = { "jq" },
        ["nix"] = { "nixfmt", "alejandra" },
        ["bash"] = { "beautysh" },
        ["elixir"] = { "mix" },
        ["eelixir"] = { "mix" },
        ["heex"] = { "mix" },
        ["surface"] = { "mix" },
        ["tf"] = { "terraform_fmt" },
        ["terraform"] = { "terraform_fmt" },
      },
    },
    init = function()
      vim.opt.formatexpr = "v:lua.require'conform'.formatexpr()"
      vim.keymap.set("n", "<leader>uf", "<cmd>FormatToggle<cr>", { silent = true, desc = "Toggle Format Globally" })
      vim.keymap.set("n", "<leader>uF", "<cmd>FormatToggle!<cr>", { silent = true, desc = "Toggle Format Locally" })
      vim.keymap.set("n", "<leader>cf", function()
        require("conform").format()
      end, { silent = true, desc = "Format Buffer" })
      vim.keymap.set("v", "<leader>cF", function()
        vim.lsp.buf.format()
      end, { silent = true, desc = "Format Lines" })
    end,
  },

  { import = "nvchad.blink.lazyspec" },
  { "echasnovski/mini.nvim", version = false },
  { "chrisgrieser/nvim-genghis" },
  { "echasnovski/mini.map", version = false },
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
          require "nvchad.configs.luasnip"
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

          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
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
      return require "nvchad.configs.cmp"
    end,
  },

  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    config = function()
      require "configs.multicursor"
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
      require("render-markdown").setup {
        file_types = { "markdown" }, -- ensure this matches your buffers
        log_level = "debug", -- for more detailed logs
      }
    end,
  },

  {
    "mattn/emmet-vim",
    lazy = false, -- Ensures Emmet loads on start
  },
}
