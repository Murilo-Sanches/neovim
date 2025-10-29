return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local function lsp_name()
			local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
			if #buf_clients == 0 then
				return " No LSP"
			end

			local names = {}
			for _, client in pairs(buf_clients) do
				table.insert(names, client.name)
			end
			return " " .. table.concat(names, ", ")
		end

		require("lualine").setup({
			options = {
				theme = "monokai-pro",
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename" },
				lualine_x = { lsp_name, "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		})
	end,
}
