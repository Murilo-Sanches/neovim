local available_mason_servers = { "lua_ls", "ts_ls" }

return {
	{
		"mason-org/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup({
				registries = {
					"github:mason-org/mason-registry",
					"github:Crashdummyy/mason-registry", -- Roslyn
				},
			})
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					-- LSP
					"lua_ls",
					"ts_ls",
					"roslyn",

					-- Linters
					"luacheck",
					"eslint_d",

					-- Formatters
					"stylua",
					"prettier",
				},
				auto_update = true,
				run_on_start = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "saghen/blink.cmp" },
		lazy = false,
		config = function()
			local lspconfig = vim.lsp.config
			local blink = require("blink.cmp")
			local wk = require("which-key")

			for _, server in ipairs(available_mason_servers) do
				local ok, config = pcall(require, "servers." .. server)
				if ok then
					config.capabilities = blink.get_lsp_capabilities(config.capabilities)

					lspconfig[server] = config
				else
					vim.notify("LSP config not found for: " .. server, vim.log.levels.WARN)
				end
			end

			vim.diagnostic.config({
				virtual_text = {
					prefix = "●",
					spacing = 2,
				},
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = " ",
						[vim.diagnostic.severity.WARN] = " ",
						[vim.diagnostic.severity.HINT] = " ",
						[vim.diagnostic.severity.INFO] = " ",
					},
				},
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					wk.add({
						{ "<leader>lk", vim.lsp.buf.hover, desc = "Hover" },
						{ "<leader>lgd", vim.lsp.buf.definition, desc = "Definition" },
						{ "<leader>lr", vim.lsp.buf.references, desc = "References" },
						{ "<leader>la", vim.lsp.buf.code_action, desc = "Action" },
					})

					local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})
					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})
				end,
			})

			vim.o.updatetime = 250
			vim.api.nvim_create_autocmd("CursorHold", {
				callback = function()
					vim.diagnostic.open_float(nil, {
						focus = false,
						scope = "cursor",
						border = "rounded",
						source = "always",
						close_events = { "CursorMoved", "BufHidden", "InsertEnter" },
					})
				end,
			})
		end,
	},
	{
		"seblyng/roslyn.nvim",
		opts = {},
	},
}
