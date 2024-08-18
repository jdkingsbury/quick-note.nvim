local M = {} -- Naming convention for module

M.buf_id = nil
M.win_id = nil

local function create_floating_window(file_path, keymaps)
	-- Checks whether the buffer is valid before creating a new one
	if not M.buf_id or not vim.api.nvim_buf_is_valid(M.buf_id) then
		M.buf_id = vim.api.nvim_create_buf(false, true)

		-- Set buffer options when the buffer is created
		vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = M.buf_id })
		vim.api.nvim_set_option_value("filetype", "scratch", { buf = M.buf_id })

		-- Load the file content into the buffer
		vim.api.nvim_buf_call(M.buf_id, function()
			vim.cmd("silent! edit " .. file_path)
		end)
	end

	-- Keymaps for the buffer
	vim.api.nvim_buf_set_keymap(M.buf_id, "n", keymaps.close_buffer, ":close<CR>", { noremap = true, silent = true })

	-- Calculate window size and position
	local width = math.floor(vim.o.columns * 0.6)
	local height = math.floor(vim.o.lines * 0.6)
	local col = math.floor((vim.o.columns - width) / 2)
	local row = math.floor((vim.o.lines - height) / 2)

	-- Create floating window
	local win_id = vim.api.nvim_open_win(M.buf_id, true, {
		relative = "editor",
		row = row,
		col = col,
		width = width,
		height = height,
		style = "minimal",
		border = "rounded",
		title = "quick-note",
		title_pos = "left",
	})

	return win_id
end

function M.close_floating_window()
	if M.win_id and vim.api.nvim_win_is_valid(M.win_id) then
		vim.api.nvim_win_close(M.win_id, true)
		M.win_id = nil
	end
end

function M.open_floating_window(file_path, keymaps)
	if not M.win_id or not vim.api.nvim_win_is_valid(M.win_id) then
		M.win_id = create_floating_window(file_path, keymaps)
	end
end

return M
