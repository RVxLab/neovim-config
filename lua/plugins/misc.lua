local add, later = MiniDeps.add, MiniDeps.later

later(function()
    add("jessarcher/vim-heritage")

    add("windwp/nvim-autopairs")
    require("nvim-autopairs").setup()

    add("tpope/vim-eunuch")
    add("tpope/vim-surround")

    add("stevearc/dressing.nvim")
    require("dressing").setup()

    add("karb94/neoscroll.nvim")
    require("neoscroll").setup()

    add("airblade/vim-rooter")
    vim.g.rooter_patterns = {
        "package.json",
        "composer.json",
        ".git",
    }

    add("folke/ts-comments.nvim")
    require("ts-comments").setup({
        lang = {
            blade = "{{-- %s --}}",
        },
    })

    add("folke/todo-comments.nvim")
    require("todo-comments").setup()

    add("folke/lazydev.nvim")
    require("lazydev").setup({
        library = {
            -- Only load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
    })

    add("lukas-reineke/indent-blankline.nvim")
    require("ibl").setup()
end)
