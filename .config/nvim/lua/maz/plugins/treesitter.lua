-- Treesitter setup for nvim 0.12.4 and up
-- This treesitter requiers tree-sitter-cli installed via brew
return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	branch = "main",
	lazy = false,
	config = function()
		local treesitter = require("nvim-treesitter")
		treesitter.setup({
			install_dir = vim.fn.stdpath("data") .. "/site",
		})
		treesitter
			.install({
				"lua",
				"astro",
				"typescript",
				"javascript",
				"go",
				"markdown",
				"markdown_inline",
				"prisma",
				"tsx",
				"html",
				"rust",
				"kotlin",
			})
			:wait(300000) -- wait max. 5 minutes
	end,
}
