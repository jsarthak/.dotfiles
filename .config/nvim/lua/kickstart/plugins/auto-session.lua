return {
	{
		"rmagatti/auto-session",
		lazy = false,

		---enables autocomplete for opts
		opts = {
			suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
			-- log_level = 'debug',
			-- ⚠️ This will only work if Telescope.nvim is installed
			-- The following are already the default values, no need to provide them if these are already the settings you want.
			use_git_branch = true, -- Include git branch name in session name
			lazy_support = true, -- Automatically detect if Lazy.nvim is being used and wait until Lazy is done to make sure session is restored correctly. Does nothing if Lazy isn't being used. Can be disabled if a problem is suspected or for debugging
			session_lens = {
				load_on_setup = true, -- Initialize on startup (requires Telescope)
				theme_conf = { -- Pass through for Telescope theme options
					-- layout_config = { -- As one example, can change width/height of picker
					--   width = 0.8,    -- percent of window
					--   height = 0.5,
					-- },
				},
				previewer = false, -- File preview for session picker

				mappings = {
					-- Mode can be a string or a table, e.g. {"i", "n"} for both insert and normal mode
					delete_session = {  "n", "<leader>Sd>" },
					alternate_session = {  "n", "<leader>Sa>" },
					copy_session = { "n", "<leader>Sy" },
				},

				session_control = {
					control_dir = vim.fn.stdpath("data") .. "/auto_session/", -- Auto session control dir, for control files, like alternating between two sessions with session-lens
					control_filename = "session_control.json", -- File name of the session control file
				},
			},
		},
	},
}
