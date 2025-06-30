local GPP = {}

function GPP.Run()
    vim.keymap.set("n", "<F5>", function()
	  local filePath = vim.fn.expand("%:p")
	  local filedir = vim.fn.expand("%:p:h")
	  local output = vim.fn.expand("%:p:r") .. ".exe"
    vim.cmd('term g++ "'..filePath..'" -o "'..output..'"')
    vim.cmd("enew")
    vim.fn.termopen({output}, {
      on_exit = function(_, code, _)
        vim.cmd("Bdelete")
      end
    })
	  end, { noremap = true, silent = true })

end

return GPP
