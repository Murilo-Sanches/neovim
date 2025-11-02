return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			javascript = { "prettier", stop_after_first = true },
			c = { "clang-format" },
			cpp = { "clang-format" },
			asm = { "asmfmt" },

			-- ["*"] = { "trim_whitespace" }, -- bugado (9fd3d5e)
			["_"] = { "trim_whitespace", lsp_format = "prefer" },
		},
		default_format_opts = {
			lsp_format = "fallback",
		},
		format_on_save = { timeout_ms = 500 },
		formatters = {
			shfmt = {
				append_args = { "-i", "2" },
			},
		},
		notify_on_error = true,
		notify_no_formatters = true,
	},
	init = function()
		local wk = require("which-key")
		local conform = require("conform")

		wk.add({
			{
				"<leader>lf",
				function()
					conform.format({ async = true })
				end,
				desc = "Format Buffer",
			},
		})
	end,
}
