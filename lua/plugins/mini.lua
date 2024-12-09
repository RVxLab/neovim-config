local utils = require("utils")
local now, later = MiniDeps.now, MiniDeps.later

now(function()
    require("mini.icons").setup()
    require("mini.statusline").setup()

    local starter = require("mini.starter")

    starter.setup({
        header = require("art.header"),
        items = {
            starter.sections.recent_files(10, true, true),
            { name = "Update dependencies", action = MiniDeps.update, section = "Dependencies" },
            { name = "Save dependency snapshot", action = MiniDeps.snap_save, section = "Dependencies" },
            { name = "Load dependency snapshot", action = MiniDeps.snap_load, section = "Dependencies" },
        },
        silent = true,
        footer = "",
    })
end)

later(function()
    require("mini.splitjoin").setup()
    require("mini.pick").setup()

    utils.n_keymap("<leader>ff", MiniPick.builtin.files, "Find [F]iles")
    utils.n_keymap("<leader>fs", MiniPick.builtin.grep_live, "[S]earch files")
    utils.n_keymap("<leader>fb", MiniPick.builtin.buffers, "Find [B]uffers")

    require("which-key").add({
        mode = "n",
        { "<leader>f", group = "[F]ind" },
    })
end)
