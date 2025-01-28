return {
	"nvimdev/indentmini.nvim",
	event = "BufEnter",
	config = function()
		require("indentmini").setup()
		vim.cmd.highlight("IndentLine guifg=#123456")
		-- Current indent line highlight
		vim.cmd.highlight("IndentLineCurrent guifg=#446677")
	end,
}
