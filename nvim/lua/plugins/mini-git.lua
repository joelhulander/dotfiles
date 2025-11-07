return {
	'echasnovski/mini-git',
	enabled = true,
	version = false,
	main = 'mini.git',
	config = function()
		require('mini.git').setup(
			{
				command = {
					split = 'vertical'
				}
			}
		);
	end
}

