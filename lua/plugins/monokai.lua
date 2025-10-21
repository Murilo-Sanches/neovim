return {
  {
    "loctvl842/monokai-pro.nvim",
    lazy = false,
    name = "monokai",
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme monokai-pro]])
    end,
  },
}
