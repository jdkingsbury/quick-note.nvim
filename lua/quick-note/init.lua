local M = {} -- Naming convention for module
local floating_window = require("quick-note.floating-window")

local defaults = {
	file_path = "~/.config/nvim/scratch.txt",
	keymaps = {
		toggle_quick_note = "<leader>qn",
	},
}

local function save_on_exit(filepath)
	vim.api.nvim_buf_call(0, function()
		vim.cmd("silent! write " .. filepath)
	end)
end

function M.setup(opts)
	opts = opts or {}
	local file_path = opts.file_path or defaults.file_path
	local toggle_quick_note_keymap = defaults.keymaps.toggle_quick_note

	vim.keymap.set("n", toggle_quick_note_keymap, function()
		floating_window.toggle_floating_window(file_path)
	end, { noremap = true, silent = true })

	vim.api.nvim_create_autocmd("BufWipeout", {
		callback = function()
			save_on_exit(file_path)
		end,
	})
end

return M
