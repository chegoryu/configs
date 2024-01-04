return {
    "9seconds/repolink.nvim",
    keys = {
        { "<leader>rl", "<cmd>RepoLink!<CR>", desc = "Copy repository link to buffer." },
    },
    config = function()
        local config = require("chegoryu.core.config")
        local repolink = require("repolink")

        local custom_url_builders = {}
        if config.IS_PINELY then
            custom_url_builders[config.PINELY_GIT_HOST] = function(args)
                local url = "https://%s/projects/%s/repos/%s/browse/%s?until=%s#%s"

                local anchor = tostring(args.start_line)
                if args.start_line ~= args.end_line then
                    anchor = anchor .. "-" .. tostring(args.end_line)
                end

                return string.format(
                    url,
                    args.host,
                    args.host_data.project,
                    args.host_data.repository,
                    args.path,
                    args.commit_hash,
                    anchor
                )
            end
        end

        repolink.setup({
            use_full_commit_hash = true,
            custom_url_parser = function(remote_url)
                if config.IS_PINELY then
                    local pinelygit_pattern = "^(.-)git@([^:]+):([^/]+)/([^/]+)/(.+).git$"
                    local _, host, _, project, repository = string.match(remote_url, pinelygit_pattern)
                    if host then
                        return host,
                            {
                                project = project,
                                repository = repository,
                            },
                            nil
                    end
                end

                return "", "", "Unkown remote URL format: " .. remote_url
            end,
            url_builders = custom_url_builders,
        })
    end,
}
