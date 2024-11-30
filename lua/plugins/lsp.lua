local utils = require("utils")
local add, later = MiniDeps.add, MiniDeps.later

local function keymap(mapping, action, description, buffer, opts)
    opts = opts or {}
    opts.buffer = buffer

    if opts.description then
        opts.description = string.format("LSP: %s", opts.description)
    end

    utils.n_keymap(mapping, action, description, opts)
end

local function on_attach(client, buffer)
    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true, {
            bufnr = buffer,
        })
    end

    local telescope = require("telescope.builtin")

    keymap("<C-x>", vim.diagnostic.open_float, "Open diagnostics in float", buffer)
    keymap("<leader>ca", vim.lsp.buf.code_action, "Code [a]ction", buffer)
    keymap("[d", vim.diagnostic.goto_prev, "Go to previous error", buffer)
    keymap("]d", vim.diagnostic.goto_next, "Go to previous error", buffer)
    keymap("<leader>cr", telescope.lsp_references, "Find references", buffer)
    keymap("<leader>ci", telescope.lsp_implementations, "Find implementations", buffer)
    keymap("<leader>cd", telescope.lsp_definitions, "Go to definition", buffer)
    keymap("<leader>cti", function ()
        local filter = {
            bufnr = buffer,
        }

        local is_enabled = vim.lsp.inlay_hint.is_enabled(filter)
        vim.lsp.inlay_hint.enable(not is_enabled)
    end, "Toggle [i]nlay hints", buffer)
end

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

    local config = {
        ts_ls = {
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
        },
        lua_ls = {
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
        },
        intelephense = {
            filetypes = { "php", "blade" },
            settings = {
                intelephense = {
                    environment = {
                        phpVersion = "8.3.0",
                    },
                },
            },
        },
    }

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
            local capabilities = cmp.get_lsp_capabilities({}, true)

            local server_config = vim.tbl_deep_extend("keep", config[server_name] or {}, {
                capabilities = capabilities,
                on_attach = on_attach,
            })

            require("lspconfig")[server_name].setup(server_config)
        end,
    })
end)
