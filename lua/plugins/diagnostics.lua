local add, later = MiniDeps.add, MiniDeps.later

later(function ()
    add("rachartier/tiny-inline-diagnostic.nvim")

    require("tiny-inline-diagnostic").setup()

    vim.diagnostic.config({
        virtual_text = false,
    })
end)
