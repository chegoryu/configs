local common = require("chegoryu.core.filetype-options.common")

--------------------------------------------------------------------------------
-- C and C++.
--------------------------------------------------------------------------------

common.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = {
        "*.c",
        "*.h",

        "*.cpp",
        "*.hpp",
    },
    group = common.filetype_options,
    callback = function()
        if common.config.IS_PINELY then
            common.opt.tabstop = 2
            common.opt.shiftwidth = 2
        end

        common.keymap.set("n", "<F5>", common.get_run_command("$(realpath %<)"), {
            buffer = true,
            desc = "Run C/C++ program.",
        })
        common.keymap.set("n", "<F9>", "<cmd>make<CR>", {
            buffer = true,
            desc = "Make C/C++ program.",
        })
    end,
})

common.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = {
        "*.h",

        "*.cpp",
        "*.hpp",
    },
    group = common.filetype_options,
    callback = function()
        common.opt.makeprg = "g++ -DCHEGORYU -Wall -Wextra -std=c++20 -O2 -o %< %"
    end,
})

common.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = {
        "*.c",
    },
    group = common.filetype_options,
    callback = function()
        common.opt.makeprg = "gcc -DCHEGORYU -Wall -Wextra -std=c2x -O2 -o %< %"
    end,
})
