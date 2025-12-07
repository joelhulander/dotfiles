return {
    'echasnovski/mini.nvim',
    version = false,
    enabled = true,
    config = function ()
        require('mini.diff').setup(
            {
                view = {
                    style = 'sign',
                },
                mappings = {
                    apply = '<leader>ga',
                    reset = '<leader>gr',

                    textobject = '<leader>gh',

                    goto_first = '<leader>[H',
                    goto_prev = '<leader>[h',
                    goto_next = '<leader>]h',
                    goto_last = '<leader>]H',
                },
            }
        );

        require('mini.diff').setup(
            {
                view = {
                    style = 'sign',
                },
                mappings = {
                    apply = '<leader>ga',
                    reset = '<leader>gr',

                    textobject = '<leader>gh',

                    goto_first = '<leader>[H',
                    goto_prev = '<leader>[h',
                    goto_next = '<leader>]h',
                    goto_last = '<leader>]H',
                },
            }
        );

        require('mini.git').setup(
            {
                command = {
                    split = 'vertical'
                }
            }
        );

        require('mini.ai').setup()
        require('mini.pairs').setup()
        require('mini.indentscope').setup()
        require('mini.statusline').setup()
        require('mini.icons').setup()

    end
}
