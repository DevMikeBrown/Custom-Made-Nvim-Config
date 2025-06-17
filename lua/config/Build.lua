local Build = {}

function Build.Build()
    vim.keymap.set("n", "<F6>", function()
	  local filePath = vim.fn.expand("%:p")
	  local fileDir = vim.fn.expand("%:p:h:h")
	  local output = vim.fn.expand("%:p:r") .. ".exe"
	  vim.cmd("term bash | sh \""..fileDir.."/build.sh\" ")
	  end, { noremap = true, silent = true })

end

return Build
