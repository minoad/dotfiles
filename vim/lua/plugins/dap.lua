--M =
-- dapui.setup()
-- built on elements.  elements are windows.  elements are grouped into layouts.
-- elements can alos be displayed temporarily in floating windows.
-- each element has a set of mappings for actions.
-- default
-- -- edit: e
-- -- expand: <cr>
-- -- open: o
-- -- remove: d
-- -- repl: r
-- -- toggle: t
-- elements
-- -- scopes
-- -- stacks
-- -- watchs
-- -- breakpoints
-- -- repl
-- -- console
-- require("dapui").setup()
-- -- each functions optionally takes "sidebar" or "tray"
-- -- require("dapui").open()
-- -- require("dapui").close()
-- -- require("dapui").toggle()
-- :help dap-extensions
-- -- local dap, dapui = require("dap"), require("dapui")
-- -- dap.listeners.after.event_initialized["dapui_config"] = function()
-- --     dapui.open()
-- -- end
-- elements can be floated
-- -- require("dapui").float_element(<element ID>, <optional settings>)
-- -- optional settings are width, height, enter, position
-- -- vnoremap <M-k> <Cmd>lua require("dapui").eval()<CR>

return {
  "rcarriga/nvim-dap-ui",
  dependencies = { "mfussenegger/nvim-dap", "mfussenegger/nvim-dap-python" },
  keys = {
    {
      "<leader>du",
      function() require("dapui").toggle({}) end,
      desc = "Dap UI"
    },
    {
      "<leader>de",
      function() require("dapui").eval() end,
      desc = "Eval",
      mode = { "n", "v" }
    },
  },
  opts = {},
  config = function(_, opts)
    local dap = require("dap")

    local dapui = require("dapui")
    dapui.setup(opts)
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open({})
    end
    --dap.listeners.before.event_terminated["dapui_config"] = function()
    --  dapui.close({})
    --end
    --dap.listeners.before.event_exited["dapui_config"] = function()
    --  dapui.close({})
    --end

    dap.configurations.python = {
        {
            type = 'python',
            request = 'launch',
            name = "Launch file",
            program = "${file}",
            -- By default, pythonPath is read from VIRTUAL_ENV variable
            --pythonPath = function() return 'python' end
        }
    }

    dap.adapters.python = {
       type = 'executable',
       --command = "source /Users/micnorman/repos/projects/personal/kubelab/projects/python_click/.venv/bin/activate && python3",
       --command = "source .venv/bin/activate && python3",
       command = "python3",
       --command = os.getenv('HOME') .. '/.virtualenvs/tools/bin/python',
       --command = 'python -m venv .venv; activate .venv/bin/activate',
       args = { "-m", "debugpy.adapter" }
     }
  end,
}, {
  "mfussenegger/nvim-dap",
  config = function()
    vim.keymap.set("n", "<leader>d<space>", ":DapContinue<CR>")
    vim.keymap.set("n", "tb", ":DapToggleBreakpoint<CR>")
    vim.keymap.set("n", "<leader>dl", ":DapStepInto<CR>")
    vim.keymap.set("n", "<leader>dj", ":DapStepOver<CR>")
    vim.keymap.set("n", "<leader>dh", ":DapStepOut<CR>")
    vim.keymap.set("n", "<leader>dz", ":ZoomWinTabToggle<CR>")
    vim.keymap.set(
      "n",
      "<leader>dgt", -- dg as in debu[g] [t]race
      ":lua require('dap').set_log_level('TRACE')<CR>"
    )
    vim.keymap.set(
      "n",
      "<leader>dge", -- dg as in debu[g] [e]dit
      function()
        vim.cmd(":edit " .. vim.fn.stdpath('cache') .. "/dap.log")
      end
    )
    vim.keymap.set("n", "<F1>", ":DapStepOut<CR>")
    vim.keymap.set("n", "<F2>", ":DapStepOver<CR>")
    vim.keymap.set("n", "<F3>", ":DapStepInto<CR>")
    vim.keymap.set(
      "n",
      "<leader>d-",
      function()
        require("dap").restart()
      end
    )
    vim.keymap.set(
      "n",
      "<leader>d_",
      function()
        require("dap").terminate()
        require("dapui").close()
      end
    )
  end,
  lazy = true,
}, {
  "mfussenegger/nvim-dap-python",
  config = function()
    require("dap-python").setup("/opt/homebrew/bin/python3") --"/path/to/python/here")  -- XXX: Replace this with your preferred Python, if wanted
    -- An example configuration to launch any Python file, via Houdini
    -- table.insert(
    --     require("dap").configurations.python,
    --     {
    --         type = "python",
    --         request = "launch",
    --         name = "Launch Via hython",
    --         program = "${file}",
    --         python = "/opt/hfs19.5.569/bin/hython"
    --         -- ... more options, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
    --     }
    -- )
  end,
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-treesitter/nvim-treesitter",
  },
}, {
  "jay-babu/mason-nvim-dap.nvim",
  dependencies = "mason.nvim",
  cmd = { "DapInstall", "DapUninstall" },
  opts = {
    -- Makes a best effort to setup the various debuggers with
    -- reasonable debug configurations
    automatic_installation = true,

    -- You can provide additional configuration to the handlers,
    -- see mason-nvim-dap README for more information
    handlers = {},

    -- You'll need to check that you have the required things installed
    -- online, please don't ask me how to install them :)
    ensure_installed = {
      "python",
      -- Update this to ensure that you have the debuggers for the langs you want
    },
  },
}



-- return M
-- A default "GUI" front-end for nvim-dap
-- M = {
--    "rcarriga/nvim-dap-ui",
--    config = function()
--        require("dapui").setup()
--
--	-- Note: Added this <leader>dd duplicate of <F5> because somehow the <F5>
--	-- mapping keeps getting reset each time I restart nvim-dap. Annoying but whatever.
--	--
--	vim.keymap.set(
--		"n",
--		"<leader>dd",
--		function()
--			require("dapui").open()  -- Requires nvim-dap-ui
--
--			vim.cmd[[DapContinue]]  -- Important: This will lazy-load nvim-dap
--		end
--	)
--    end,
--    dependencies = {
--        "mfussenegger/nvim-dap",
--
--        "mfussenegger/nvim-dap-python",  -- Optional adapter for Python
--    },
-- }
--
-- return M
