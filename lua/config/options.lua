local M = {}

-- Numbers
vim.opt.relativenumber = true
vim.opt.expandtab = true
-- Set proper indentation for C++
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cpp", "h", "hpp" },
	callback = function()
		vim.opt.tabstop = 4 -- Number of spaces per tab
		vim.opt.shiftwidth = 4 -- Number of spaces per indentation
		vim.opt.softtabstop = 4 -- Make <Tab> feel like spaces
		vim.opt.expandtab = true -- Convert tabs to spaces
	end,
})

-- Copy/Paste
vim.opt.clipboard = "unnamedplus"

return M -- Ensure this line is present
