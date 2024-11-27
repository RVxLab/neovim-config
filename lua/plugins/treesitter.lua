local utils = require('utils')

local add, later = MiniDeps.add, MiniDeps.later

later(function ()
    add({
        source = "nvim-treesitter/nvim-treesitter",
        depends = {
            "nvim-treesitter/nvim-treesitter-context",
        },
        checkout = "master",
        monitor = "main",
        hooks = {
            post_checkout = function ()
                vim.cmd('TSUpdate')
            end,
        },
    })

    -- Treesitter Textobjects must be loaded separately, otherwise
    -- nvim-treesitter.configs cannot be found
    add("nvim-treesitter/nvim-treesitter-textobjects")

    -- Add a parser for Laravel Blade
    local parser_configs = require("nvim-treesitter.parsers").get_parser_configs();
    parser_configs.blade = {
        install_info = {
            url = "https://github.com/EmranMR/tree-sitter-blade",
            files = {"src/parser.c"},
            branch = "main",
        },
        filetype = "blade"
    }

    -- Load treesitter
    require("nvim-treesitter.configs").setup({
        ensure_installed = {
            "lua",
            "rust",
            "tsx",
            "javascript",
            "typescript",
            "vimdoc",
            "vim",
            "bash",
            "json",
            "yaml",
            "php",
            "blade",
            "html",
            "css",
            "markdown",
            "markdown_inline",
        },
        auto_install = true,
        highlight = {
            enable = true,
        },
        indent = {
            enable = true,
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                node_incremental = "v",
                node_decremental = "V",
            },
        },
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    -- Assignments
                    ["a="] = { query = "@assignment.outer", desc = "Select around an assignment" },
                    ["i="] = { query = "@assignment.inner", desc = "Select inside an assignment" },
                    ["l="] = { query = "@assignment.lhs", desc = "Select left-hand side of an assignment" },
                    ["r="] = { query = "@assignment.rhs", desc = "Select right-hand side of an assignment" },

                    -- Parameters/Arguments
                    ["aa"] = { query = "@parameter.outer", desc = "Select around an argument/parameter" },
                    ["ai"] = { query = "@parameter.inner", desc = "Select inside an argument/parameter" },

                    -- Conditionals
                    ["ia"] = { query = "@conditional.outer", desc = "Select around a conditional" },
                    ["ii"] = { query = "@conditional.inner", desc = "Select inside a conditional" },

                    -- Loops
                    ["al"] = { query = "@loop.outer", desc = "Select around a loop" },
                    ["il"] = { query = "@loop.inner", desc = "Select inside a loop" },

                    -- Functions/Methods
                    ["af"] = { query = "@call.outer", desc = "Select around a function/method call" },
                    ["if"] = { query = "@call.inner", desc = "Select inside a function/method call" },
                    ["am"] = { query = "@function.outer", desc = "Select around a function/method definition" },
                    ["im"] = { query = "@function.inner", desc = "Select inside a function/method definition" },

                    -- Classes/Structs
                    ["ac"] = { query = "@class.outer", desc = "Select around a class/struct" },
                    ["ic"] = { query = "@class.inner", desc = "Select inside a class/struct" },

                    -- Blocks
                    ["ab"] = { query = "@block.outer", desc = "Select around a block" },
                    ["ib"] = { query = "@block.inner", desc = "Select inside a block" },
                },
            },
        },
    })

    -- Set up treesitter context
    require('treesitter-context').setup({
        line_numbers = false,
        max_lines = 5,
        multiline_threshold = 3,
    })

    -- Add .php.blade files so they use the Blade parser
    vim.filetype.add({
        pattern = {
            [".*%.blade%.php"] = "blade",
        },
    })

    -- Add keymaps
    utils.n_keymap("[c", function()
        require("treesitter-context").go_to_context(vim.v.count1)
    end, "Go to parent [c]ontext")
end)

