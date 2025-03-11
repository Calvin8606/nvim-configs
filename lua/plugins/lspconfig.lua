return {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = { "lua_ls", "clangd", "gopls", "rust_analyzer", "zls" },
        })

        local lspconfig = require("lspconfig")

        -- Lua setup (fix undefined `vim` warning)
        lspconfig.lua_ls.setup({
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                },
            },
        })

        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        -- C++ setup
        lspconfig.clangd.setup({ capabilities = capabilities })

        -- Golang setup
        lspconfig.gopls.setup({ capabilities = capabilities })

        -- Rust setup
        lspconfig.rust_analyzer.setup({ capabilities = capabilities })

        -- Fixed Zig setup
        lspconfig.zls.setup({
            capabilities = capabilities,
            settings = {
                zls = { -- This should be inside `zls`, NOT `Zig`
                    enable_autofix = true,
                },
            },
        })

        -- Ensure auto-formatting on save
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*.zig",
            callback = function()
                vim.lsp.buf.format({ async = false })
            end,
        })
    end,
}
