local utils = require("rvxlab.utils")
local lsp = require("rvxlab.lsp")

return {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup()

        local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

        local default_config = {
            capabilities = capabilities,
            on_attach = lsp.on_attach,
            inlay_hint = {
                enable = true,
            },
        }

        local make_config = function(opts)
            return vim.tbl_deep_extend("force", default_config, opts)
        end

        local lspconfig = require("lspconfig")

        -- Set up all language servers
        -- The following are installed but should not be initialized here:
        --
        -- - TailwindCSS: Set up by tailwind-tools
        -- - Rust Analyzer: Set up by rustaceanvim
        lspconfig.tsserver.setup(make_config({
            on_attach = function(_client, buffer)
                lsp.setup_remaps(buffer)
            end,
            filetypes = {
                "javascript",
                "javascriptreact",
                "javascript.jsx",
                "typescript",
                "typescriptreact",
                "typescript.tsx",
                "vue",
            },
            inlay_hint = {
                enable = false,
            },
            init_options = {
                plugins = {
                    {
                        name = "@vue/typescript-plugin",
                        location = utils.invoke(function()
                            local registry = require("mason-registry")
                            local plugin_path = registry.get_package("vue-language-server"):get_install_path()
                            return plugin_path .. "/node_modules/@vue/language-server"
                        end),
                        languages = { "vue" },
                    },
                },
                preferences = {
                    includeInlayParameterNameHints = "all",
                    includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayVariableTypeHints = true,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayEnumMemberValueHints = true,
                    importModuleSpecifierPreference = "non-relative",
                },
            },
        }))
        lspconfig.volar.setup(make_config({}))
        lspconfig.lua_ls.setup(make_config({
            settings = {
                Lua = {
                    runtime = { version = "LuaJIT" },
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            vim.env.VIMRUNTIME,
                            "${3rd}/luv/library",
                            unpack(vim.api.nvim_get_runtime_file("", true)),
                        },
                    },
                    hint = {
                        enable = true,
                    },
                    completion = {
                        callSnippet = "Replace",
                    },
                },
            },
        }))
        lspconfig.bashls.setup(make_config({}))
        lspconfig.yamlls.setup(make_config({}))
        lspconfig.jsonls.setup(make_config({}))
        lspconfig.html.setup(make_config({}))
        lspconfig.cssls.setup(make_config({}))
        lspconfig.intelephense.setup(make_config({
            filetypes = { "php", "blade" },
        }))
        lspconfig.gdscript.setup(make_config({}))
    end,
}
