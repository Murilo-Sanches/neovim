return {
  {
    "mason-org/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup({
        registries = {
          "github:mason-org/mason-registry",
          "github:Crashdummyy/mason-registry", -- Roslyn
        },
      })
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },
    lazy = false,
    config = function()
      local lspconfig = vim.lsp.config
      local blink = require("blink.cmp")

      local servers = {
        lua_ls = {},
        ts_ls = {}
      }

      for server, config in pairs(servers) do
        config.capabilities = blink.get_lsp_capabilities(config.capabilities)

        lspconfig[server] = config
      end

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

      vim.diagnostic.config({
        virtual_text = {
          prefix = "●",
          spacing = 2,
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
          },
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      vim.o.updatetime = 250
      vim.api.nvim_create_autocmd("CursorHold", {
        callback = function()
          vim.diagnostic.open_float(nil, {
            focus = false,
            scope = "cursor",
            border = "rounded",
            source = "always",
            close_events = { "CursorMoved", "BufHidden", "InsertEnter" },
          })
        end,
      })
    end,
  },
  {
    "seblyng/roslyn.nvim",
    opts = {},
  },
}
