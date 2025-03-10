return {

        -- TODO COMMENTS
        { "folke/todo-comments.nvim",    opts = {} },
        -- if some code requires a module from an unloaded plugin, it will be automatically loaded.
        -- So for api plugins like devicons, we can always set lazy=true
        { "nvim-tree/nvim-web-devicons", lazy = true },
        -- MASON LANGUAGE INSTALLER
        { "williamboman/mason.nvim",     opts = {} },
        -- PLENARY
        { "nvim-lua/plenary.nvim",       lazy = true }, -- Only loads when needed by another plugin
        -- TREESITTER SYNTAX HIGHLIGHTING
        {
                "nvim-treesitter/nvim-treesitter",
                build = ":TSUpdate",
                config = function()
                        require("nvim-treesitter.configs").setup({
                                ensure_installed = "all",
                                ignore_install = { "org" },
                                highlight = { enable = true },
                                indent = { enable = true },
                                autotag = { enable = true },
                        })
                end,
        },
        -- FZF-LUA FILE FINDER
        {
                "ibhagwan/fzf-lua",
                dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional for icons
                config = function()
                        require("fzf-lua").setup({
                                fzf_bin = "fzf-tmux",
                                fzf_tmux_opts = {
                                        ["-p"] = "80%,80%",
                                },
                                fzf_colors = {
                                        ["bg"] = { "bg", "Normal" },
                                        ["fg"] = { "fg", "Normal" },
                                        ["border"] = { "fg", "Normal" },
                                },
                                winopts = {
                                        border = "rounded",
                                        height = 0.90,
                                        width = 0.95,
                                        treesitter = { enabled = true },
                                        preview = {
                                                default = "bat",
                                                wrap = "nowrap",
                                                layout = "vertical", -- Side-by-side layout
                                                vertical = "right:50%",
                                                hidden = "nohidden",
                                        },
                                },
                                fzf_opts = {
                                        ["--layout"] = "default",
                                        ["--info"] = "inline",
                                        ["--border"] = "bold",
                                        ["--ansi"] = "", -- Enable color
                                        ["--header"] = " ",
                                        ["--no-scrollbar"] = "",
                                },
                                files = {
                                        formatter = "path.filename_first",
                                },
                                buffers = { formatter = "path.filename_first" },
                                manpages = { previewer = "man_native" },
                                helptags = { previewer = "help_native" },
                                tags = { previewer = "bat_async" },
                                keymap = {
                                        builtin = {
                                                ["<C-f>"] = "preview-page-down", -- Down
                                                ["<C-b>"] = "preview-page-up", -- Up
                                        },
                                },
                        })
                end,
        },
        -- AUTO PAIR EX: {}, (), ""
        {
                "windwp/nvim-autopairs",
                event = "InsertEnter",
                config = function()
                        require("nvim-autopairs").setup({
                                check_ts = true, -- Use Treesitter to check for pairs
                                disable_filetype = { "TelescopePrompt", "vim" },
                        })

                        -- Integrate with nvim-cmp for auto-closing
                        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
                        local cmp = require("cmp")
                        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
                end,
        },

        -- Orgmode for notetaking or to-dos
        {
                "nvim-orgmode/orgmode",
                event = "VeryLazy",
                ft = { "org" },
                config = function()
                        -- Setup orgmode
                        require("orgmode").setup({
                                org_agenda_files = { "~/orgfiles/**/*" },
                                org_default_notes_file = "~/orgfiles/refile.org",
                        })

                        -- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
                        -- add ~org~ to ignore_install
                        -- require('nvim-treesitter.configs').setup({
                        --   ensure_installed = 'all',
                        --   ignore_install = { 'org' },
                        -- })
                end,
        },
}
