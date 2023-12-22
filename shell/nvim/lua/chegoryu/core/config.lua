local is_pinely = os.getenv("NVIM_PINELY") ~= nil
local python_path = os.getenv("NVIM_PYTHON_PATH")

if python_path == nil and is_pinely then
    python_path = "/usr/bin/twix-python"
end

return {
    -- Enable pinely specific things (codestyle/special python version/etc).
    IS_PINELY = is_pinely,

    -- Disable copilot.
    DIABLE_COPILOT = os.getenv("NVIM_DISABLE_COPILOT") ~= nil,

    -- Python options.
    PYTHON_VENV_PATH = os.getenv("NVIM_PYTHON_VENV_PATH"),
    PYTHON_PATH = python_path,
}
