local common = require("chegoryu.core.filetype-options.common")

--------------------------------------------------------------------------------
-- Java.
--------------------------------------------------------------------------------

common.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = {
        "*.java",
    },
    group = common.filetype_options,
    callback = function()
        common.opt.makeprg = "source_file=$(realpath %) && "
            .. "class_name=$(basename %<) && "
            .. "mkdir -p $(dirname $source_file)/classes/$class_name && "
            .. "cd $(dirname $source_file)/classes/$class_name && "
            .. "javac $source_file -d . && "
            .. "jar -c -f ../../$class_name.jar -e $class_name *.class"

        common.keymap.set("n", "<F5>", common.get_run_command("java -jar $(realpath %<.jar)"), {
            buffer = true,
            desc = "Run java program.",
        })
        common.keymap.set("n", "<F9>", "<cmd>make<CR>", {
            buffer = true,
            desc = "Make java program.",
        })
    end,
})
