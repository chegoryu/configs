local opt = vim.bo
local keymap = vim.keymap

local make_and_run = vim.api.nvim_create_augroup("MakeAndRun", {
    clear = true,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = {
        "*.c",
        "*.h",

        "*.cpp",
        "*.hpp",
    },
    group = make_and_run,
    callback = function()
        opt.makeprg = "g++ -DCHEGORYU -Wall -Wextra -std=c++20 -O2 -o %< %"
        keymap.set("n", "<F5>", ":!time $(realpath %<)<CR>", { buffer = true })
        keymap.set("n", "<F9>", ":make<CR>", { buffer = true })
    end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = {
        "*.py",
    },
    group = make_and_run,
    callback = function()
        keymap.set("n", "<F5>", ":!time python3 $(realpath %)<CR>", { buffer = true })
    end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = {
        "*.go",
    },
    group = make_and_run,
    callback = function()
        opt.makeprg = "go build -o %< %"
        keymap.set("n", "<F5>", ":!time $(realpath %<)<CR>", { buffer = true })
        keymap.set("n", "<F9>", ":make<CR>", { buffer = true })
    end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = {
        "*.bash",
        "*.sh",
        "*.zsh",
    },
    group = make_and_run,
    callback = function()
        keymap.set("n", "<F5>", ":!time bash $(realpath %)<CR>", { buffer = true })
    end,
})
