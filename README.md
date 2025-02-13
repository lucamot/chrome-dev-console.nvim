# Chrome Dev Console plugin

A Neovim plugin that opens a URL in a browser (supporting Chrome DevTools Protocol) and displays browser console messages in a separate Neovim buffer within a split window.

## Features
- Open a URL in a browser that supports the Chrome DevTools Protocol.
- Display console messages in a Neovim buffer.
- Configurable split window placement: `left`, `right`, `above`, `below`.
- Adjustable split window height.
- Option to close the web page when the console buffer is deleted or the split window is closed.

## Requirements
- **Neovim 0.5+**
- **[chrome-remote.nvim](https://github.com/lucamot/chrome-remote.nvim)** (use my forked version of `chrome-remote.nvim` until pull request #1 is merged into original repository)
- **A browser that supports Chrome DevTools Protocol**, launched with:
  ```sh
  chromium --remote-debugging-port=9222
  ```

## Installation
Using **vim-plug**:
```vim
Plug 'lucamot/chrome-dev-console.nvim'
Plug 'lucamot/chrome-remote.nvim'
```
Using **packer.nvim**:
```lua
use {
  'lucamot/chrome-dev-console.nvim',
  requires = { 'lucamot/chrome-remote.nvim' }
}
```

Using **Lazy.nvim**:
```vim
{
    'lucamot/chrome-dev-console.nvim',
    dependencies = { 'lucamot/chrome-remote.nvim' }
}
```

## Configuration
Customize the plugin in `init.lua`:
```lua
require('chrome-dev-console').setup({
  console_window = {
    height = 10, -- Height of the split window
    placement = 'below' -- 'left', 'right', 'above', 'below'
  },
  auto_close_page = true, -- Close webpage when console buffer is deleted
})
```

## Usage
Open a URL in the browser and capture console logs:
```vim
:CdcConsole http://example.com
```

## License
[MIT](LICENSE)

