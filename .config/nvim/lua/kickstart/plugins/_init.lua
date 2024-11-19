-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
-- NOTE: Here is where you install your plugins.

require("lazy").setup({
	-- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
	-- You can easily change to a different colorscheme.
	-- Change the name of the colorscheme plugin below, and then
	-- change the command in the config to whatever the name of that colorscheme is.
	--
	-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
	--
	{
		-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
		-- used for completion, annotations and signatures of Neovim apis
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},

	require("kickstart.plugins.nv"),
	-- or just use Telescope themes
	-- require 'kickstart.plugins.lualine',
	-- require 'kickstart.plugins.colorscheme',
	-- require 'kickstart.plugins.tabline', -- for tabs
	-- require 'kickstart.plugins.neo-tree',
	require("kickstart.plugins.nvterm"), -- nvim terminal
	require("kickstart.plugins.gitsigns"), -- git signs
	require("kickstart.plugins.oil"), -- file browser
	require("kickstart.plugins.which-key"), -- key map help
	require("kickstart.plugins.lspconfig"), -- language server
	require("kickstart.plugins.transparent"), -- for transparency
	require("kickstart.plugins.noice"), -- for search and command line prompt
	require("kickstart.plugins.fzf-lua"), -- for fzf search
	require("kickstart.plugins.auto-session"),
	require("kickstart.plugins.conform"),
	require("kickstart.plugins.cmp"),
	require("kickstart.plugins.comment"),
	require("kickstart.plugins.telescope"),
	require("kickstart.plugins.indent_line"),
	require("kickstart.plugins.lint"),
	require("kickstart.plugins.autopairs"),
	require("kickstart.plugins.treesitter"),
	require("kickstart.plugins.trouble"),
	require("kickstart.plugins.gitsigns"), -- adds gitsigns recommend keymaps
	require("kickstart.plugins.todo-comment"), -- Highlight todo, notes, etc in comments
	require("kickstart.plugins.mini"),
	require("kickstart.plugins.other"),
	require("kickstart.plugins.undotree"),
	require("kickstart.plugins.colorizer"),
	require("kickstart.plugins.harpoon"),
	require("kickstart.plugins.cursorline"),
	{ "lukas-reineke/virt-column.nvim", opts = {} },
	{ "Bilal2453/luvit-meta", lazy = true },
	{ "preservim/vim-pencil" },

	{
		"chentoast/marks.nvim",
		config = function()
			require("marks").setup({
				default_mappings = true,
			})
		end,
	},

	-- NOTE: Plugins can also be added by using a table,
	-- with the first argument being the link and the following
	-- keys can be used to configure plugin behavior/loading/etc.
	--
	-- Use `opts = {}` to force a plugin to be loaded.
	--

	-- Here is a more advanced example where we pass configuration
	-- options to `gitsigns.nvim`. This is equivalent to the following Lua:
	--    require('gitsigns').setup({ ... })
	--
	-- See `:help gitsigns` to understand what the configuration keys do

	-- NOTE: Plugins can also be configured to run Lua code when they are loaded.
	--
	-- This is often very useful to both group configuration, as well as handle
	-- lazy loading plugins that don't need to be loaded immediately at startup.
	--
	-- For example, in the following configuration, we use:
	--  event = 'VimEnter'
	--
	-- which loads which-key before all the UI elements are loaded. Events can be
	-- normal autocommands events (`:help autocmd-events`).
	--
	-- Then, because we use the `config` key, the configuration only runs
	-- after the plugin has been loaded:
	--  config = function() ... end

	-- NOTE: Plugins can specify dependencies.
	--
	-- The dependencies are proper plugin specifications as well - anything
	-- you do for a plugin at the top level, you can do for a dependency.
	--
	-- Use the `dependencies` key to specify the dependencies of a particular plugin

	-- require 'kickstart.plugins.debug',
}, {
	ui = {
		-- If you are using a Nerd Font: set icons to an empty table which will use the
		-- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})
