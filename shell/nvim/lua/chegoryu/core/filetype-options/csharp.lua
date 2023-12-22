local common = require("chegoryu.core.filetype-options.common")

--------------------------------------------------------------------------------
-- C#.
--------------------------------------------------------------------------------

common.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = {
        "*.cs",
    },
    group = common.filetype_options,
    callback = function()
        common.opt.makeprg = "mcs -optimize -out:%< %"
        common.keymap.set("n", "<F5>", common.get_run_command("mono $(realpath %<)"), {
            buffer = true,
            desc = "Run C# program.",
        })
        common.keymap.set("n", "<F9>", "<cmd>make<CR>", {
            buffer = true,
            desc = "Make C# program.",
        })
    end,
})
