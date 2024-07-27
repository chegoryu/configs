local is_pinely = os.getenv("NVIM_PINELY") ~= nil

local python_path = os.getenv("NVIM_PYTHON_PATH")
if python_path == nil and is_pinely then
    python_path = "/usr/bin/twix-python"
end

local clang_format_path = os.getenv("NVIM_CLANG_FORMAT_PATH")
if clang_format_path == nil and is_pinely then
    clang_format_path = "clang-format-18"
end

local clangd_path = os.getenv("NVIM_CLANGD_PATH")
if clangd_path == nil and is_pinely then
    clangd_path = "clangd-18"
elseif clangd_path == nil then
    clangd_path = "clangd"
end

return {
    -- Enable pinely specific things (codestyle/special python version/etc).
    IS_PINELY = is_pinely,
    PINELY_GIT_HOST = os.getenv("NVIM_PINELY_GIT_HOST"),

    -- Formatting.
    FORMAT_ON_SAVE_ALL = os.getenv("NVIM_FORMAT_ON_SAVE_ALL") ~= nil,

    -- Disable copilot.
    DIABLE_COPILOT = os.getenv("NVIM_DISABLE_COPILOT") ~= nil,

    -- Python options.
    USE_BLACK_FROM_PYTHON = os.getenv("NVIM_USE_BLACK_FROM_PYTHON") ~= nil,
    PYTHON_VENV_PATH = os.getenv("NVIM_PYTHON_VENV_PATH"),
    PYTHON_PATH = python_path,

    -- C++ options.
    CLANG_FORMAT_PATH = clang_format_path,
    CLANGD_PATH = clangd_path,
}
