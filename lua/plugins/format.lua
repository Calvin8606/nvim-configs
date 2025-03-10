return {
        "nvimtools/none-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
                local null_ls = require("null-ls")

                null_ls.setup({
                        sources = {
                                null_ls.builtins.formatting.stylua, -- Lua formatter
                                null_ls.builtins.formatting.prettier, -- JS, TS, HTML formatter
                                null_ls.builtins.completion.spell, -- Spell checker
                                --null_ls.builtins.formatting.clang_format, -- C++, C
                                -- null_ls.builtins.formatting.rustfmt, -- Rust
                        },
                })

                -- Auto format on save
                vim.api.nvim_create_autocmd("BufWritePre", {
                        callback = function()
                                vim.lsp.buf.format({ async = false })
                        end,
                })
        end,
}
