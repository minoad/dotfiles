local vim = vim
--
-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	command = "set nopaste",
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = '*',
})

local term_group = vim.api.nvim_create_augroup('Terminal', { clear = true })
vim.api.nvim_create_autocmd('TermOpen', {
	callback = function()
		--vim.opt_local.nonumber = true
		vim.opt_local.relativenumber = true
		vim.opt_local.signcolumn = 'no'
		vim.opt_local.wrap = false
		vim.keymap.set('i', 'jk', '<C-\\><C-n>', { desc = "map jk to exit terminal mode" })
	end,
	group = term_group,
	pattern = 'term://*',
})

-- Close man and help with just <q>
--autocmd('FileType', {
--  pattern = {
--    'help',
--    'man',
--    'lspinfo',
--    'checkhealth',
--  },
--  callback = function(event)
--    vim.bo[event.buf].buflisted = false
--    vim.keymap.set('n', 'q', '<cmd>q<cr>', { buffer = event.buf, silent = true })
--  end,
--})
