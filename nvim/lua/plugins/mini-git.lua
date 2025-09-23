local config = require("config").plugins

return {
	'echasnovski/mini-git',
	enabled = config.mini_git ~= false,
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

