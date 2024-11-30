local add, later = MiniDeps.add, MiniDeps.later

later(function()
    add("tpope/vim-projectionist")

    vim.g.projectionist_heuristics = {
        -- Laravel
        artisan = {
            ["app/*.php"] = {
                type = "source",
                alternate = {
                    "tests/Unit/{}Test.php",
                    "tests/Feature/{}Test.php",
                },
            },
            ["tests/Unit/*Test.php"] = {
                type = "test",
                alternate = "app/{}.php",
            },
            ["tests/Feature/*Test.php"] = {
                type = "test",
                alternate = "app/{}.php",
            },
            ["app/Models/*.php"] = {
                type = "model",
            },
            ["app/Http/Controllers/*.php"] = {
                type = "controller",
            },
            ["app/Actions/*.php"] = {
                type = "action",
            },
            ["routes/*.php"] = {
                type = "route",
            },
            ["database/migrations/*.php"] = {
                type = "migration",
            },
        },
        -- PHP
        ["composer.json"] = {
            ["src/*.php"] = {
                type = "source",
                alternate = {
                    "tests/Unit/{}Test.php",
                    "tests/Feature/{}Test.php",
                },
            },
            ["test/Unit/*Test.php"] = {
                type = "test",
                alternate = "src/{}.php",
            },
            ["test/Feature/*Test.php"] = {
                type = "test",
                alternate = "src/{}.php",
            },
        },
        -- TypeScript
        ["tsconfig.json"] = {
            ["*.test.ts"] = {
                type = "test",
                alternate = {
                    "{}.ts",
                    "{}.tsx",
                },
            },
            ["*.test.tsx"] = {
                type = "test",
                alternate = {
                    "{}.ts",
                    "{}.tsx",
                },
            },
            ["*.ts"] = {
                type = "source",
                alternate = {
                    "{}.test.ts",
                    "{}.test.tsx",
                },
            },
            ["*.tsx"] = {
                type = "source",
                alternate = {
                    "{}.test.ts",
                    "{}.test.tsx",
                },
            },
        },
        -- Lua
        [".luacheckrc"] = {
            ["lua/*.lua"] = {
                type = "source",
                alternate = {
                    "tests/{}_spec.lua",
                },
            },
            ["tests/*_spec.lua"] = {
                type = "test",
                alternate = {
                    "lua/{}.lua",
                },
            },
        },
    }
end)
