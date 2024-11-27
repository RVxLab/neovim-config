local M = {}

---Check if the current system is macOS
---@return boolean
function M.is_macos()
    return vim.fn.has("macunix") == 1
end

---Run a function when on Mac OS or on another system
---
---The return value of the chosen function will be returned from this function
---
---@param fn_on_macos function
---@param fn_otherwise function|nil
function M.when_macos(fn_on_macos, fn_otherwise)
    if M.is_macos() then
        return fn_on_macos()
    end

    if fn_otherwise ~= nil then
        return fn_otherwise()
    end

    return nil
end

return M
