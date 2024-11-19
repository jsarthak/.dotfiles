local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- [[ Basic Keymaps ]]
--  See `:help map()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
-- map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("n", "<leader>-", "<cmd>Oil <CR>", { desc = "Open parent directory" })

-- Create a new buffer
map("n", "<leader>b", "<cmd> enew <CR>", { desc = "new buffer" })

map("n", "<leader>u", "<cmd> Telescope undo<CR>", { desc = "Telescope Undo" })
-- Toggle comment
map("n", "<leader>/", function()
	require("Comment.api").toggle.linewise.current()
end, { desc = "Toggle comment line" })
map("n", "<leader>cb", function()
	require("Comment.api").toggle.blockwise.current()
end, { desc = "Toggle comment block" })

map(
	"v",
	"<leader>/l",
	"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
	{ desc = "Toggle comment line" }
)
map(
	"v",
	"<leader>/b",
	"<ESC><cmd>lua require('Comment.api').toggle.block(vim.fn.visualmode())<CR>",
	{ desc = "Toggle comment block" }
)
-- line numbers
map("n", "<leader>nn", "<cmd> set nu! <CR>", { desc = "Toggle line number" })
map("n", "<leader>nr", "<cmd> set rnu! <CR>", { desc = "Toggle relative number" })
-- TIP: Disable arrow keys in normal mode
map("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
map("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
map("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
map("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

map("n", "<leader>wK", "<cmd>WhichKey<CR>", { desc = "Which-Key all keymaps" })
map("n", "<leader>wk", function()
	local input = vim.fn.input("WhichKey: ")
	vim.cmd("WhichKey" .. input)
end, { desc = "Which-Key query lookup" })
map("n", "<leader>gs", "<cmd>Git status<CR>", { desc = "Git status" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
map("n", "<S-tab>", function()
	require("nvchad.tabufline").prev()
end, opts)
map("n", "<tab>", function()
	require("nvchad.tabufline").next()
end, opts)
map("n", "<leader>q", function()
	require("nvchad.tabufline").close_buffer()
end, opts)

map("n", "<A-j>", "<cmd>:m .+1<CR>==", opts)
map("n", "<A-k>", "<cmd>:m .-2<CR>==", opts)
map("i", "<A-j>", "<ESC><cmd>:m .+1<CR>==gi", opts)
map("i", "<A-k>", "<ESC><cmd>:m .-2<CR>==gi", opts)
-- map("v", "<A-j>", "<ESC><cmd>:m '<+1<CR>gv=gv", opts)
-- map("v", "<A-k>", "<ESC><cmd>:m '<-2<CR>gv=gv", opts)
map("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
map("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)
map("n", "<leader>cc", function()
	local ok, start = require("indent_blankline.utils").get_current_context(
		vim.g.indent_blankline_context_patterns,
		vim.g.indent_blankline_use_treesitter_scope
	)

	if ok then
		vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
		vim.cmd([[normal! _]])
	end
end, { desc = "Jump to current context" })
-- greatest remap ever
map("x", "<leader>p", [["_dP]])

map("n", "<leader>xx", "<cmd>!chmod +x %<CR>", { silent = true })
map("i", "<C-c>", "<Esc>", opts)
-- next greatest remap ever : asbjornHaland
map({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "Q!", "<nop>")
vim.keymap.set("n", "Wq", "<nop>")
map("n", "<leader>Y", [["+Y]])
map("n", "<leader>fa", "<cmd> lua require('fzf-lua').files() <CR>", { desc = "FZF find files" })
map("n", "<leader>ff", "<cmd> lua require('fzf-lua').files() <CR>", { desc = "FZF find files" })
map("n", "<leader>fq", "<cmd> lua require('fzf-lua').quickfix() <CR>", { desc = "FZF quickfix" })
map("n", "<leader>fb", "<cmd> lua require('fzf-lua').buffers() <CR>", { desc = "FZF find buffers" })
map("n", "<leader>fZ", "<cmd> lua require('fzf-lua').lgerp_curbuf() <CR>", { desc = "FZF Live grep current buffer" })
map("n", "<leader>fd", "<cmd> lua require('fzf-lua').oldfiles() <CR>", { desc = "FZF opened files history" })
map("n", "<leader>fm", "<cmd> lua require('fzf-lua').marks() <CR>", { desc = "FZF marks" })
map("n", "<leader>fw", "<cmd> lua require('fzf-lua').live_grep() <CR>", { desc = "FZF live grep" })
map("n", "<leader>fg", "<cmd> lua require('fzf-lua').git_Commits() <CR>", { desc = "FZF Git commits" })
map("n", "<leader>fG", "<cmd> lua require('fzf-lua').git_bcommits() <CR>", { desc = "FZF Git commits" })
map("n", "<leader>fs", "<cmd> lua require('fzf-lua').git_status() <CR>", { desc = "FZF Git commits" })
map("n", "<leader>fp", "<cmd> lua require('fzf-lua').manpages() <CR>", { desc = "FZF Manpages" })
