return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	lazy = false,
	config = function()
		local wk = require("which-key")

		wk.add({
			{ "<leader>e", group = "Tree", icon = { icon = "", color = "green" } },
			{ "<leader>ef", ":Neotree focus<CR>", desc = "Focus" },
			{ "<leader>ee", ":Neotree toggle left<CR>", desc = "Toggle" },
		})
	end,
}
