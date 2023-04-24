local api = vim.api
local keymap = vim.keymap
local opt = vim.bo

local get_run_command = function(command)
    return ":15split<CR>:TmuxNavigateDown<CR>:term time " .. command .. "<CR>"
end

local filetype_options = api.nvim_create_augroup("FiletypeOptions", {
    clear = true,
})

--------------------------------------------------------------------------------
-- Terminal and shell scripts.
--------------------------------------------------------------------------------

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
        "*.bash",
        "*.sh",
        "*.zsh",
    },
    group = filetype_options,
    callback = function()
        keymap.set("n", "<F5>", get_run_command("bash $(realpath %)"), { buffer = true })
    end,
})

--------------------------------------------------------------------------------
-- C and C++.
--------------------------------------------------------------------------------

api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = {
        "*.c",
        "*.h",

        "*.cpp",
        "*.hpp",
    },
    group = filetype_options,
    callback = function()
        keymap.set("n", "<F5>", get_run_command("$(realpath %<)"), { buffer = true })
        keymap.set("n", "<F9>", ":make<CR>", { buffer = true })
    end,
})

api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = {
        "*.h",

        "*.cpp",
        "*.hpp",
    },
    group = filetype_options,
    callback = function()
        opt.makeprg = "g++ -DCHEGORYU -Wall -Wextra -std=c++20 -O2 -o %< %"
    end,
})

api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = {
        "*.c",
    },
    group = filetype_options,
    callback = function()
        opt.makeprg = "gcc -DCHEGORYU -Wall -Wextra -std=c2x -O2 -o %< %"
    end,
})

--------------------------------------------------------------------------------
-- Python.
--------------------------------------------------------------------------------

api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = {
        "*.py",
    },
    group = filetype_options,
    callback = function()
        keymap.set("n", "<F5>", get_run_command("python3 $(realpath %)"), { buffer = true })
    end,
})

--------------------------------------------------------------------------------
-- Go.
--------------------------------------------------------------------------------

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

--------------------------------------------------------------------------------
-- Rust.
--------------------------------------------------------------------------------

api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = {
        "*.rs",
    },
    group = filetype_options,
    callback = function()
        opt.makeprg = "rustc -O -o %< %"
        keymap.set("n", "<F5>", get_run_command("$(realpath %<)"), { buffer = true })
        keymap.set("n", "<F9>", ":make!<CR>", { buffer = true })
    end,
})

--------------------------------------------------------------------------------
-- C#.
--------------------------------------------------------------------------------

api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = {
        "*.cs",
    },
    group = filetype_options,
    callback = function()
        opt.makeprg = "mcs -optimize -out:%< %"
        keymap.set("n", "<F5>", get_run_command("mono $(realpath %<)"), { buffer = true })
        keymap.set("n", "<F9>", ":make<CR>", { buffer = true })
    end,
})

--------------------------------------------------------------------------------
-- Java.
--------------------------------------------------------------------------------

api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = {
        "*.java",
    },
    group = filetype_options,
    callback = function()
        opt.makeprg =
            "javac % && jar -c -f %<.jar -e $(basename %<) -C $(dirname $(realpath %<.class)) $(basename %<.class)"
        keymap.set("n", "<F5>", get_run_command("java -jar $(realpath %<.jar)"), { buffer = true })
        keymap.set("n", "<F9>", ":make<CR>", { buffer = true })
    end,
})

--------------------------------------------------------------------------------
-- Kotlin.
--------------------------------------------------------------------------------

api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = {
        "*.kt",
    },
    group = filetype_options,
    callback = function()
        opt.makeprg = "kotlinc -include-runtime -d %<.jar %"
        keymap.set("n", "<F5>", get_run_command("java -jar $(realpath %<.jar)"), { buffer = true })
        keymap.set("n", "<F9>", ":make<CR>", { buffer = true })
    end,
})
