local M = {}

---Shortcut for a normal mode keymapping
---@param mapping string
---@param action function|string
---@param description string|nil
---@param opts table|nil
function M.n_keymap(mapping, action, description, opts)
    opts = vim.tbl_extend("keep", opts or {}, {
        desc = description,
        silent = true,
    })

    vim.keymap.set("n", mapping, action, opts)
end

---Create a lazy keybinding for lazy.nvim
---
---@param mapping string
---@param action function|string
---@param description string|nil
---@param opts table|nil
function M.lazy_key(mapping, action, description, opts)
    local lazy_mapping = {
        mapping,
        action,
    }

    return vim.tbl_extend("keep", lazy_mapping, opts or {}, {
        desc = description,
        silent = true,
    })
end

return M
