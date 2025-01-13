return {
	"Tweekism/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	build = "cd app && yarn install",
	init = function()
		vim.g.mkdp_filetypes = { "markdown" }
		vim.g.mkdp_combine_preview = 1
		vim.g.mkdp_combine_preview_auto_refresh = 1
		vim.g.mkdp_auto_close = 0
		vim.g.mkdp_browser = 'C:/Program Files/Mozilla Firefox/firefox.exe'
		vim.g.mkdp_theme = 'light'
	end,
	ft = { "markdown" },
}
