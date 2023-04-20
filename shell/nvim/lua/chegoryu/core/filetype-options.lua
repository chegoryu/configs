local api = vim.api
local keymap = vim.keymap
local opt = vim.bo

local get_run_command = function(command)
    return ":15split<CR>:TmuxNavigateDown<CR>:term time " .. command .. "<CR>"
end

local filetype_options = api.nvim_create_augroup("FiletypeOptions", {
    clear = true,
})

api.nvim_create_autocmd("TermOpen", {
    group = filetype_options,
    callback = function()
        local opt_local = vim.opt_local

        opt_local.relativenumber = false
        opt_local.number = false

        opt_local.list = false

        vim.cmd("startinsert")
    end,
})

api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = {
        "*.c",
        "*.h",

        "*.cpp",
        "*.hpp",
    },
    group = filetype_options,
    callback = function()
        opt.makeprg = "g++ -DCHEGORYU -Wall -Wextra -std=c++20 -O2 -o %< %"
        keymap.set("n", "<F5>", get_run_command("$(realpath %<)"), { buffer = true })
        keymap.set("n", "<F9>", ":make<CR>", { buffer = true })
    end,
})

api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = {
        "*.py",
    },
    group = filetype_options,
    callback = function()
        keymap.set("n", "<F5>", get_run_command("python3 $(realpath %)"), { buffer = true })
    end,
})

api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = {
        "*.go",
    },
    group = filetype_options,
    callback = function()
        opt.expandtab = false

        opt.makeprg = "go build -o %< %"
        keymap.set("n", "<F5>", get_run_command("$(realpath %<)"), { buffer = true })
        keymap.set("n", "<F9>", ":make<CR>", { buffer = true })
    end,
})

api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = {
        "*.bash",
        "*.sh",
        "*.zsh",
    },
    group = filetype_options,
    callback = function()
        keymap.set("n", "<F5>", get_run_command("bash $(realpath %)"), { buffer = true })
    end,
})
