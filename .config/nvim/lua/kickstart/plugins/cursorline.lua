return {
	"yamatsum/nvim-cursorline",

	config = function()
		require("nvim-cursorline").setup({
			cursorline = {
				enable = true,
				timeout = 1000,
				number = false,
				hl = {underline = true}
			},
			cursorword = {
				enable = false,
				min_length = 3,
				hl = { underline = true },
			},
		})
	end,
}
