local vim = vim
local keymap = vim.keymap
local opts = { noremap = true, silent = true }
local utils = require("utils")
-- Remap command key
-- vim.keymap.set("n", "<leader><leader>", ":")
-- vim.keymap.set("n", "<C-p>", ":")

-- Better up/down
-- vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'",
--     { expr = true, silent = true })
-- vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'",
--     { expr = true, silent = true })

-- New tab
vim.keymap.set("n", "te", ":tabedit<CR>")
vim.keymap.set("n", "<tab>", ":tabnext<CR>", opts)
vim.keymap.set("n", "<s-tab>", ":tabprev<CR>", opts)
-- Split window
vim.keymap.set("n", "sh", ":split<Return>", opts)
vim.keymap.set("n", "sv", ":vsplit<Return>", opts)

-- split window
-- vim.keymap.set('n', 'C-Wh', '<cmd>split<cr>')
-- vim.keymap.set('n', 'C-Wv', '<cmdlvsplit<cr>')
-- Resize splits with arrow keys
vim.keymap.set('n', '<C-Up>', '<cmd>resize +2<CR>')
vim.keymap.set('n', '<C-Down>', '<cmd>resize -2<CR>')
vim.keymap.set('n', '<C-Left>', '<cmd>vertical resize -2<CR>')
vim.keymap.set('n', '<C-Right>', '<cmd>vertical resize +2<CR>')

-- Navigate buffers
-- vim.keymap.set("n", "<C-M-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
-- vim.keymap.set("n", "<C-M-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
-- vim.keymap.set("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- Select all
vim.keymap.set("n", "<C-a>", "ggVG<cr>", { desc = "Select all" })

-- Same file
vim.keymap
    .set({ "i", "v", "n" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Clear search results
vim.keymap.set("n", "<esc>", "<cmd>noh<cr>")

-- Better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Paste without replace clipboard
vim.keymap.set("v", "p", '"_dP')

-- Move Lines
-- vim.keymap.set("n", "<C-M-j>", ":m .+1<cr>==", { desc = "Move down" })
-- vim.keymap.set("v", "<C-M-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
-- vim.keymap.set("i", "<C-M-j>", "<Esc>:m .+1<cr>==gi", { desc = "Move down" })
-- vim.keymap.set("n", "<C-M-k>", ":m .-2<cr>==", { desc = "Move up" })
-- vim.keymap.set("v", "<C-M-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })
-- vim.keymap.set("i", "<C-M-k>", "<Esc>:m .-2<cr>==gi", { desc = "Move up" })

-- CLose buffer
-- vim.keymap.set({ "i", "v", "n" }, "<C-w>", "<cmd>bd<cr><esc>",
-- { desc = "Close buffer" })
-- vim.keymap.set({ "i", "v", "n" }, "<C-M-w>", "<cmd>bd!<cr><esc>",
-- { desc = "Close buffer" })

-- Exit neovim
vim.keymap.set({ "i", "v", "n" }, "<C-q>", "<cmd>q<cr>", { desc = "Exit Vim" })
vim.keymap.set({ "i", "v", "n" }, "<C-M-q>", "<cmd>qa!<cr>", { desc = "Exit Vim" })

-- Better move
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Clear search results
vim.keymap.set("n", "<leader>f", "za")

-- toggle options
vim.keymap.set("n", "<leader>tw", function() utils.toggle("wrap") end,
    { desc = "Toggle Word Wrap" })
vim.keymap.set("n", "<leader>ts", function() utils.toggle("spell") end,
    { desc = "Toggle Spelling" })
vim.keymap.set("n", "<leader>tl", function() utils.toggle("relativenumber") end,
    { desc = "Toggle Line Numbers" })
vim.keymap.set("n", "<leader>td", utils.toggle_diagnostics,
    { desc = "Toggle Diagnostics" })
vim.keymap.set("n", "<leader>q", utils.toggle_quickfix,
    { desc = "Toggle Quickfix Window" })

vim.keymap.set("n", "<C-M-f>", function()
    vim.lsp.buf.format({ async = false })
    vim.api.nvim_command("write")
end, { desc = "Lsp formatting" })

-- NvimTree
vim.keymap.set("n", "<leader>nt", "<cmd>NvimTreeToggle<cr>",
    { desc = "NvimTreeToggle" })

-- Telescope
vim.api.nvim_set_keymap('n', '<Leader>fgi',
    ':lua require"telescope.builtin".live_grep({ hidden = true })<CR>',
    { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ffi',
    ':lua require"telescope.builtin".find_files({ hidden = true })<CR>',
    { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope git_files<cr>",
    { desc = "Find Files (root dir)" })
vim.keymap.set("n", "<leader><space>", "<cmd>Telescope buffers<cr>",
    { desc = "Find Buffers" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>",
    { desc = "Search Project" })
vim.keymap.set("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>",
    { desc = "Search Document Symbols" })
vim.keymap.set("n", "<leader>fw",
    "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
    { desc = "Search Workspace Symbols" })
vim.keymap.set("n", "<leader>fht", "<cmd>Telescope help_tags<cr>",
    { desc = "Search Project" })
vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>",
    { desc = "Open recentfiles" })
vim.keymap.set("n", "<leader>fm", "<cmd>Telescope man_pages<cr>",
    { desc = "Man pages" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope registers<cr>",
    { desc = "Registers" })
vim.keymap.set("n", "<leader>fc", "<cmd>Telescope commands<cr>",
    { desc = "commands" })
vim.keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>",
    { desc = "keymaps" })
-- open file_browser with the path of the current buffer
vim.api.nvim_set_keymap(
    "n",
    "<space>fb",
    ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
    { noremap = true }
)

-- LSP
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename Symbol' })
vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition,
    { desc = 'Goto Definition' })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action,
    { desc = 'Code Action' })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
vim.keymap.set('n', '<leader>sf', vim.lsp.buf.format, { desc = 'Format Code' })
-- vim.keymap.set('n', '<leader>cl', vim.lsp.codelens, {desc = 'Format Code'})

-- DAP
vim.keymap.set('n', '<leader>dt', "<cmd>DapTerminate<cr>",
    { desc = "Dap Terminate" })
vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>b',
    function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
vim.keymap.set('n', '<Leader>lp', function()
    require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
vim.keymap.set({ 'n', 'v' }, '<Leader>dh',
    function() require('dap.ui.widgets').hover() end)
vim.keymap.set({ 'n', 'v' }, '<Leader>dp',
    function() require('dap.ui.widgets').preview() end)
vim.keymap.set('n', '<Leader>df', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.scopes)
end)

-- last change
vim.keymap.set('n', 'gl', '`.', { desc = "Jump to the last changeoint" })

-- quickfix mappings
vim.keymap.set('n', '[q', ':cprevious<CR>')
vim.keymap.set('n', ']q', ':cnext<CR>')

-- vim.keymap.set('n', ']n', ']Q', ':clast<CR>')
-- vim.keymap.set('n', ']n', '[Q', ':cfirst<CR>')
-- vim.keymap.set('n', ']n', '[b', ':bprevious<CR>')
-- vim.keymap.set('n', ']n', ']b', ':bpnext<CR>')

--
-- Copilot
-- enable
-- disable
-- Can i toggle?
vim.keymap.set("n", "<leader>ce", "<cmd>Copilot enable<cr>",
    { desc = "enable copilot" })
vim.keymap.set("n", "<leader>cd", "<cmd>Copilot disable<cr>",
    { desc = "disable copilot" })
vim.keymap.set("n", "<leader>ct", "<cmd>Copilot toggle<cr>",
    { desc = "toggle copilot" })
