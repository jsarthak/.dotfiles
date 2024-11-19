return {
	{ -- Fuzzy Finder (files, lsp, etc)
		"nvim-telescope/telescope.nvim",
		-- event = 'VimEnter',
		branch = "0.1.x",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"joshmedeski/telescope-smart-goto.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			"nvim-lua/plenary.nvim",
			"nanotee/zoxide.vim",
			"debugloop/telescope-undo.nvim",
			"nvim-telescope/telescope-live-grep-args.nvim",
			"nvim-telescope/telescope-fzy-native.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},

			"nvim-lua/plenary.nvim",
			{ -- If encountering errors, see telescope-fzf-native README for installation instructions
				"nvim-telescope/telescope-fzf-native.nvim",

				-- `build` is used to run some command when the plugin is installed/updated.
				-- This is only run then, not every time Neovim starts up.
				build = "make",

				-- `cond` is a condition used to determine whether this plugin should be
				-- installed and loaded.
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },

			-- Useful for getting pretty icons, but requires a Nerd Font.
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		config = function()
			-- Telescope is a fuzzy finder that comes with a lot of different things that
			-- it can fuzzy find! It's more than just a "file finder", it can search
			-- many different aspects of Neovim, your workspace, LSP, and more!
			--
			-- The easiest way to use Telescope, is to start by doing something like:
			--  :Telescope help_tags
			--
			-- After running this command, a window will open up and you're able to
			-- type in the prompt window. You'll see a list of `help_tags` options and
			-- a corresponding preview of the help.
			--
			-- Two important keymaps to use while in Telescope are:
			--  - Insert mode: <c-/>
			--  - Normal mode: ?
			--
			-- This opens a window that shows you all of the keymaps for the current
			-- Telescope picker. This is really useful to discover what Telescope can
			-- do as well as how to actually do it!

			-- [[ Configure Telescope ]]
			-- See `:help telescope` and `:help telescope.setup()`
			local open_with_trouble = require("trouble.sources.telescope").open

			-- Use this to add more results without clearing the trouble list
			local add_to_trouble = require("trouble.sources.telescope").add
			local action_layout = require("telescope.actions.layout")

			require("telescope").setup({
				-- You can put your default mappings / updates / etc. in here
				--  All the info you're looking for is in `:help telescope.setup()`
				--
				defaults = {
					vimgrep_arguments = {
						"rg",
						"-L",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
					},
					prompt_prefix = "   ",
					layout_strategy = "horizontal",
					sorting_strategy = "ascending",
					selection_strategy = "reset",
					initial_mode = "insert",
					layout_config = {
						horizontal = {
							prompt_position = "top",
							preview_width = 0.55,
							results_width = 0.8,
						},
						vertical = {
							mirror = false,
						},
						width = 0.87,
						height = 0.80,
						preview_cutoff = 120,
					},
					mappings = {
						i = {
							["<c-enter>"] = "to_fuzzy_refine",
							["<A-t>"] = open_with_trouble,
							["<A-d>"] = add_to_trouble,
							["<C-p>"] = action_layout.toggle_preview,
						},
						n = {
							["<A-t>"] = open_with_trouble,
							["<A-d>"] = add_to_trouble,
							["<C-p>"] = action_layout.toggle_preview,
						},
					},
					buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
				},
				file_sorter = require("telescope.sorters").get_fuzzy_file,
				file_ignore_patterns = { "node_modules" },
				generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
				path_display = { "truncate" },
				winblend = 0,

				pickers = {
					colorscheme = {
						enable_preview = true,
					},
				},
				-- pickers = {}
				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
						-- the default case_mode is "smart_case"
					},

					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			-- Enable Telescope extensions if they are installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")

			-- See `:help telescope.builtin`
			local builtin = require("telescope.builtin")
			local actions = require("telescope.actions")
			vim.keymap.set("n", "<leader>s?", builtin.help_tags, { desc = "Search Help" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "Search Keymaps" })
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "Search Files" })
			vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "Search Select Telescope" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "Search current Word" })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Search by Grep" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "Search Diagnostics" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "Search [R]esume" })
			vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = 'Search Recent Files ("." for repeat)' })
			vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "Find existing buffers" })
			vim.keymap.set("n", "<leader>sc", builtin.current_buffer_fuzzy_find, { desc = "Find current buffers" })
			vim.keymap.set("n", "<leader>sS", builtin.git_status, { desc = "Git status" })
			vim.keymap.set("n", "<leader>sC", builtin.git_commits, { desc = "Git commit" })
			vim.keymap.set("n", "<leader>sG", builtin.git_files, { desc = "Git file" })
			vim.keymap.set("n", "<leader>sm", builtin.man_pages, { desc = "ManPages" })
			vim.keymap.set("n", "<leader>sM", builtin.marks, { desc = "Marks" })
			vim.keymap.set("n", "<leader>sR", builtin.registers, { desc = "Registers" })

			-- Slightly advanced example of overriding default behavior and theme
			vim.keymap.set("n", "<leader>sz", function()
				-- You can pass additional configuration to Telescope to change the theme, layout, etc.
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })

			-- It's also possible to pass additional configuration options.
			--  See `:help telescope.builtin.live_grep()` for information about particular keys
			vim.keymap.set("n", "<leader>t/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[S]earch [/] in Open Files" })

			-- Shortcut for searching your Neovim configuration files
			vim.keymap.set("n", "<leader>tn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })
			vim.keymap.set("n", "<leader>tc", "<cmd>Telescope themes <CR>", { desc = "Color scheme" })
		end,
	},
}
