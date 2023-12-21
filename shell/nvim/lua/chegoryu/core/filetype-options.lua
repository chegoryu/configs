local config = require("chegoryu.core.config")

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
        keymap.set("n", "<F5>", get_run_command("bash $(realpath %)"), {
            buffer = true,
            desc = "Run shell script.",
        })
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
        if config.IS_PINELY then
            opt.tabstop = 2
            opt.shiftwidth = 2
        end

        keymap.set("n", "<F5>", get_run_command("$(realpath %<)"), {
            buffer = true,
            desc = "Run C/C++ program.",
        })
        keymap.set("n", "<F9>", "<cmd>make<CR>", {
            buffer = true,
            desc = "Make C/C++ program.",
        })
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
-- CMake.
--------------------------------------------------------------------------------

api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = {
        "*.cmake",

        "CMakeLists.txt",
    },
    group = filetype_options,
    callback = function()
        if config.IS_PINELY then
            opt.tabstop = 2
            opt.shiftwidth = 2
        end
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
        keymap.set("n", "<F5>", get_run_command("python3 $(realpath %)"), {
            buffer = true,
            desc = "Run python script.",
        })
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
        keymap.set("n", "<F5>", get_run_command("$(realpath %<)"), {
            buffer = true,
            desc = "Run go program.",
        })
        keymap.set("n", "<F9>", "<cmd>make<CR>", {
            buffer = true,
            desc = "Make go program.",
        })
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
        opt.makeprg = "rustc --cfg chegoryu -O -o %< %"
        keymap.set("n", "<F5>", get_run_command("$(realpath %<)"), {
            buffer = true,
            desc = "Run rust program.",
        })
        keymap.set("n", "<F9>", "<cmd>make!<CR>", {
            buffer = true,
            desc = "Make rust program.",
        })
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
        keymap.set("n", "<F5>", get_run_command("mono $(realpath %<)"), {
            buffer = true,
            desc = "Run C# program.",
        })
        keymap.set("n", "<F9>", "<cmd>make<CR>", {
            buffer = true,
            desc = "Make C# program.",
        })
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
        opt.makeprg = "source_file=$(realpath %) && "
            .. "class_name=$(basename %<) && "
            .. "mkdir -p $(dirname $source_file)/classes/$class_name && "
            .. "cd $(dirname $source_file)/classes/$class_name && "
            .. "javac $source_file -d . && "
            .. "jar -c -f ../../$class_name.jar -e $class_name *.class"

        keymap.set("n", "<F5>", get_run_command("java -jar $(realpath %<.jar)"), {
            buffer = true,
            desc = "Run java program.",
        })
        keymap.set("n", "<F9>", "<cmd>make<CR>", {
            buffer = true,
            desc = "Make java program.",
        })
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
        keymap.set("n", "<F5>", get_run_command("java -jar $(realpath %<.jar)"), {
            buffer = true,
            desc = "Run kotlin program.",
        })
        keymap.set("n", "<F9>", "<cmd>make<CR>", {
            buffer = true,
            desc = "Make kotlin program.",
        })
    end,
})
