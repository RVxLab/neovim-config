local M = {}

function M.get_capabilities()
    return require("blink-cmp").get_lsp_capabilities({}, true)
end

return M
