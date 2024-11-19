return {
	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				-- other stuff
				background_colour = "#000000",
				max_width = "60",
				render = "minimal",
				timeout = 2000,
				top_down = false,
				fps = 1,
			})
		end,
	},
}
