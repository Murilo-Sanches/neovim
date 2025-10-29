return {
	"andweeb/presence.nvim",
	config = function()
		require("presence").setup({
			neovim_image_text = "Neovim",
			main_image = "file",
			debounce_timeout = 1,
		})
	end,
}
