local now = MiniDeps.now

now(function ()
    require('mini.icons').setup()
    require('mini.splitjoin').setup()
    require('mini.statusline').setup()
end)

now(function ()
    local starter = require('mini.starter')

    starter.setup({
        header = require('art.header'),
        silent = true,
        footer = require('starter').make_footer({
            time = 123,
            memory = 456,
            plugins = 789,
        })
    })
end)


