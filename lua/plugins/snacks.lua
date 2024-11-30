local utils = require("utils")
local add, now = MiniDeps.add, MiniDeps.now

now(function ()
    add("folke/snacks.nvim")

    require("snacks").setup({
        notifier = { enabled = true },
    })

    utils.n_keymap("<leader>q", Snacks.bufdelete.delete, "Delete current buffer")
    utils.n_keymap("<leader>Qa", Snacks.bufdelete.all, "Delete all buffers")
    utils.n_keymap("<leader>Qo", Snacks.bufdelete.other, "Delete all except current buffer")
    utils.n_keymap("<leader>gg", Snacks.lazygit.open, "Open Lazy[g]it")
    utils.n_keymap("<leader>gb", Snacks.git.blame_line, "Git [B]lame")
end)
