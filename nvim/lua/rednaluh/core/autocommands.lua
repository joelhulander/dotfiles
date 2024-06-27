vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd({"CmdlineEnter"}, {
    callback = function()
        vim.o.cmdheight = 1
    end,
})

vim.api.nvim_create_autocmd({"CmdlineLeave"}, {
    callback = function()
        vim.defer_fn(function()
            if vim.o.cmdheight ~= 0 then
                vim.o.cmdheight = 0
            end
        end, 1000)  -- Delay of 1000ms
    end,
})
