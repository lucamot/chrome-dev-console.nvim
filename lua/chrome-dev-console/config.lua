local M = {}

M.options = {
    console_window = {
        height = 10,
        placement = 'below',
    },
    auto_close_page = true,
}

function M.setup(opts)
    M.options = vim.tbl_extend("force", M.options, opts or {})
end

return M
