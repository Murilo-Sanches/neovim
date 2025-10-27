local wk = require("which-key")

wk.add({
  { "<leader>w", group = "Window" },
  { "<leader>wh", ":wincmd h<CR>", desc = "Left" },
  { "<leader>wj", ":wincmd j<CR>", desc = "Bottom" },
  { "<leader>wk", ":wincmd k<CR>", desc = "Top" },
  { "<leader>wl", ":wincmd l<CR>", desc = "Right" },
})
