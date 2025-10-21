return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require("lualine").setup({
      options = {
        theme = "monokai-pro",
        sections = {
          lualine_a = {
            file = 1,
          },
        },
      },
    })
  end,
}
