return {
    -- Vs-code like icons.
    "nvim-tree/nvim-web-devicons",
    config = function()
        require("nvim-web-devicons").set_icon({
            -- Fix some weird icons.
            toml = {
                icon = "",
                color = "#6d8086",
                cterm_color = "66",
                name = "Toml",
            },
            gql = {
                icon = "",
                color = "#e535ab",
                cterm_color = "199",
                name = "GraphQL",
            },
        })
    end,
}
