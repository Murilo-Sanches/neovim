vim.o.expandtab = false
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2

vim.g.mapleader = " "
vim.g.background = "light"

vim.opt.swapfile = false

vim.wo.number = true

vim.opt.clipboard = "unnamedplus"
if vim.fn.has("wsl") == 1 then
	local yank_group = vim.api.nvim_create_augroup("Yank", { clear = true })
	vim.api.nvim_create_autocmd("TextYankPost", {
		group = yank_group,
		callback = function()
			vim.fn.system("clip.exe", vim.fn.getreg("\""))
		end,
	})

	vim.keymap.set("i", "<C-v>", function()
		local content = vim.fn.systemlist("powershell.exe Get-Clipboard")

		vim.api.nvim_put(content, "c", true, true)
	end, { noremap = true, silent = true })
end
