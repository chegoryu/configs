return {
    -- Enable pinely specific things (codestyle/special python version/etc).
    IS_PINELY = os.getenv("NVIM_PINELY") ~= nil,

    -- Disable copilot.
    DIABLE_COPILOT = os.getenv("NVIM_DISABLE_COPILOT") ~= nil,
}
