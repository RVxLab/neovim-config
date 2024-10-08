return {
    "nvim-treesitter/nvim-treesitter",
    -- commit = "8a966f32c973511f9697264b3533e9846d29fd09",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-context",
        -- Disabled awaiting https://github.com/nvim-treesitter/nvim-treesitter-textobjects/pull/631
        -- "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
    config = function()
        -- First we add the Blade parser
        local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
        parser_configs.blade = {
            install_info = {
                url = "https://github.com/EmranMR/tree-sitter-blade",
                files = { "src/parser.c" },
                branch = "main",
            },
            filetype = "blade",
        }

        -- Next we load Treesitter
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
        })
    end,
    init = function()
        vim.filetype.add({
            pattern = {
                [".*%.blade%.php"] = "blade",
            },
        })
    end,
}
