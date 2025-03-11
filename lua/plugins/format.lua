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
                -- null_ls.builtins.formatting.clang_format, -- C++, C
                -- null_ls.builtins.formatting.rustfmt, -- Rust
            },
            on_attach = function(client, bufnr)
                local filetype = vim.bo[bufnr].filetype

                -- Prevent `none-ls` from formatting Zig files
                if filetype == "zig" then
                    return
                end

                -- Run formatting only if `none-ls` supports it
                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({ async = false })
                        end,
                    })
                end
            end,
        })
    end,
}
