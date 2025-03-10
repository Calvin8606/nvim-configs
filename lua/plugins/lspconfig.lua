return {
	"neovim/nvim-lspconfig",
	dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = { "lua_ls", "clangd", "gopls", "rust_analyzer" },
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
	end,
}
