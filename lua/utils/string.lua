local fn = require("utils.function")

local M = {}

---Check if a string starts with a given substring
---@param haystack string
---@param needle string
function M.string_starts_with(haystack, needle)
    return haystack:sub(1, #needle) == needle
end

---Pad a string on both sides
---
---@param str string
---@param padding_length integer
function M.pad_string(str, padding_length)
    local padding = string.rep(" ", padding_length)
    return padding .. str .. padding
end

---Split a string
---
---@param str string
---@param delimiter string
---@return table<integer, string>
function M.string_split(str, delimiter)
    local parts = {}
    local pattern = string.format("[^%s]+", delimiter)

    for s in string.gmatch(str, pattern) do
        table.insert(parts, s)
    end

    return parts
end

---Join a string
---
---@param strings table<integer, string>
---@param glue string
---@return string
function M.string_join(strings, glue)
    local str = strings[1]
    local remaining = { fn.unpack(strings, 2, #strings) }

    for _, s in ipairs(remaining) do
        str = str .. glue .. s
    end

    return str
end

return M
