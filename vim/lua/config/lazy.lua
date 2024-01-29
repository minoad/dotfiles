local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

-- load lazy
require("lazy").setup({
	{import = "plugins"},
	{import = "plugins.lsp"}
	},
	{
		install = { colorscheme = { "tokyonight" } },
		defaults = { lazy = true },
		ui = {
			border = "rounded",
		},
		checker = { 
			enabled = true,
			notify = false,
		},
		change_detection = {
			enabled = true,
			notify = false,
		},
		debug = true,
})


-- Mason is not reccomended for lazy load

-- require("mason").setup()
-- require("mason-lspconfig").setup()