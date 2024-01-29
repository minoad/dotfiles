local util = require("lspconfig/util")
local function get_python_path(workspace)
    -- Use activated virtualenv.
    if vim.env.VIRTUAL_ENV then
        return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
    end

    -- Find and use virtualenv in workspace directory.
    for _, pattern in ipairs({ "*", ".*" }) do
        local match = vim.fn.glob(path.join(workspace, pattern, "pyvenv.cfg"))
        if match ~= "" then
            return path.join(path.dirname(match), "bin", "python")
        end
    end

    -- Fallback to system Python.
    return exepath("python3") or exepath("python") or "python"
end
--

-- require("mason-nvim-dap").setup({
--     ensure_installed = { "python" },
--     automatic_installation = true
-- })

-- local dap = require('dap')
-- require('dap').set_log_level('DEBUG')

-- -- require('plugins.nvim-dap-ui')


--  -- :lua print(vim.fn.stdpath('cache'))
-- dap.adapters.python = {
--     type = 'executable',
--     command = "python3",
--     --command = os.getenv('HOME') .. '/.virtualenvs/tools/bin/python',
--     --command = 'python -m venv .venv; activate .venv/bin/activate',
--     args = { "-m", "debugpy.adapter" }
-- }

-- dap.configurations.python = {
--     {
--         type = 'python',
--         request = 'launch',
--         name = "Launch file",
--         program = "${file}",
--         pythonPath = function() return 'python' end
--     }
-- }


-- Mason is not reccomeneded for lazy load
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

-- require("mason").setup()

require("mason-null-ls").setup({
    ensure_installed = {
        "black", "luaformatter" -- "autopep8",
        -- "flake8",
        -- "pylint",
        -- "isort"
        -- "jq"
    },
    automatic_installation = true,
    handlers = {}
})

require("null-ls").setup({
    sources = {
        -- Anything not supported by mason.
    }
})

require("mason-lspconfig").setup({
    ensure_installed = {
        -- "rust_analyzer",
        "pyright"
        -- "jq"
        -- "lua_lsp"
        -- "lua_ls",
        -- "awk-language-server",
        -- "black",
        -- "cmake-language-server",
        -- "flake8",
        -- "gopls",
        -- "jq",
    }
})
-- require('lspconfig').pyright.setup{}
require('lspconfig').lua_ls.setup({
    settings = { Lue = { diagnostics = { globals = { "vim" } } } }
})
require('lspconfig').pyright.setup({
    before_init = function(_, config)
        config.settings.python.pythonPath = get_python_path(config.root_dir)
    end,
    on_attach = on_attach,
    capabilities = capabilities
})
require('lspconfig').lua_ls.setup {}
