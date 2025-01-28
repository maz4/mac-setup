-- Set space bar as leader key
vim.g.mapleader = " "

-- allow jump to the line above
vim.keymap.set("n", "h", function()
	if vim.fn.col(".") == 1 then
		return "k$" -- Move to the line above and to the end of it
	else
		return "h" -- Normal `h` behavior
	end
end, { expr = true, noremap = true })

-- Allow jump to the line below
vim.keymap.set("n", "l", function()
	if vim.fn.col(".") == vim.fn.col("$") - 1 then
		return "j0" -- Move to the line below and to the beginning of it
	else
		return "l" -- Normal `l` behavior
	end
end, { expr = true, noremap = true })
