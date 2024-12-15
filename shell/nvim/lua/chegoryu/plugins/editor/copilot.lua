return {
    -- Copilot.
    "zbirenbaum/copilot.lua",
    config = function()
        local config = require("chegoryu.core.config")

        if config.DIABLE_COPILOT then
            return
        end

        local copilot = require("copilot")

        -- Change copilot snippets color.
        vim.cmd([[ highlight CmpItemKindCopilot guifg=#3FC5FF ]])

        copilot.setup({
            suggestion = {
                enabled = false,
            },
            panel = {
                enabled = false,
            },
            filetypes = {
                markdown = true,
                cmake = true,
                ["CMakeLists.txt"] = true,
            },
        })

        -- Set keymaps.
        local keymap = vim.keymap

        -- Enable/disable copilot.
        keymap.set("n", "<leader>cpe", "<cmd>Copilot enable<CR>", {
            desc = "Enable copilot.",
        })
        keymap.set("n", "<leader>cpd", "<cmd>Copilot disable<CR>", {
            desc = "Disable copilot.",
        })

        keymap.set("n", "<leader>cps", "<cmd>Copilot status<CR>", {
            desc = "Show copilot status.",
        })
    end,
}
