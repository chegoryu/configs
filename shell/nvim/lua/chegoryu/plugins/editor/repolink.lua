return {
    "9seconds/repolink.nvim",
    keys = {
        { "<leader>rl", "<cmd>RepoLink!<CR>", mode = { "n", "v" }, desc = "Copy repository link to buffer." },
    },
    dependencies = {
        -- For custom URL builders.
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local config = require("chegoryu.core.config")
        local repolink = require("repolink")

        local custom_url_builders = {}
        if config.IS_PINELY then
            local plenary_async = require("plenary.async")
            local plenary_job = require("plenary.job")

            local convert_repo_commit_hash_impl = (function()
                return plenary_async.wrap(function(commit_hash, target_repo, callback)
                    local job = plenary_job:new({
                        command = "pinus",
                        args = {
                            "hashmonger",
                            "buy",
                            "--repo",
                            target_repo,
                            "--hash",
                            commit_hash,
                        },
                        enable_recording = true,
                    })

                    job:after_success(function()
                        local result_hash = job:result()[1]
                        callback(result_hash, nil)
                    end)
                    job:after_failure(function()
                        callback(
                            nil,
                            "Can not convert current repo commit hash "
                                .. commit_hash
                                .. " to "
                                .. target_repo
                                .. " repo commit hash"
                        )
                    end)

                    -- 10 seconds.
                    job:sync(10000)
                end, 3)
            end)()

            local function convert_repo_and_commit_hash_if_needed(path, commit_hash, current_repo)
                local target_repo = nil
                for _, path_with_repo in ipairs(config.PINELY_REPO_PATHS) do
                    if string.match(path, path_with_repo.path) then
                        target_repo = path_with_repo.repository
                        break
                    end
                end
                if not target_repo or target_repo == current_repo then
                    return current_repo, commit_hash, nil
                end

                local sender, receiver = plenary_async.control.channel.mpsc()

                plenary_async.run(function()
                    local converted_commit_hash, err = convert_repo_commit_hash_impl(commit_hash, target_repo)
                    if err ~= nil then
                        sender.send({ error = err })
                    else
                        sender.send({ commit_hash = converted_commit_hash })
                    end
                end)

                local hash_resolve_result = {}
                plenary_async.void(function()
                    for k, v in pairs(receiver.recv()) do
                        hash_resolve_result[k] = v
                    end
                end)()

                if hash_resolve_result.error ~= nil then
                    return hash_resolve_result.error
                end

                return target_repo, hash_resolve_result.commit_hash, nil
            end

            custom_url_builders[config.PINELY_GIT_HOST] = function(args)
                local url = "https://%s/projects/%s/repos/%s/browse/%s?until=%s#%s"

                local anchor = tostring(args.start_line)
                if args.start_line ~= args.end_line then
                    anchor = anchor .. "-" .. tostring(args.end_line)
                end

                local repository, commit_hash, err =
                    convert_repo_and_commit_hash_if_needed(args.path, args.commit_hash, args.host_data.repository)
                if err ~= nil then
                    return err
                end

                return string.format(url, args.host, args.host_data.project, repository, args.path, commit_hash, anchor)
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
