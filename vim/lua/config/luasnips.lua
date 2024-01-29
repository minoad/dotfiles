local vim = vim
local ls = require("luasnip")
-- local types = require("luasnip.util.types")
-- TODO: Move this to the initial setup in plugins
ls.config.set_config {
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
    ext_opts = {
        -- [types.choice_node] = {
        --     active = {
        --         virt_text = { { "choiceNode", "Comment" } },
        --     },
        -- },
    },
}

-- some shorthands...
local snip = ls.snippet
-- local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
-- local func = ls.function_node
-- local choice = ls.choice_node
-- local dynamicn = ls.dynamic_node
local extras = require("luasnip.extras")
local rep = extras.rep
local fmt = require("luasnip.extras.fmt").fmt
local choice = ls.choice_node
local func = ls.function_node
-- local dyn = ls.dynamic_node
-- local sn = ls.snippet_node

ls.add_snippets("typescriptreact", {

    -- 1st version
    snip("coa", {
        text("position(["),
        func(function()
            local register_data = vim.fn.getreg() .. "";
            if string.match(register_data, "[%d-]+,%s*[%d-]+") then
                return register_data
            else
                print("register does not contain the pattern")
            end
        end),
        text("])"),
    })
})
-- s("co", {
--     d(function()
--         local register_data = vim.fn.getreg() .. "";
--         if string.match(register_data, "[%d-]+,%s*[%d-]+") then
--             return M.sn(nil, {
--              cd    M.t("position([" .. register_data .. "])"),
--             })
--         else
--             print("register does not contain the pattern")
--             return M.sn(nil, { })
--         end
--     end),
--     i(1)
-- })


-- functions must return a string.
-- inline or separated
local myfunc = function()
    return "from func var"
end

ls.add_snippets("lua", {
    snip("func_example", {
        func(function()
            return "testing lua function"
        end),
    }),
    snip("func_var", {
        func(myfunc),
    })
})

-- Keymaps
vim.keymap.set({ "i", "s" }, "<C-k>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, { silent = true }
)

vim.keymap.set({ "i", "s" }, "<C-j>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { silent = true }
)

vim.keymap.set("i", "<C-l>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end)

vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/lua/config/luasnips.lua<CR>", { silent = true })

-- Snippet Functions
-- local date = function() return { os.date('%Y-%m-%d') } end

-- to make a new line in text node each line needs to be passed one by one.
-- looks like the type of quotes matter
ls.add_snippets("lua", {
    snip("hello", {
        text('print("hello world")')
    }),
    snip("hey", {
        text('print("hey '),
        insert(1),
        text(' world '),
        insert(2),
        text('")')
    }),
    snip("if", {
        text('if '),
        insert(1, "true"),
        text(' then '),
        insert(2),
        text(' end'),
    }),
    snip("beg", {
        text("\\begin{}"), insert(1), text("}"),
        text({ "", "\t" }), insert(0),
        text({ "", "\\end{" }), rep(1), text("}"),
    }),
    -- large snippets passed in one by one are hard to read so use the luasnips format function
    -- this creates a startand end tag for the variable passed in
    snip("brg", fmt(
        [[
            \begin{{{}}}
                {}
            \end{{{}}}
        ]], {
            -- first param is string with some braces (above)
            -- second param is a table with nodes that will be inserted one by one
            -- curly braces escape curle braces which is why ther are six
            insert(1), insert(0), rep(1)
        }
    )),
})

ls.add_snippets("cs", {
    snip("logcc",
        fmt([[Debug.Log($"<color={}>{}</color>");]],
            {
                choice(1, {
                    text("red"),
                    text("green"),
                    text("blue"),
                    text("cyan"),
                    text("magenta")
                }),
                insert(2),
            })),
})

ls.add_snippets("py", {
    snip("shebang", {
        text('#!/usr/bin/env python'),
    }),
    snip("shebang_opt",
        fmt([[Debug.Log($"<color={}>{}</color>");]],
            {
                choice(1, {
                    text("red"),
                    text("green"),
                    text("blue"),
                    text("cyan"),
                    text("magenta")
                }),
                insert(2),
            })),
})
-- ls.parser.parse_snippet(<text>, <vscode style snippet>)
ls.add_snippets(nil, {
    all = {
        ls.parser.parse_snippet("date", "date"),
        ls.parser.parse_snippet("expand", "-- this is what was expanded"),
    },
    python = {},
    lua = {},
    toml = {},
})

-- Snippets
vim.keymap.set({"i"}, "<leader>sn", function() ls.expand() end, {silent = true})
vim.keymap.set({"i", "s"}, "<leader>sj", function() ls.jump( 1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<leader>sb", function() ls.jump(-1) end, {silent = true})

vim.keymap.set({"i", "s"}, "<leader>sc", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})


-- ls.add_snippets(nil, {
--     toml = {
--         snip({
--             trig = "pyproject_poetry",
--             name = "pyproject.toml",
--             dscr = "default pyproject.toml file for a new python poetry project."
--         }, {
--             text("[build-system]\n"),
--             text("requires = [\"poetry-core>=1.0.0\"]\n"),
--             text("build-backend = \"poetry.core.masonry.api\"\n"),
--             text("\n"),
--             text("[tool.poetry]\n"),
--             text("name = \""),
--             insert(1, "project_name"),
--             text("\"\n"),
--             text("version = \"0.1.0\"\n"),
--             text("description = \"\"\n"),
--             text("authors = [\""),
--             insert(2, "author"),
--             text(" <"),
--             insert(3, "email"),
--             text(">\"\n"),
--             text("\n"),
--             text("[tool.poetry.dependencies]\n"),
--             text("python = \"^3.9\"\n"),
--             text("\n"),
--             text("[tool.poetry.dev-dependencies]\n"),
--             text("\n"),
--             text("[build-system]\n"),
--             text("requires = [\"poetry-core>=1.0.0\"]\n"),
--             text("build-backend = \"poetry.core.masonry.api\"\n"),
--         })
--     }
-- })

-- ls.add_snippets(nil, {
--     all = {
--         snip({
--             trig = "date",
--             namr = "Date",
--             dscr = "Date in the form of YYYY-MM-DD",
--         }, {
--             func(date, {}),
--         }),
--     }
-- })
