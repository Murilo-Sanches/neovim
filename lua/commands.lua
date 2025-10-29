vim.api.nvim_create_user_command("FormatFiles", function(opts)
	local conform = require("conform")

	local target_dir = opts.fargs[1] or vim.fn.expand("%:p:h")
	target_dir = vim.fn.fnamemodify(target_dir, ":p")

	local args = opts.fargs
	local include_pattern = "*.lua"
	local exclude_pattern = ""

	for _, arg in ipairs(args) do
		if arg:match("^include=") then
			include_pattern = arg:match("^include=(.+)$")
		elseif arg:match("^exclude=") then
			exclude_pattern = arg:match("^exclude=(.+)$")
		end
	end

	local find_cmd = string.format("find %q -type f -name %q", target_dir, include_pattern)
	if exclude_pattern ~= "" then
		find_cmd = find_cmd .. string.format(" ! -wholename %q", exclude_pattern)
	end

	local handle = io.popen(find_cmd)
	if not handle then
		vim.notify("Failed to execute find command", vim.log.levels.ERROR)

		return
	end

	local files = {}
	for file in handle:lines() do
		table.insert(files, file)
	end
	handle:close()

	if #files == 0 then
		vim.notify("No files found in: " .. target_dir, vim.log.levels.WARN)
		return
	end

	local buf_original = vim.api.nvim_get_current_buf()
	local formatted_count = 0

	for _, file in ipairs(files) do
		vim.cmd("edit " .. vim.fn.fnameescape(file))
		local ok, err = pcall(function()
			conform.format({ async = false, lsp_format = "fallback" })
		end)
		if not ok then
			vim.notify("Error formatting " .. file .. ": " .. tostring(err), vim.log.levels.ERROR)
		elseif vim.bo.modified then
			vim.cmd("write")
			formatted_count = formatted_count + 1
		end
	end

	if vim.api.nvim_buf_is_valid(buf_original) then
		vim.api.nvim_set_current_buf(buf_original)
	end

	vim.notify(string.format("Formatted %d files in %s", formatted_count, target_dir), vim.log.levels.INFO)
end, {
	desc = "Format directory files with optional include/exclude patterns",
	nargs = "*",
	complete = "dir",
})
