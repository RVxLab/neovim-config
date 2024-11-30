local add, now = MiniDeps.add, MiniDeps.now

now(function ()
    add("folke/which-key.nvim")

    local wk = require("which-key")

    wk.setup()
    wk.add({
        mode = "n",
        { "[", group = "Previous" },
        { "]", group = "Next" },
        { "<leader>g", group = "[G]it" },
    })
end)
