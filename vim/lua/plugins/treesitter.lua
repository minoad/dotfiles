M = {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = {"puppet", "python", "lua", "vim", "regex" },
            sync_install = true,
            highlight = {enable = true},
            indent = {enable = true},
        })
    end
}

return M
--M = { "nvim-treesitter/nvim-treesitter", version = false,
--  build = function()
--    require("nvim-treesitter.install").update({ with_sync = true })
--  end,
--  config = function()
--    require("nvim-treesitter.configs").setup({
--      ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python", "javascript" },
--      auto_install = false,
--      highlight = { enable = true, additional_vim_regex_highlighting = false },
--      incremental_selection = {
--        enable = true,
--        keymaps = {
--          init_selection = "<C-n>",
--          node_incremental = "<C-n>",
--          scope_incremental = "<C-s>",
--          node_decremental = "<C-m>",
--        }
--      }
--    })
--  end
--}
--
--return M
