-- vim options
require "config"
-- key bindings
require "mapping"
require "utils"
-- put this in your main init.lua file ( before lazy setup )
vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46_cache/"

require "kickstart.plugins._init"
-- (method 1, For heavy lazyloaders)
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

-- (method 2, for non lazyloaders) to load all highlights at once
for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
	dofile(vim.g.base46_cache .. v)
end
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
