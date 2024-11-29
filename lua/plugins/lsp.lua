local add, later = MiniDeps.add, MiniDeps.later

later(function ()
    add({
        source = "neovim/nvim-lspconfig",
        depends = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "saghen/blink.cmp",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
        },
    })

    require("mason").setup()
    require("mason-lspconfig").setup({
        ensure_installed = {
            "bashls",
            "cssls",
            "html",
            "intelephense",
            "lua_ls",
            "jsonls",
            "phpactor",
            "rust_analyzer",
            "tailwindcss",
            "ts_ls",
            "volar",
            "yamlls",
            "zls",
        },
    })

    local config = {}

    require("mason-tool-installer").setup({
        ensure_installed = {
            "eslint_d",
            "prettierd",
            "luacheck",
            "shellcheck",
            "stylua",
        },
    })

    local cmp = require("blink.cmp")

    require("mason-lspconfig").setup_handlers({
        function (server_name)
            local server_config = config[server_name] or {}
            local capabilities = cmp.get_lsp_capabilities(server_config, true)

            require("lspconfig")[server_name].setup({
                capabilities = capabilities,
            })
        end,
    })
end)
