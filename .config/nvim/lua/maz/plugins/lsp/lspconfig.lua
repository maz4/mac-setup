return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },

	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },

		{
			"mrcjkb/rustaceanvim",
			version = "^6",
		},
	},

	config = function()
		require("mason-lspconfig")

		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local keymap = vim.keymap

		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Rust
		vim.g.rustaceanvim = {
			server = {
				capabilities = capabilities,
			},
		}

		-- golangci-lint
		vim.lsp.config("golangci_lint_ls", {
			cmd = { "golangci-lint-langserver" },
			filetypes = { "go", "gomod" },
			root_markers = { "go.mod", ".git" },

			init_options = {
				command = {
					"golangci-lint",
					"run",
					"--output.json.path",
					"stdout",
					"--show-stats=false",
					"--issues-exit-code=1",
				},
			},

			capabilities = capabilities,
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),

			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				opts.desc = "Show LSP references"
				keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)

				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", function()
					vim.diagnostic.jump({ count = -1, float = true })
				end, opts)

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", function()
					vim.diagnostic.jump({ count = 1, float = true })
				end, opts)

				opts.desc = "Show documentation"
				keymap.set("n", "K", vim.lsp.buf.hover, opts)

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", "<cmd>LspRestart<CR>", opts)

				-- Rust-specific actions
				if vim.bo[ev.buf].filetype == "rust" then
					keymap.set("n", "<C-Space>", function()
						vim.cmd.RustLsp("hover", "actions")
					end, { buffer = ev.buf, desc = "Rust Hover Actions" })

					keymap.set("n", "<leader>a", function()
						vim.cmd.RustLsp("codeAction")
					end, { buffer = ev.buf, desc = "Rust Code Actions" })
				end
			end,
		})

		vim.diagnostic.config({
			underline = true,
			update_in_insert = false,

			virtual_text = {
				spacing = 4,
				source = "if_many",
				prefix = "●",
			},

			severity_sort = true,

			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
		})

		local servers = {
			astro = {
				filetypes = { "astro" },
			},

			ts_ls = {},
			html = {},
			cssls = {},
			tailwindcss = {},
			gopls = {},
			biome = {},

			kotlin_lsp = {},

			graphql = {
				filetypes = {
					"graphql",
					"gql",
					"typescriptreact",
					"javascriptreact",
				},
			},

			emmet_ls = {
				filetypes = {
					"html",
					"typescriptreact",
					"javascriptreact",
					"css",
					"sass",
					"scss",
					"less",
				},
			},

			lua_ls = {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},

						completion = {
							callSnippet = "Replace",
						},
					},
				},
			},

			prismals = {
				filetypes = { "prisma" },

				settings = {
					prisma = {
						diagnostics = {
							globals = { true },
						},

						format = {
							enabled = true,
						},
					},
				},
			},
		}

		for server, cfg in pairs(servers) do
			cfg.capabilities = vim.tbl_deep_extend("force", {}, capabilities, cfg.capabilities or {})

			vim.lsp.config(server, cfg)
			vim.lsp.enable(server)
		end

		vim.lsp.enable("golangci_lint_ls")
	end,
}
