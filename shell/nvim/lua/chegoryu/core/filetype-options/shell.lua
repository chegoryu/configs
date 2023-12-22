local common = require("chegoryu.core.filetype-options.common")

--------------------------------------------------------------------------------
-- Terminal and shell scripts.
--------------------------------------------------------------------------------

common.api.nvim_create_autocmd("TermOpen", {
    group = common.filetype_options,
    callback = function()
        local opt_local = vim.opt_local

        opt_local.relativenumber = false
        opt_local.number = false

        opt_local.list = false

        vim.cmd("startinsert")
    end,
})

common.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = {
        "*.bash",
        "*.sh",
        "*.zsh",
    },
    group = common.filetype_options,
    callback = function()
        common.keymap.set("n", "<F5>", common.get_run_command("bash $(realpath %)"), {
            buffer = true,
            desc = "Run shell script.",
        })
    end,
})
