local M = {} -- Naming convention for module
-- local create_window = require("quick-note.create-window")
local create_window = require("quick-note.create-window")

local defaults = {
	file_path = "~/.config/nvim/scratch.txt", -- @type string
	keymaps = { -- @type table<string, string>
		open_floating_window = "<leader>no", -- @type string
		open_vertical_split_window = "<leader>nvs", -- @type string
		open_horizontal_split_window = "<leader>nhs", -- @type string
		close_buffer = "q", -- @type string
		close_window = "<leader>nc", -- @type string
	},
}

-- Setup function to initialize the keymaps and file_path
-- @param1 opts table|nil: The table containing the user's custom configurations or nil
-- @return void
function M.setup(opts)
	opts = opts or {}
	local file_path = opts.file_path or defaults.file_path

	-- Set keymaps with fallback to defaults
	local keymaps = vim.tbl_deep_extend("force", defaults.keymaps, opts.keymaps or {})

	M.keymaps = keymaps

	-- Global keymap to open the quick note floating window
	vim.keymap.set("n", M.keymaps.open_floating_window, function()
		create_window.open_floating_window(file_path, M.keymaps)
	end, { noremap = true, silent = true })

	-- Global keymap to open the quick note verical window
	vim.keymap.set("n", M.keymaps.open_vertical_split_window, function()
		create_window.open_split_window(file_path, M.keymaps, "vertical")
	end, { noremap = true, silent = true })

	-- Global keymap to open the quick note horizontal window
	vim.keymap.set("n", M.keymaps.open_horizontal_split_window, function()
		create_window.open_split_window(file_path, M.keymaps, "horizontal")
	end, { noremap = true, silent = true })

	-- Global keymap to close the quick note window
	vim.keymap.set("n", M.keymaps.close_window, function()
		create_window.close_window()
	end, { noremap = true, silent = true })
end

return M
