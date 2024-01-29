M = {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    extensions = {
      file_browser = {
        theme = 'ivy',
        hijack_netrw = true,
      },
    },
    opts = {
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case"
            }
        },
        pickers = {
            live_grep = {
                additional_args = function(opts)
                    return { "--hidden" }
                end
            }
        }
    }
}

return M
