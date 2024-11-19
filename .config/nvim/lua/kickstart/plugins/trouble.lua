return {
	{
		"folke/trouble.nvim",
		opts = {
		}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>tt",
				function()
					require("trouble").toggle()
				end,
				desc = "Trouble toggle",
			},
			{
				"[t",
				"<cmd> cnext<CR>",
				desc = "Trouble next"
			},

			{
				"]t",
				"<cmd> cprev<CR>",
				desc = "Touble previous",
			},
		},
	},
}
