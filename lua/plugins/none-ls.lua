return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,

        null_ls.builtins.formatting.prettier,
      },
    })

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})

    local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })

    vim.api.nvim_create_autocmd("InsertLeave", {
      group = augroup,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end,
}
