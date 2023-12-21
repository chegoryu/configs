return {
    "zbirenbaum/copilot-cmp",
    after = {
        "copilot.lua",
    },
    config = function()
        local config = require("chegoryu.core.config")

        if config.DIABLE_COPILOT then
            return
        end

        require("copilot_cmp").setup()
    end,
}
