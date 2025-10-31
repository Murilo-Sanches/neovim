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
	vim.g.clipboard = {
		name = "win32yank-wsl",
		copy = { ["+"] = "clip.exe", ["*"] = "clip.exe" },
		paste = {
			["+"] = "powershell.exe -Command Get-Clipboard",
			["*"] = "powershell.exe -Command Get-Clipboard",
		},
		cache_enabled = 0,
	}
end
