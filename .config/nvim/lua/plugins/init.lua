return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },


  {
  	"williamboman/mason.nvim",
  	opts = {
  		ensure_installed = {
  			"lua-language-server", "stylua",
  			"html-lsp", "css-lsp" , "prettier",
        "pyright", "clangd", "rust-analyzer"
  		},
  	},
  },


  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc",
        "html", "css", "python", "markdown",
        "c", "zig", "cpp", "rust"
      },
    },
  },

  {"vimwiki/vimwiki",
    lazy=false,
    init = function()
      vim.g.vimwiki_list = {
        {
          path = '~/Development/vimwiki/',
          syntax = 'default',
          ext = '.wiki',
        },
      }
    end,
  },


  { 'alexghergh/nvim-tmux-navigation',
    lazy = false,
    config = function()

    local nvim_tmux_nav = require('nvim-tmux-navigation')

    nvim_tmux_nav.setup {
      disable_when_zoomed = true -- defaults to false
    }

  end
  },

  {
    "mg979/vim-visual-multi",
    branch = "master",
    event = "BufRead",
    -- config = function()
    --   require('mappings').setup_vim_visual_multi()
    -- end

    config = function()
      -- Start MultiCursor mode by finding the word under the cursor
      vim.api.nvim_set_keymap('n', '<A-d>', '<Plug>(VM-Find-Under)',
        { noremap = true, silent = true, desc = "MultiCursor - Start Find Under" })
    end
  },

  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  },

}
