---@diagnostic disable: undefined-global

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- Mason setup
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ruby_lsp",    -- ruby LSP from Shopify
          -- "solargraph", -- still pretty popular, an alternative to ruby_lsp
          "lua_ls", -- lua LSP
          "html", -- html LSP
          "cssls", -- css LSP
          "emmet_ls", -- emmet LSP
          "jsonls", -- json LSP
        },
        automatic_installation = true,
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- on_attach function to map keys after LSP attaches to buffer
      local on_attach = function(_, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        local keymap = vim.keymap.set

        keymap("n", "gd", vim.lsp.buf.definition, opts) -- go to definition
        keymap("n", "gr", vim.lsp.buf.references, opts) -- go to references
        keymap("n", "gi", vim.lsp.buf.implementation, opts) -- go to implementation
        keymap("n", "K", vim.lsp.buf.hover, opts) -- hover
        keymap("n", "<leader>rn", vim.lsp.buf.rename, opts) -- rename
        keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts) -- code action
        keymap("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, opts) -- previous diagnostic
        keymap("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, opts) -- next diagnostic
        keymap("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, opts) -- format
      end

      -- Ruby LSP
      vim.lsp.config.ruby_lsp = {
        cmd = { "ruby-lsp" },
        filetypes = { "ruby" },
        root_markers = { "Gemfile", ".git" },
        capabilities = capabilities,
        on_attach = on_attach,
      }

      -- Lua LSP
      vim.lsp.config.lua_ls = {
        cmd = { "lua-language-server" },
        filetypes = { "lua" },
        root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", "stylua.toml", ".git" },
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } }, -- recognize the `vim` global
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false, -- disable annoying warnings for third-party libraries
            },
            telemetry = { enable = false },
          },
        },
      }

      -- HTML LSP
      vim.lsp.config.html = {
        cmd = { "vscode-html-language-server", "--stdio" },
        filetypes = { "html", "erb" },
        root_markers = { "package.json", ".git" },
        capabilities = capabilities,
        on_attach = on_attach,
      }

      -- CSS LSP
      vim.lsp.config.cssls = {
        cmd = { "vscode-css-language-server", "--stdio" },
        filetypes = { "css", "scss", "less" },
        root_markers = { "package.json", ".git" },
        capabilities = capabilities,
        on_attach = on_attach,
      }

      -- Emmet LSP
      vim.lsp.config.emmet_ls = {
        cmd = { "emmet-ls", "--stdio" },
        filetypes = { "html", "css", "scss", "erb" },
        root_markers = { "package.json", ".git" },
        capabilities = capabilities,
        on_attach = on_attach,
      }

      -- JSON LSP
      vim.lsp.config.jsonls = {
        cmd = { "vscode-json-language-server", "--stdio" },
        filetypes = { "json", "jsonc" },
        root_markers = { "package.json", ".git" },
        capabilities = capabilities,
        on_attach = on_attach,
      }

      -- diagnostics config with modern sign configuration
      vim.diagnostic.config({
        virtual_text = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "✗",
            [vim.diagnostic.severity.WARN] = "⚠",
            [vim.diagnostic.severity.HINT] = "💡",
            [vim.diagnostic.severity.INFO] = "ℹ",
          },
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })
    end,
  },
}
