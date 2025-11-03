return {
	"goolord/alpha-nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")
		local ws = require("workspaces")
		local telescope = require("telescope")
		local init_path = vim.fn.stdpath("config")

		-- https://patorjk.com/software/taag/#p=display&f=Georgia11&t=NEOVIM&x=none&v=0&h=4&w=80&we=false
		local logo = [[                                                                       
                                                                       
`7MN.   `7MF'`7MM"""YMM    .g8""8q.`7MMF'   `7MF'`7MMF'`7MMM.     ,MMF'
  MMN.    M    MM    `7  .dP'    `YM.`MA     ,V    MM    MMMb    dPMM  
  M YMb   M    MM   d    dM'      `MM VM:   ,V     MM    M YM   ,M MM  
  M  `MN. M    MMmmMM    MM        MM  MM.  M'     MM    M  Mb  M' MM  
  M   `MM.M    MM   Y  , MM.      ,MP  `MM A'      MM    M  YM.P'  MM  
  M     YMM    MM     ,M `Mb.    ,dP'   :MM;       MM    M  `YM'   MM  
.JML.    YM  .JMMmmmmMMM   `"bmmd"'      VF      .JMML..JML. `'  .JMML.
                                                                       
                                                                       ]]

		local header_hl = {
			-- Empty lines
			-- { { "Red", 1, 1 } },
			-- { { "Red", 1, 1 } },

			{ { "AlphaHeader0_0", 46, 48 } },
			{
				{ "AlphaHeader1_0", 7, 22 },
				{ "AlphaHeader1_1", 33, 40 },
				{ "AlphaHeader1_2", 40, 50 },
			},
			{
				{ "AlphaHeader2_0", 6, 21 },
				{ "AlphaHeader2_1", 33, 45 },
			},
			{
				{ "AlphaHeader3_0", 6, 19 },
				{ "AlphaHeader3_1", 19, 20 },
				{ "AlphaHeader3_2", 20, 35 },
				{ "AlphaHeader3_3", 35, 45 },
				{ "AlphaHeader3_4", 45, 90 },
			},
			{
				{ "AlphaHeader4_0", 5, 18 },
				{ "AlphaHeader4_1", 18, 36 },
				{ "AlphaHeader4_2", 36, 45 },
				{ "AlphaHeader4_3", 45, 90 },
			},
			{
				{ "AlphaHeader5_0", 4, 17 },
				{ "AlphaHeader5_1", 17, 24 },
				{ "AlphaHeader5_2", 24, 28 },
				{ "AlphaHeader5_3", 28, 37 },
				{ "AlphaHeader5_4", 37, 46 },
				{ "AlphaHeader5_5", 46, 90 },
			},
			{
				{ "AlphaHeader6_0", 2, 17 },
				{ "AlphaHeader6_1", 17, 38 },
				{ "AlphaHeader6_2", 38, 45 },
				{ "AlphaHeader6_3", 46, 90 },
			},
			{
				{ "AlphaHeader7_0", 1, 17 },
				{ "AlphaHeader7_1", 17, 38 },
				{ "AlphaHeader7_2", 38, 45 },
				{ "AlphaHeader7_3", 46, 90 },
			},
			{
				{ "AlphaHeader8_0", 1, 37 },
				{ "AlphaHeader8_1", 37, 91 },
			},
		}

		vim.api.nvim_set_hl(0, "AlphaHeader0_0", { fg = "#a6c9ab" })
		vim.api.nvim_set_hl(0, "AlphaHeader1_0", { fg = "#4270a1" })
		vim.api.nvim_set_hl(0, "AlphaHeader1_1", { fg = "#386c3f" })
		vim.api.nvim_set_hl(0, "AlphaHeader1_2", { fg = "#a6c9ab" })
		vim.api.nvim_set_hl(0, "AlphaHeader2_0", { fg = "#4777a6" })
		vim.api.nvim_set_hl(0, "AlphaHeader2_1", { fg = "#3d7344" })
		vim.api.nvim_set_hl(0, "AlphaHeader3_0", { fg = "#4c7da9" })
		vim.api.nvim_set_hl(0, "AlphaHeader3_1", { fg = "#5173ae" })
		vim.api.nvim_set_hl(0, "AlphaHeader3_2", { fg = "#5679b3" })
		vim.api.nvim_set_hl(0, "AlphaHeader3_3", { fg = "#407b48" })
		vim.api.nvim_set_hl(0, "AlphaHeader3_4", { fg = "#98c09c" })
		vim.api.nvim_set_hl(0, "AlphaHeader4_0", { fg = "#5b82b8" })
		vim.api.nvim_set_hl(0, "AlphaHeader4_1", { fg = "#6088bd" })
		vim.api.nvim_set_hl(0, "AlphaHeader4_2", { fg = "#44844b" })
		vim.api.nvim_set_hl(0, "AlphaHeader4_3", { fg = "#a0c4a3" })
		vim.api.nvim_set_hl(0, "AlphaHeader5_0", { fg = "#658ec2" })
		vim.api.nvim_set_hl(0, "AlphaHeader5_1", { fg = "#6a94c7" })
		vim.api.nvim_set_hl(0, "AlphaHeader5_2", { fg = "#6f9acb" })
		vim.api.nvim_set_hl(0, "AlphaHeader5_3", { fg = "#749fd0" })
		vim.api.nvim_set_hl(0, "AlphaHeader5_4", { fg = "#488c51" })
		vim.api.nvim_set_hl(0, "AlphaHeader5_5", { fg = "#a6c9ab" })
		vim.api.nvim_set_hl(0, "AlphaHeader6_0", { fg = "#79aad5" })
		vim.api.nvim_set_hl(0, "AlphaHeader6_1", { fg = "#7eb0da" })
		vim.api.nvim_set_hl(0, "AlphaHeader6_2", { fg = "#4d9356" })
		vim.api.nvim_set_hl(0, "AlphaHeader6_3", { fg = "#aecdb3" })
		vim.api.nvim_set_hl(0, "AlphaHeader7_0", { fg = "#83b5df" })
		vim.api.nvim_set_hl(0, "AlphaHeader7_1", { fg = "#88bbf3" })
		vim.api.nvim_set_hl(0, "AlphaHeader7_2", { fg = "#509b59" })
		vim.api.nvim_set_hl(0, "AlphaHeader7_3", { fg = "#b7d1b9" })
		vim.api.nvim_set_hl(0, "AlphaHeader8_0", { fg = "#92c6f9" })
		vim.api.nvim_set_hl(0, "AlphaHeader8_1", { fg = "#2e4e2a" })

		local utils = require("alpha.utils")

		local header_val = vim.split(logo, "\n")
		header_hl = utils.charhl_to_bytehl(header_hl, header_val, false)

		dashboard.section.header.opts.hl = header_hl
		dashboard.section.header.val = header_val

		dashboard.section.buttons.val = {
			dashboard.button("ff", "󰍉  Find Files", ":Telescope find_files<CR>"),
			dashboard.button("fr", "  Recent Files", ":Telescope oldfiles<CR>"),
			dashboard.button("fg", "󰱽  Live Grep", ":Telescope live_grep<CR>"),
			dashboard.button("tw", "  Pin Workspace", function()
				local cwd = vim.fn.getcwd()
				local name = vim.fn.fnamemodify(cwd, ":t")
				local already_favorited = false

				for _, workspace in ipairs(ws.get()) do
					if cwd:gsub("/$", "") == workspace.path:gsub("/$", "") then
						already_favorited = true
						ws.remove(workspace.name)
						vim.notify("Removed workspace: " .. workspace.name, vim.log.levels.INFO)
					end
				end

				if not already_favorited then
					ws.add(cwd, name)
					vim.notify("Added workspace: " .. name, vim.log.levels.INFO)
				end
			end),

			dashboard.button("vw", "  Workspaces", function()
				telescope.extensions.workspaces.workspaces()
			end),
			dashboard.button("L", "󱐥  Lazy", "<cmd>Lazy<CR>"),
			dashboard.button("M", "ƒ  Mason", "<cmd>Mason<CR>"),
			dashboard.button("s", "  Settings", ":cd " .. init_path .. "<CR>:e init.lua<CR>"),
			dashboard.button("q", "󰿅  Quit", "<cmd>q<CR>"),
		}

		vim.api.nvim_create_autocmd("User", {
			pattern = "LazyVimStarted",
			desc = "Add Alpha dashboard footer",
			once = true,
			callback = function()
				local stats = require("lazy").stats()
				local ms = math.floor(stats.startuptime * 100 + 0.5) / 100

				dashboard.section.footer.val = {
					" " .. stats.count .. " plugins  loaded in " .. ms .. " ms 󱎫",
				}

				for i = 1, 14 do
					table.insert(dashboard.section.footer.val, " ")
				end

				pcall(vim.cmd.AlphaRedraw)
			end,
		})

		alpha.setup(dashboard.opts)
	end,
}
