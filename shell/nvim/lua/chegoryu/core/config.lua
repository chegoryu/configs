local is_pinely = os.getenv("NVIM_PINELY") ~= nil

local file_exists = function(path)
    local file = io.open(path, "r")
    if file == nil then
        return false
    end
    io.close(file)
    return true
end

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

local pinely_private_config = {}
local pinely_private_config_file_path = os.getenv("NVIM_PINELY_PRIVATE_CONFIG_FILE_PATH")
local default_pinely_private_config_file_path = os.getenv("HOME") .. "/.config/pinely/nvim/private_config.json"
if pinely_private_config_file_path == nil and is_pinely and file_exists(default_pinely_private_config_file_path) then
    pinely_private_config_file_path = default_pinely_private_config_file_path
end

if pinely_private_config_file_path ~= nil then
    local ok, result = pcall(vim.fn.readblob, pinely_private_config_file_path)
    if not ok then
        error("failed to read pinely private config file: " .. pinely_private_config_file_path)
    else
        ok, pinely_private_config = pcall(vim.fn.json_decode, result)
        if not ok then
            error("failed to parse pinely private config file: " .. pinely_private_config_file_path)
        end
    end
end

local pinely_repo_paths = pinely_private_config["repo_paths"]
if pinely_repo_paths == nil then
    pinely_repo_paths = {}
end

return {
    -- Enable pinely specific things (codestyle/special python version/etc).
    IS_PINELY = is_pinely,
    PINELY_GIT_HOST = os.getenv("NVIM_PINELY_GIT_HOST"),
    PINELY_REPO_PATHS = pinely_repo_paths,

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
