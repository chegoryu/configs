local common = require("chegoryu.core.filetype-options.common")

--------------------------------------------------------------------------------
-- Go.
--------------------------------------------------------------------------------

common.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = {
        "*.go",
    },
    group = common.filetype_options,
    callback = function()
        common.opt.expandtab = false

        common.opt.makeprg = "go build -o %< %"
        common.keymap.set("n", "<F5>", common.get_run_command("$(realpath %<)"), {
            buffer = true,
            desc = "Run go program.",
        })
        common.keymap.set("n", "<F9>", "<cmd>make<CR>", {
            buffer = true,
            desc = "Make go program.",
        })
    end,
})
