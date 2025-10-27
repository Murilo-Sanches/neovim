return {
  "vim-test/vim-test",
  dependencies = {
    "preservim/vimux",
  },
  config = function()
    local wk = require("which-key")

    wk.add({
      { "<leader>t", group = "Tests" },
      { "<leader>tt", ":TestNearest<CR>", desc = "Test Nearest" },
      { "<leader>tT", ":TestFile<CR>", desc = "Test File" },
      { "<leader>ts", ":TestSuite<CR>", desc = "Test Suite" },
      { "<leader>tl", ":TestLast<CR>", desc = "Test Last" },
      { "<leader>tv", ":TestVisit<CR>", desc = "Test Visit" },
    })

    vim.cmd("let test#strategy = 'vimux'")
  end,
}
