local M = {}

---Create a keymapping
---@param modes string|table
---@param mapping string
---@param action function|string
---@param description string|nil
---@param opts table|nil
function M.keymap(modes, mapping, action, description, opts)
    opts = vim.tbl_extend("keep", opts or {}, {
        desc = description,
        silent = true,
    })

    vim.keymap.set(modes, mapping, action, opts)
end

---Shortcut for a normal mode keymapping
---@param mapping string
---@param action function|string
---@param description string|nil
---@param opts table|nil
function M.n_keymap(mapping, action, description, opts)
    M.keymap("n", mapping, action, description, opts)
end

---Shortcut for an execute mode keymapping
---@param mapping string
---@param action function|string
---@param description string|nil
---@param opts table|nil
function M.x_keymap(mapping, action, description, opts)
    M.keymap("x", mapping, action, description, opts)
end

---Shortcut for a visual mode keymapping
---@param mapping string
---@param action function|string
---@param description string|nil
---@param opts table|nil
function M.v_keymap(mapping, action, description, opts)
    M.keymap("v", mapping, action, description, opts)
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
