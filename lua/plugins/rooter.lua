local add, now = MiniDeps.add, MiniDeps.later

now(function()
    add("airblade/vim-rooter")

    vim.g.rooter_patterns = {
        "package.json",
        "composer.json",
        ".git",
    }
end)
