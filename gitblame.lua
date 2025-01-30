return {
	"f-person/git-blame.nvim",
	config = function()
		vim.g.gitblame_enabled = 0

		-- Keybinding to toggle git blame
		vim.api.nvim_set_keymap("n", "<leader>gl", ":GitBlameToggle<CR>", { noremap = true, silent = true })

		-- Hide git blame when pressing Esc
		vim.api.nvim_set_keymap("n", "<Esc>", ":GitBlameDisable<CR><Esc>", { noremap = true, silent = true })
	end,
}
