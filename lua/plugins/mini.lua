local utils = require("utils")
local now, later = MiniDeps.now, MiniDeps.later

local function make_footer_renderer()
    local startup_time_ms = -1
    local plugin_count = -1

    vim.defer_fn(function ()
        plugin_count = #MiniDeps.get_session()
        MiniStarter.refresh()
    end, 50)

    return function ()
        local memory_usage_mb = vim.uv.getrusage().maxrss / 1024

        return require("starter").make_footer({
            time = startup_time_ms,
            memory = memory_usage_mb,
            plugins = plugin_count,
        })
    end
end

now(function()
    require("mini.icons").setup()
    require("mini.statusline").setup()

    local starter = require("mini.starter")

    starter.setup({
        header = require("art.header"),
        items = {
            starter.sections.recent_files(10, true, true),
            { name = "Update dependencies", action = "DepsUpdate", section = "Dependencies" },
            { name = "Save dependency snapshot", action = "DepsSaveSnap", section = "Dependencies" },
            { name = "Load dependency snapshot", action = "DepsLoadSnap", section = "Dependencies" },
        },
        silent = true,
        footer = make_footer_renderer(),
    })
end)

later(function()
    require("mini.splitjoin").setup()
    require("mini.files").setup()

    utils.n_keymap("-", MiniFiles.open, "Browse files")
end)
