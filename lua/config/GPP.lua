local GPP = {}

function GPP.Run()
    vim.keymap.set("n", "<F5>", function()
	  local filePath = vim.fn.expand("%:p")
	  local output = vim.fn.expand("%:p:r") .. ".exe"
	  vim.cmd('term g++ "' .. filePath .. '" -o "' .. output .. '" && "' .. output .. '"')
	  end, { noremap = true, silent = true })

end

return GPP
