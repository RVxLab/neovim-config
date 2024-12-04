local add, later = MiniDeps.add, MiniDeps.later

later(function()
    add("lewis6991/gitsigns.nvim")

    require("gitsigns").setup({
        current_line_blame = true,
    })
end)
