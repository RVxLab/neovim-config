vim.api.nvim_create_user_command("RvxDumpPlugins", function(opts)
    local plugins = {}
    local format = opts.fargs[1] or "json"

    for _, plugin in ipairs(MiniDeps.get_session()) do
        if plugin.name ~= nil and plugin.source ~= nil then
            table.insert(plugins, {
                name = plugin.name,
                url = plugin.source,
            })
        end
    end

    table.sort(plugins, function(a, b)
        return a.name:lower() < b.name:lower()
    end)

    local output = ""

    if format == "md" then
        for _, plugin in ipairs(plugins) do
            output = output .. string.format("[%s](%s)\n", plugin.name, plugin.url)
        end
    else
        output = vim.fn.json_encode(plugins)
    end

    if vim.fn.setreg("", output) then
        vim.notify(string.format("Plugins have been copied to clipboard in %s format", format))
    end
end, {
    nargs = 1,
    complete = function()
        return {
            "json",
            "md",
        }
    end,
})
