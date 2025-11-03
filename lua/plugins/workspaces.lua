return {
	"natecraddock/workspaces.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"goolord/alpha-nvim",
	},
	config = function()
		local ws = require("workspaces")
		local alpha = require("alpha")
		local telescope = require("telescope")

		ws.setup({
			hooks = {
				open_pre = {
					"silent %bdelete!",
				},
				open = {
					function()
						alpha.start(true)
					end,
				},
			},
		})

		telescope.load_extension("workspaces")
	end,
}
