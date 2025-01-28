-- return {
-- 	"f-person/git-blame.nvim",
-- 	-- load the plugin at startup
-- 	event = "VeryLazy",
-- 	-- Because of the keys part, you will be lazy loading this plugin.
-- 	-- The plugin wil only load once one of the keys is used.
-- 	-- If you want to load the plugin at startup, add something like event = "VeryLazy",
-- 	-- or lazy = false. One of both options will work.
-- 	config = function()
-- 		local gitblame = require("gitblame")
-- 		gitblame.opts = {
-- 			-- your configuration comes here
-- 			-- for example
-- 			enabled = true, -- if you want to enable the plugin
-- 			message_template = " <summary> • <date> • <author> • <<sha>>", -- template for the blame message, check the Message template section for more options
-- 			date_format = "%m-%d-%Y %H:%M:%S", -- template for the date, check Date format section for more options
-- 			virtual_text_column = 1, -- virtual text start column, check Start virtual text at column section for more options
-- 		}
-- 	end,
-- }

return {
	"f-person/git-blame.nvim",
	config = function()
		vim.g.gitblame_enabled = 0

		-- Keybinding to toggle git blame
		vim.api.nvim_set_keymap("n", "<leader>gl", ":GitBlameToggle<CR>", { noremap = true, silent = true })

		-- Hide git blame when navigating
		local navigation_keys = { "h", "j", "k", "l", "<Up>", "<Down>", "<Left>", "<Right>" }
		for _, key in ipairs(navigation_keys) do
			vim.api.nvim_set_keymap("n", key, ":GitBlameDisable<CR>" .. key, { noremap = true, silent = true })
		end
	end,
}
