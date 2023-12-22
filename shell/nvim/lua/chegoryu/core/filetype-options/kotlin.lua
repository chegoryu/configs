local common = require("chegoryu.core.filetype-options.common")

--------------------------------------------------------------------------------
-- Kotlin.
--------------------------------------------------------------------------------

common.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = {
        "*.kt",
    },
    group = common.filetype_options,
    callback = function()
        common.opt.makeprg = "kotlinc -include-runtime -d %<.jar %"
        common.keymap.set("n", "<F5>", common.get_run_command("java -jar $(realpath %<.jar)"), {
            buffer = true,
            desc = "Run kotlin program.",
        })
        common.keymap.set("n", "<F9>", "<cmd>make<CR>", {
            buffer = true,
            desc = "Make kotlin program.",
        })
    end,
})
