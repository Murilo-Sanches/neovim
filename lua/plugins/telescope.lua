return {
	{
		"nvim-telescope/telescope-ui-select.nvim",
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local telescope = require("telescope")
			local wk = require("which-key")

			telescope.setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})

			local builtin = require("telescope.builtin")

			wk.add({
				{ "<leader>f", group = "Telescope" },
				{ "<leader>ff", builtin.find_files, desc = "Find Files" },
				{ "<leader>fg", builtin.live_grep, desc = "Live Grep" },
				{ "<leader>fc", builtin.current_buffer_fuzzy_find, desc = "Buffer Live Grep" },
				{ "<leader>fb", builtin.buffers, desc = "Buffers" },

				{ "<leader>g", group = "Git" },
				{ "<leader>gb", builtin.git_branches, desc = "Branches" },
				{ "<leader>gs", builtin.git_status, desc = "Status" },
				{ "<leader>gc", builtin.git_commits, desc = "Commits" },

				{ "<leader>l", group = "LSP", icon = { icon = "ƒ", color = "grey" } },
				{
					"<leader>ld",
					function()
						builtin.diagnostics({ bufnr = 0 })
					end,
					desc = "Diagnostics (Buffer)",
				},
				{ "<leader>lD", builtin.diagnostics, desc = "Diagnostics (Global)" },
				{ "<leader>lq", builtin.quickfix, desc = "Quickfix" },
			})

			telescope.load_extension("ui-select")
		end,
	},
}
