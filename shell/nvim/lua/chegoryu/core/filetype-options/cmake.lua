local common = require("chegoryu.core.filetype-options.common")

--------------------------------------------------------------------------------
-- CMake.
--------------------------------------------------------------------------------

common.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = {
        "*.cmake",

        "CMakeLists.txt",
    },
    group = common.filetype_options,
    callback = function()
        if common.config.IS_PINELY then
            common.opt.tabstop = 2
            common.opt.shiftwidth = 2
        end
    end,
})
