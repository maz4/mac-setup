-- Set space bar as leader key
vim.g.mapleader = " "

-- Set 'whichwrap' option to allow 'h' and 'l' to move to previous/next line
vim.opt.whichwrap:append("h,l")

-- copy file relative path
vim.api.nvim_set_keymap(
	"n",
	"<leader>yp",
	':let @+ = fnamemodify(expand("%"), ":~:.")<CR>',
	{ noremap = true, silent = true }
)

-- close buffer
vim.api.nvim_set_keymap("n", "<leader>c", ":bd<CR>", { noremap = true, silent = true })
