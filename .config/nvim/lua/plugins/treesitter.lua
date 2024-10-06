return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    local treesitter = require("nvim-treesitter.configs")
    treesitter.setup({
      highlight = {
        enable = true,
      },
      indent = { enable = true },
      autotag = {
        enable = true,
      },
      ensure_installed = {
        "cpp",
        "c",
        "rust",
        "python",
        "latex",
        "bash",
        "lua",
        "json",
        "css",
        "dockerfile",
        "javascript",
        "typescript",
        "tsx",
        "yaml",
        "html",
        "prisma",
        "markdown",
        "markdown_inline",
        "svelte",
        "graphql",
        "vim",
        "gitignore",
        "query",
        "vimdoc",
      },
      incremental_selection = {
        enable = true,
        -- keymaps = {
        --   init_selection = "<C-space>",
        --   node_incremental = "<C-space>",
        --   scope_incremental = false,
        --   node_decremental = "<bs>",
        -- },
        keymaps = Phonon.treesitterSelection
      },
    })
  end,
}