local common = require("chegoryu.core.filetype-options.common")

--------------------------------------------------------------------------------
-- Rust.
--------------------------------------------------------------------------------

common.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = {
        "*.rs",
    },
    group = common.filetype_options,
    callback = function()
        common.opt.makeprg = "rustc --cfg chegoryu -O -o %< %"
        common.keymap.set("n", "<F5>", common.get_run_command("$(realpath %<)"), {
            buffer = true,
            desc = "Run rust program.",
        })
        common.keymap.set("n", "<F9>", "<cmd>make!<CR>", {
            buffer = true,
            desc = "Make rust program.",
        })
    end,
})
