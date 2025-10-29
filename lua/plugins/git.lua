return {
	{
		"tpope/vim-fugitive",
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			local gitsigns = require("gitsigns")
			gitsigns.setup()

			local wk = require("which-key")

			wk.add({
				{ "<leader>gp", gitsigns.preview_hunk, desc = "Preview Hunk" },
				{ "<leader>gt", gitsigns.toggle_current_line_blame, desc = "Toggle Blame" },
			})
		end,
	},
}
