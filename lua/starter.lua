local footer = [[
Startup Time:   %dms
Memory usage:   %.2fMB
Plugins:        %s
]]

local M = {}

---Make a formatter footer to display some basic stats
---@param stats table The stats to pass to the footer
---@param stats.time number The time in milliseconds since startup
---@param stats.memory number The memory usage in megabytes
---@param stats.plugins number The amount of plugins loaded
function M.make_footer(stats)
    return string.format(footer, stats.time or -1, stats.memory or -1, stats.plugins or -1)
end

return M
