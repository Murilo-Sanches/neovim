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

		vim.api.nvim_create_autocmd("VimLeavePre", {
			callback = function()
				local file = os.getenv("NVIM_LAST_DIR")

				if file then
					local cwd = vim.fn.getcwd()
					local f = io.open(file, "w")

					if f then
						f:write(cwd)
						f:close()
					end
				end
			end,
		})
	end,
}
