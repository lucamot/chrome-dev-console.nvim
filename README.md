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

Once a page is open you can enter commands like in the browser console:
```vim
:CdcCommand document.body.outerHTML
:CdcCommand $("body") // if the page has jQuery
```

Note: commands are wrapped into `console.log()`

## Demo
[Demo](assets/demo1.mp4)

## ☕ Support My Work  
If you find this plugin useful, consider supporting me:  

[![Buy Me a Coffee](https://img.shields.io/badge/Buy%20Me%20a%20Coffee-%23FFDD00?style=flat&logo=buy-me-a-coffee&logoColor=black)](https://buymeacoffee.com/lucamot)


## License
[MIT](LICENSE)

