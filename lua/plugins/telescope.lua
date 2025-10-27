return {
  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope = require("telescope")

      telescope.setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })

      local builtin = require("telescope.builtin")

      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Telescope find files" })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Telescope live grep" })
      vim.keymap.set('n', '<leader>fc', builtin.current_buffer_fuzzy_find, { desc = "Telescope live grep in current buffer" })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Telescope buffers" })
      
      vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = "Telescope git branches" })
      vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = "Telescope git status" })
      vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = "Telescope git commits" })
      
      vim.keymap.set('n', '<leader>ld', builtin.diagnostics, { desc = "Telescope lsp diagnostics" })
      vim.keymap.set('n', '<leader>lq', builtin.quickfix, { desc = "Telescope lsp quickfix" })

      telescope.load_extension("ui-select")
    end,
  },
}
