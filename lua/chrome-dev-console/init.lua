local M = {
    _name = "Cdc",
    diagnostic = {},
}

M.config = require("chrome-dev-console.config")

function M.setup(opts)
    M.config.setup(opts)
    vim.api.nvim_create_user_command(M._name .. "Open", function(opts)
        M.Open(opts.args)
    end, {nargs = 1})
end

local function start(url)
  local client = require('chrome-remote.chrome').new()
  local err = client:open_url(url)
  if err then
    print(vim.inspect(err))
  end

  local request

  local function start_editor(result)
    print(vim.inspect(M.config.options))
    local bufnr = vim.api.nvim_create_buf(true, true)
    local winnr = vim.api.nvim_open_win(bufnr, false, {
      win = 0,
      split = M.config.options.console_window.placement,
      height = M.config.options.console_window.height,
    })
    vim.api.nvim_win_set_buf(winnr, bufnr)
    M.win = winnr
    M.buffer = bufnr
    client.Log:enable()

    vim.api.nvim_create_autocmd({ 'BufDelete', 'WinClosed' }, {
      buffer = bufnr,
      callback = function()
        if M.config.options.auto_close_page then
            client.Page:close()
        end
        vim.api.nvim_buf_delete(bufnr, { force = true })
        client:close()
      end,
    })
  end

  client.Network:requestWillBeSent(function(params)
    if not request and params.type == 'Document' then
      request = params
    end
  end)

  client.Network:loadingFinished(function(params)
    if request and params.requestId == request.requestId then

      client.Network:getResponseBody(
        { requestId = request.requestId },
        vim.schedule_wrap(function(err, result)
          start_editor(result)
        end)
      )
    end
  end)

  client.Log:entryAdded(function(entry)
      vim.schedule(function()
          vim.api.nvim_win_set_buf(M.win, M.buffer)
          lc = vim.api.nvim_buf_line_count(M.buffer)-1
          vim.api.nvim_buf_set_lines(M.buffer, lc, lc, false, vim.split(entry["entry"]["text"], '\n'))
          if entry["entry"]["level"] == 'error' then
              local ns = vim.api.nvim_create_namespace('liveedit')
              table.insert(M.diagnostic, {
                  lnum = lc,
                  col = string.len(entry["entry"]["text"]),
                  message = entry["entry"]["text"],
                  severity = vim.diagnostic.severity.ERROR,
              })
              vim.diagnostic.set(ns, M.buffer, M.diagnostic)
          end
          vim.api.nvim_win_set_cursor(M.win, {lc+1, 0})
      end)
  end)

  client.Network:enable()
  client.Page:reload()
end

function M.Open(url)
    require('chrome-remote.endpoints').new(url, opts or {}, function(err, response)
      if err then
        callback(err)
      else
        coroutine.wrap(start)(response.content.webSocketDebuggerUrl)
      end
    end)
end

return M
