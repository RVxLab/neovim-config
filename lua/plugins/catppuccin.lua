local add, now = MiniDeps.add, MiniDeps.now

now(function()
    add({
        source = "catppuccin/nvim",
        name = "catppuccin",
    })

    require("catppuccin").setup({
        flavour = "macchiato",
        integrations = {
            which_key = true,
        },
    })

    vim.cmd("colorscheme catppuccin")
end)
