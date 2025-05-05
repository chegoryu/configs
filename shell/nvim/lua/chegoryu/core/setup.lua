--------------------------------------------------------------------------------
-- General.
--------------------------------------------------------------------------------

-- Disable deprecation warnings like "Defining diagnostic signs with :sign-define or sign_define() is deprecated. Run ":checkhealth vim.deprecated" for more information".
---@diagnostic disable-next-line: duplicate-set-field
vim.deprecate = function() end
