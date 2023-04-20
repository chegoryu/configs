local api = vim.api
local opt = vim.bo
local keymap = vim.keymap

local filetype_options = api.nvim_create_augroup("FiletypeOptions", {
    clear = true,
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
        keymap.set("n", "<F5>", ":!time $(realpath %<)<CR>", { buffer = true })
        keymap.set("n", "<F9>", ":make<CR>", { buffer = true })
    end,
})

api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = {
        "*.py",
    },
    group = filetype_options,
    callback = function()
        keymap.set("n", "<F5>", ":!time python3 $(realpath %)<CR>", { buffer = true })
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
        keymap.set("n", "<F5>", ":!time $(realpath %<)<CR>", { buffer = true })
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
        keymap.set("n", "<F5>", ":!time bash $(realpath %)<CR>", { buffer = true })
    end,
})
