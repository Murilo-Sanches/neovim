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

		local function make_entry_maker()
			return function(entry)
				return {
					value = entry,
					display = entry.name .. " - " .. entry.path,
					ordinal = entry.name .. " " .. entry.path,
				}
			end
		end

		local function refresh_picker(prompt_bufnr)
			local picker = action_state.get_current_picker(prompt_bufnr)
			picker:refresh(
				finders.new_table({
					results = ws.get(),
					entry_maker = make_entry_maker(),
				}),
				{ reset_prompt = true }
			)
		end

		local function remove_workspace(prompt_bufnr, selection)
			if not selection then
				vim.notify("Nothing selected", vim.log.levels.WARN)

				return
			end

			local name = selection.value.name or vim.fn.fnamemodify(selection.value, ":t")
			ws.remove(name)
			vim.notify("Removed workspace: " .. name, vim.log.levels.WARN)
			if prompt_bufnr then
				refresh_picker(prompt_bufnr)
			end
		end

		local function add_workspace(selection)
			if not selection then
				vim.notify("Nothing selected", vim.log.levels.WARN)

				return
			end

			local path = selection.value
			local name = vim.fn.fnamemodify(path, ":t")
			ws.add(path, name)
			vim.notify("Added workspace: " .. name, vim.log.levels.INFO)
		end

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
						entry_maker = make_entry_maker(),
					}),
					sorter = conf.generic_sorter({}),
					attach_mappings = function(prompt_bufnr, map)
						actions.select_default:replace(function()
							local selection = action_state.get_selected_entry()

							actions.close(prompt_bufnr)
							ws.open(selection.value.name)
						end)

						map("n", "dd", function()
							remove_workspace(prompt_bufnr, action_state.get_selected_entry())
						end)

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

						map("n", "a", function()
							add_workspace(action_state.get_selected_entry())
						end)

						map("n", "dd", function()
							remove_workspace(nil, action_state.get_selected_entry())
						end)

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
