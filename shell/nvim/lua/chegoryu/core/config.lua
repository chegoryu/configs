local M = {}

-- Enable pinely specific things (codestyle/special python version/etc).
M.IS_PINELY = os.getenv("NVIM_PINELY") ~= nil

-- Disable copilot.
M.DIABLE_COPILOT = os.getenv("NVIM_DISABLE_COPILOT") ~= nil

return M
