return {
	{
		"alexandrosalexiou/kotlin.nvim",
		ft = { "kotlin" },

		opts = {
			build_tool = "gradle",

			root_markers = {
				"settings.gradle.kts",
				"settings.gradle",
				"build.gradle.kts",
				"build.gradle",
				"gradlew",
				".git",
			},

			inlay_hints = {
				enabled = true,

				parameters = true,
				parameters_compiled = true,

				types_property = true,
				types_variable = true,

				function_return = true,
				function_parameter = true,

				lambda_return = true,
				lambda_receivers_parameters = true,

				value_ranges = true,
				kotlin_time = true,
			},

			folding = {
				enabled = true,
			},

			file_templates = {
				enabled = true,
			},
		},

		config = function(_, opts)
			require("kotlin").setup(opts)

			local map = vim.keymap.set

			-- organizes imports:
			-- - removes unused imports
			-- - sorts imports
			-- - adds missing imports when supported by kotlin-lsp
			map("n", "<leader>ko", "<cmd>kotlinorganizeimports<cr>", {
				desc = "kotlin organize imports",
			})

			-- formats current buffer using intellij/kotlin formatting rules
			-- similar to "reformat code" in intellij idea.
			-- if you're already using conform.nvim + ktlint,
			-- you may not need this mapping.
			map("n", "<leader>kf", "<cmd>kotlinformat<cr>", {
				desc = "kotlin format",
			})

			-- toggle kotlin inlay hints:
			-- examples:
			--   foo(name: "john")
			--   val count: int = 42
			--   fun getuser(): user
			map("n", "<leader>kh", "<cmd>kotlininlayhintstoggle<cr>", {
				desc = "toggle kotlin inlay hints",
			})

			-- show all callers of the symbol under cursor.
			--
			-- example:
			-- cursor on:
			--   fun calculateprice()
			--
			-- shows every location that calls calculateprice().
			--
			-- results are sent to the location list
			-- (or trouble if integrated).
			map("n", "<leader>kc", "<cmd>kotlinincomingcalls<cr>", {
				desc = "kotlin incoming calls",
			})

			-- show everything the current symbol calls.
			--
			-- example:
			-- cursor on:
			--   fun checkout()
			--
			-- shows:
			--   validatecart()
			--   calculateprice()
			--   processpayment()
			--
			-- useful for understanding execution flow.
			map("n", "<leader>kc", "<cmd>kotlinoutgoingcalls<cr>", {
				desc = "kotlin outgoing calls",
			})
		end,
	},
}
