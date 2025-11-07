vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_user_command('Jq', '%!jq .', { desc = 'Parse JSON using jq'})

vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		local bufnr = vim.api.nvim_get_current_buf()
		local bufname = vim.api.nvim_buf_get_name(bufnr)

		-- Only save normal file buffers, not special buffers
		if bufname ~= "" and vim.bo[bufnr].buftype == "" then
			local cwd = vim.fn.getcwd()
			_G.last_project_buffers[cwd] = bufnr
		end
	end
})

vim.api.nvim_create_autocmd("User", {
  pattern = "ObsidianNoteEnter",
  callback = function(ev)
    vim.keymap.set("n", "<leader>ox", "<cmd>Obsidian toggle_checkbox<cr>", {
      buffer = ev.buf,
      desc = "Toggle checkbox",
    })
  end,
})

-- Auto-close terminal when process exits
vim.api.nvim_create_autocmd("TermClose", {
  group = augroup,
  callback = function()
    if vim.v.event.status == 0 then
      vim.api.nvim_buf_delete(0, {})
    end
  end,
})

-- Disable line numbers in terminal
vim.api.nvim_create_autocmd("TermOpen", {
  group = augroup,
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
  end,
})

-- Auto-resize splits when window is resized
vim.api.nvim_create_autocmd("VimResized", {
  group = augroup,
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})
