local setup, template = pcall(require, "template")
if not setup then
    return
end

template.setup({
    temp_dir = "~/.templates",
})
