return {
  "neovim/nvim-lspconfig",
  enabled = true,
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local capabilities = cmp_nvim_lsp.default_capabilities()

    mason.setup()

    mason_lspconfig.setup({
      ensure_installed = {
        "lua_ls", "pyright", "clangd", "rust_analyzer",
        "svelte", "graphql", "emmet_ls", "matlab_ls", "csharp_ls",
        "zls"
      },
      automatic_installation = true,
    })

    local servers = {
      zls = {
        filetypes = { "zig" },
        root_dir = lspconfig.util.root_pattern("build.zig", ".git"),
      },
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            completion = { callSnippet = "Replace" },
          },
        },
      },
      clangd = {
        cmd = {
          "clangd",
          "--compile-commands-dir=.",
          "--background-index",
        },
        root_dir = lspconfig.util.root_pattern(
          "compile_commands.json",
          "compile_flags.txt",
          ".clang"
        ),
      },
      pyright = {
        settings = {
          python = {
            analysis = { autoImportCompletions = true },
          },
        },
      },
      svelte = {
        on_attach = function(client, bufnr)
          vim.api.nvim_create_autocmd("BufWritePost", {
            pattern = { "*.js", "*.ts" },
            callback = function(ctx)
              client.notify("$/onDidChangeTsOrJsFile", {
                uri = ctx.match,
              })
            end,
          })
        end,
      },
      graphql = {
        filetypes = {
          "graphql", "gql", "svelte",
          "typescriptreact", "javascriptreact",
        },
      },
      emmet_ls = {
        filetypes = {
          "html", "typescriptreact", "javascriptreact",
          "css", "sass", "scss", "less", "svelte",
        },
      },
      matlab_ls = {
        cmd = { "python3", "-m", "matlab_language_server" },
        filetypes = { "matlab" },
        root_dir = lspconfig.util.root_pattern(
          ".git", "*.prj", "startup.m"
        ),
      },
      csharp_ls = {},
    }

    for server, config in pairs(servers) do
      config.capabilities = capabilities
      lspconfig[server].setup(config)
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }
        local map = vim.keymap.set

        map("n", "gR", "<cmd>Telescope lsp_references<CR>", {
          desc = "Show LSP references", buffer = opts.buffer,
        })

        map("n", "gD", vim.lsp.buf.declaration, {
          desc = "Go to declaration", buffer = opts.buffer,
        })

        map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", {
          desc = "Show definitions", buffer = opts.buffer,
        })

        map("n", "gi", "<cmd>Telescope lsp_implementations<CR>", {
          desc = "Show implementations", buffer = opts.buffer,
        })

        map("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", {
          desc = "Show type definitions", buffer = opts.buffer,
        })

        map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {
          desc = "Code actions", buffer = opts.buffer,
        })

        map("n", "<leader>rn", vim.lsp.buf.rename, {
          desc = "Rename", buffer = opts.buffer,
        })

        map("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", {
          desc = "Buffer diagnostics", buffer = opts.buffer,
        })

        map("n", "<leader>d", vim.diagnostic.open_float, {
          desc = "Line diagnostics", buffer = opts.buffer,
        })

        map("n", "[d", function()
          vim.diagnostic.jump({ count = -1 })
        end, {
          desc = "Previous diagnostic", buffer = opts.buffer,
        })

        map("n", "]d", function()
          vim.diagnostic.jump({ count = 1 })
        end, {
          desc = "Next diagnostic", buffer = opts.buffer,
        })

        map("n", "K", vim.lsp.buf.hover, {
          desc = "Hover doc", buffer = opts.buffer,
        })

        map("n", "<leader>rs", ":LspRestart<CR>", {
          desc = "Restart LSP", buffer = opts.buffer,
        })
      end,
    })

    local signs = {
      Error = " ", Warn = " ", Hint = "󰛩 ", Info = " ",
    }

    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, {
        text = icon, texthl = hl, numhl = "",
      })
    end
  end,
}

