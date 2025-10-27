return {
  "folke/which-key.nvim",
  dependencies = { 
    'nvim-mini/mini.nvim',
    "nvim-tree/nvim-web-devicons",
 },
  event = "VeryLazy",
  opts = {
    preset = "helix",
    delay = function() return 0 end,
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Local Keymaps",
    },
  },
}
