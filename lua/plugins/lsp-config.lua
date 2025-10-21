return {
  {
    "mason.org/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup({
        registries = {
          "github:mason-org/mason-registry",
        },
      })
    end,
  },
  {
    "mason.org/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local lspconfig = vim.lsp.config

      lspconfig.lua_ls.setup = {}

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      vim.diagnostic.config({
        virtual_text = {
          prefix = "●",
          spacing = 2,
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      vim.o.updatetime = 250
      vim.cmd([[
        autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focus = false })
      ]])
    end,
  },
}
