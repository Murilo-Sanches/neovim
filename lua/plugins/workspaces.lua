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
		local actions = require("telescope.actions")
		local action_state = require("telescope.actions.state")
		local pickers = require("telescope.pickers")
		local finders = require("telescope.finders")
		local conf = require("telescope.config").values

		ws.setup({
			hooks = {
				open_pre = { "silent %bdelete!" },
				open = {
					function()
						alpha.start(true)
					end,
				},
			},
		})

		telescope.load_extension("workspaces")

		telescope.extensions.workspaces.workspaces = function()
			pickers
				.new({}, {
					prompt_title = "Workspaces",
					finder = finders.new_table({
						results = ws.get(),
						entry_maker = function(entry)
							return {
								value = entry,
								display = entry.name .. " - " .. entry.path,
								ordinal = entry.name .. " " .. entry.path,
							}
						end,
					}),
					sorter = conf.generic_sorter({}),
					attach_mappings = function(prompt_bufnr, map)
						actions.select_default:replace(function()
							local selection = action_state.get_selected_entry()

							actions.close(prompt_bufnr)
							ws.open(selection.value.name)
						end)

						local function remove_workspace()
							local selection = action_state.get_selected_entry()

							if not selection then
								vim.notify("Nothing selected", vim.log.levels.WARN)
								return
							end

							ws.remove(selection.value.name)
							vim.notify("Removed workspace: " .. selection.value.name, vim.log.levels.WARN)

							local picker = action_state.get_current_picker(prompt_bufnr)
							picker:refresh(
								finders.new_table({
									results = ws.get(),
									entry_maker = function(entry)
										return {
											value = entry,
											display = entry.name .. " - " .. entry.path,
											ordinal = entry.name .. " " .. entry.path,
										}
									end,
								}),
								{ reset_prompt = true }
							)
						end

						map("n", "dd", remove_workspace)

						return true
					end,
				})
				:find()
		end

		telescope.extensions.workspaces.add_from_finder = function()
			pickers
				.new({}, {
					prompt_title = "Add Workspaces",
					finder = finders.new_oneshot_job({
						"find",
						os.getenv("HOME"),
						"-type",
						"d",
						"-maxdepth",
						"3",
					}),
					sorter = conf.generic_sorter({}),
					attach_mappings = function(_, map)
						actions.select_default:replace(function()
							vim.notify("Use 'a' to add or 'dd' to remove a workspace.", vim.log.levels.INFO)
						end)

						local function add_workspace()
							local selection = action_state.get_selected_entry()

							if not selection then
								vim.notify("Nothing selected", vim.log.levels.WARN)
								return
							end

							local path = selection.value
							local name = vim.fn.fnamemodify(path, ":t")

							ws.add(path, name)
							vim.notify("Added workspace: " .. name, vim.log.levels.INFO)
						end

						local function remove_workspace()
							local selection = action_state.get_selected_entry()

							if not selection then
								vim.notify("Nothing selected", vim.log.levels.WARN)
								return
							end

							local name = vim.fn.fnamemodify(selection.value, ":t")
							ws.remove(name)
							vim.notify("Removed workspace: " .. name, vim.log.levels.WARN)
						end

						map("n", "a", add_workspace)
						map("n", "dd", remove_workspace)

						return true
					end,
				})
				:find()
		end

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
