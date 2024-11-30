local add, later = MiniDeps.add, MiniDeps.later

later(function()
    add("tpope/vim-surround")
end)
