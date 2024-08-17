local M = {} -- Naming convention for module

local function create_floating_window(file_path)
	local buf = vim.api.nvim_create_buf(false, true)

	vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })
	vim.api.nvim_set_option_value("filetype", "scratch", { buf = buf })

	vim.api.nvim_buf_call(buf, function()
		vim.cmd("silent! edit " .. file_path)
	end)

	local width = math.floor(vim.o.columns * 0.6)
	local height = math.floor(vim.o.lines * 0.6)
	local col = math.floor((vim.o.columns - width) / 2)
	local row = math.floor((vim.o.lines - height) / 2)

	local win_id = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		row = row,
		col = col,
		width = width,
		height = height,
		style = "minimal",
		border = "rounded",
		title = "quick-note",
		title_pos = "center",
	})

	-- Example of creating keymap in window
	vim.api.nvim_buf_set_keymap(buf, "n", "q", ":close<CR>", { noremap = true, silent = true })
	-- vim.api.nvim_buf_set_keymap(buf, "n", "w", ":close<CR>", { noremap = true, silent = true })

	return win_id
end

function M.toggle_floating_window(file_path)
	-- Check if the floating window is open
	if M.win_id and vim.api.nvim_win_is_valid(M.win_id) then
		vim.api.nvim_win_close(M.win_id, true)
		M.win_id = nil
	else
		M.win_id = create_floating_window(file_path)
	end
end

return M
