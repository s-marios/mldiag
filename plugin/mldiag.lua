if vim.g.loaded_mldiag == 1 then
	return
end
vim.g.loaded_mldiag = 1

local mldiag = require("mldiag")

mldiag.init()
