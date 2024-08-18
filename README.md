# quick-note.nvim

**quick-note.nvim** is a simple Neovim plugin that will allow you to quickly create and manage notes in a floating window similar to the notes app on macOS.

The reason for creating this plugin was to provide a way to store and access quick notes and frequently referenced information without needing to navigate to an Obsidian vault or open an external app.

## Development Status

Note: This plugin is still under active development. While it is functional, it currently supports only a single note at a time. Currently, you can open and close the floating window and save text to the note. Future updates may include additional features, improvements, and support for managing multiple notes.

## Features

- **Floating Window for Notes**: Quickly open a floating window to jot down notes without leaving your current editing session.
- **Customizable Keymaps**: Define your own key mappings for opening and closing the note window.
- **Persistent Notes**: Save notes to a file that can be reloaded across sessions.

## Limitations

- Single Note Support: Currently, quick-note.nvim supports only one note at a time. The note is saved to a single file, and reopening the floating window will load the contents of that file. Multiple notes or note management features are not yet supported.

## Installation

You can install `quick-note.nvim` using your favorite Neovim plugin manager.

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
    'jdkingsbury/quick-note.nvim',
    opts = {},
}
```

## Usage

Once installed, you can use the following key mappings to interact with the plugin:

- **Open Floating Window**: Press `<leader>no` (default) to open the floating note window.
- **Close Floating Window**: Press `q` (default) while in the floating window to close it. Alternatively you can use `<leader>nc` to close the floating window itself.

### Keymap Details

- open_floating_window: Key mapping to open the floating note window (default: <leader>no).
- close_buffer: Key mapping to close the buffer while the floating window is active (default: q).
- close_floating_window: Key mapping to close the floating window itself (default: <leader>nc).

### Customizing Keymaps

You can customize the key mappings in the `setup` function:

```lua
require('quick-note').setup({
    keymaps = {
        open_floating_window = "<leader>nn",  -- Open with <leader>nn
        close_buffer = "x",  -- Close with 'x'
        close_floating_window = "<leader>nc",  -- Close floating window with <leader>nc
    },
})
```

### Customizing File Path

You can specify the file path where your notes will be saved:

```lua
require('quick-note').setup({
    file_path = "~/path/to/your/notes.txt",
})
```

## Options

Here are the options available in the `setup` function:

- **`file_path`**: Path to the file where notes will be saved (default: `~/.config/nvim/scratch.txt`).
- **`keymaps`**: Table containing key mappings:
  - **`open_floating_window`**: Key mapping to open the floating note window (default: `<leader>no`).
  - **`close_buffer`**: Key mapping to close the floating note window (default: `q`).
  - **`close_floating_window`**: Key mapping to close the floating note window (default `<leader>nc`)

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
