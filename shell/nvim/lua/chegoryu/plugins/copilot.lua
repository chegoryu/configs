local config = require("chegoryu.core.config")

if config.DIABLE_COPILOT then
    return
end

local copilot_status, copilot = pcall(require, "copilot")
if not copilot_status then
    return
end

local copilot_cmp_status, copilot_cmp = pcall(require, "copilot_cmp")
if not copilot_cmp_status then
    return
end

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
    },
})

copilot_cmp.setup()
