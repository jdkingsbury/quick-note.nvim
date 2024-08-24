local M = {} -- Naming convention for module

M.buf_id = nil -- @type nil | integer
M.win_id = nil -- @type nil | integer

-- Creates a floating window and sets the keymaps
-- @param1 file_path string: The path of the file to be loaded to the buffer
-- @param2 keymaps table: The table containing keymaps to be set for the buffer
-- @return integer: The window ID of the created floating window
local function create_floating_window(file_path, keymaps)
	-- Checks whether the buffer is valid before creating a new one
	if not M.buf_id or not vim.api.nvim_buf_is_valid(M.buf_id) then
		M.buf_id = vim.api.nvim_create_buf(false, true)

		-- Set buffer options when the buffer is created
		vim.bo[M.buf_id].bufhidden = "wipe"
		vim.bo[M.buf_id].filetype = "scratch"

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
		title_pos = "center",
	})

	return win_id
end

-- Creates a split window and set keymaps
-- @param1 file_path string: The path of the file to be loaded to the buffer
-- @param2 keymaps table: The table containing keymaps to be set for the buffer
-- @param3 orientation string: The orientation of the window ('horizontal', 'vertical')
-- @return integer: The window ID of the split window
local function create_split_window(file_path, keymaps, orientation)
	-- Create and configure the buffer
	if not M.buf_id or not vim.api.nvim_buf_is_valid(M.buf_id) then
		M.buf_id = vim.api.nvim_create_buf(false, true)

		vim.bo[M.buf_id].bufhidden = "wipe"
		vim.bo[M.buf_id].filetype = "scratch"

		vim.api.nvim_buf_call(M.buf_id, function()
			vim.cmd("silent! edit " .. file_path)
		end)
	end

	-- Keymaps for the buffer
	vim.api.nvim_buf_set_keymap(M.buf_id, "n", keymaps.close_buffer, ":close<CR>", { noremap = true, silent = true })

	-- Execute split commands
	if orientation == "horizontal" then
		vim.cmd("split")
	elseif orientation == "vertical" then
		vim.cmd("vsplit")
	end

	-- Get the new window ID and set the new buffer
	local new_win_id = vim.api.nvim_get_current_win()
	vim.api.nvim_win_set_buf(new_win_id, M.buf_id)
	return new_win_id
end

-- Opens a floating window with the specified file and keymaps
-- @param1 file_path string: The path of the file to be loaded into the buffer
-- @param2 keymaps table: The table containing keymaps to be set for the buffer
-- @return void
function M.open_floating_window(file_path, keymaps)
	if not M.win_id or not vim.api.nvim_win_is_valid(M.win_id) then
		M.win_id = create_floating_window(file_path, keymaps)
	end
end

-- Opens a split window with the specified file and keymaps
-- @param1 file_path string: The path of the file to be loaded into the buffer
-- @param2 keymaps table: The table containing keymaps to be set for the buffer
-- @param3 orientation string: The orientation of the window ('horizontal', 'vertical')
-- @return void
function M.open_split_window(file_path, keymaps, orientation)
	if not M.win_id or not vim.api.nvim_win_is_valid(M.win_id) then
		M.win_id = create_split_window(file_path, keymaps, orientation)
	end
end

-- Closes the floating window if it is valid
-- @return void
function M.close_window()
	if M.win_id and vim.api.nvim_win_is_valid(M.win_id) then
		vim.api.nvim_win_close(M.win_id, true)
		M.win_id = nil
	end
end

return M
