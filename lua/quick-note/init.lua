local M = {} -- Naming convention for module
local floating_window = require("quick-note.floating-window")

local defaults = {
	file_path = "~/.config/nvim/scratch.txt",
	keymaps = {
		open_floating_window = "<leader>no",
		close_buffer = "q",
		close_floating_window = "<leader>nc",
	},
}

function M.setup(opts)
	opts = opts or {}
	local file_path = opts.file_path or defaults.file_path

	-- Set keymaps with fallback to defaults
	M.keymaps = {
		open_floating_window = opts.keymaps and opts.keymaps.open_floating_window
			or defaults.keymaps.open_floating_window,
		close_buffer = opts.keymaps and opts.keymaps.close_buffer or defaults.keymaps.close_buffer,
		close_floating_window = opts.keymaps and opts.keymaps.open_floating_window
			or defaults.keymaps.close_floating_window,
	}

	-- Global keymap to open the quick note window
	vim.keymap.set("n", M.keymaps.open_floating_window, function()
		floating_window.open_floating_window(file_path, M.keymaps)
	end, { noremap = true, silent = true })

	-- Global keymap to close the quick note window
	vim.keymap.set("n", M.keymaps.close_floating_window, function()
		floating_window.close_floating_window()
	end, { noremap = true, silent = true })
end

return M
