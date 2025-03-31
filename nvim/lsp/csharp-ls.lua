return {
	cmd = { "csharp-ls" },
	filetypes = {"cs", "razor", "csproj", "fs", "fsproj"},
	init_options = { AutomaticWorkspaceInit = true },
	handlers = {
		["textDocument/definition"] = require("csharpls_extended").handler,
	},
	root_markers = { "sln", "*.fsproj" },
}
