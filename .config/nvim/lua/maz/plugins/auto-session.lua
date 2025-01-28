return {
	"rmagatti/auto-session",
	lazy = false,

	---enables autocomplete for opts
	---@module "auto-session"
	---@type AutoSession.Config
	opts = {
		suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
		-- log_level = 'debug',
		enabled = true,
		auto_save = true, -- Enables/disables auto saving session on exit
		auto_restore = true, -- Enables/disables auto restoring session on start
		auto_create = true, -- Enables/disables auto creating new session files. Can take a function that should return true/false if a new session file should be created or not
		use_git_branch = false, -- Include git branch name in session name
	},
}
