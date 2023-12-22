local common = require("chegoryu.core.filetype-options.common")

--------------------------------------------------------------------------------
-- Python.
--------------------------------------------------------------------------------

common.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = {
        "*.py",
    },
    group = common.filetype_options,
    callback = function()
        common.keymap.set("n", "<F5>", common.get_run_command("python3 $(realpath %)"), {
            buffer = true,
            desc = "Run python script.",
        })
    end,
})
