return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local treesitter = require("nvim-treesitter.configs")
		treesitter.setup({
			ensure_installed = { "lua", "javascript", "go", "markdown", "markdown_inline" },
			sync_install = false,
			auto_install = true,
			hilight = { enable = true },
			indent = { enable = true },
		})
	end,
}
