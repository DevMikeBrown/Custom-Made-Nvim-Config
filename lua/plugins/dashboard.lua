return
{
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  config = function()
    local db = require("dashboard")
    db.setup({
      theme = 'doom',
      config = {
        header = {
          "                                                  ",
          "                                                  ",
          " ███████╗  ██████████╗     ██╗   ██╗██╗███╗   ███╗",
          "██╔═════╝      ██╔═══╝     ██║   ██║██║████╗ ████║",
          "██║            ██║  █████╗ ██║   ██║██║██╔████╔██║",
          "██║       ██   ██║  ╚════╝ ╚██╗ ██╔╝██║██║╚██╔╝██║",
          "╚███████╗ ╚█████╔╝          ╚████╔╝ ██║██║ ╚═╝ ██║",
          " ╚══════╝  ╚════╝            ╚═══╝  ╚═╝╚═╝     ╚═╝",
          "                                                  ",
          "        CJ's Custom Neovim Configuration          ",
          "                                                  ",
          "                                                  ",
        },
        center = {
          {
            icon = '󰥨 ',
            icon_hl = 'Title',
            desc = 'Fuzzy Find File',
            desc_hl = 'String',
            key = '<leader>ff',
            keymap = ':Telescope',
            key_hl = 'Number',
            key_format = ' %s', -- remove default surrounding `[]`
            action = 'Telescope find_files'
          },
          {
            icon = '󰢛 ',
            desc = 'Open Mason Dashboard',
            key = '<leader>mm',
            keymap = ':Mason',
            key_format = ' %s', -- remove default surrounding `[]`
            action = 'Mason'
          },
          {
            icon = ' ',
            desc = 'Open init.lua',
            key = '<leader>Cf',
            keymap = 'Config',
            key_format = ' %s',
            action = 'e ~/AppData/Local/nvim/init.lua'
          },
          {
            icon = ' ',
            desc = 'Open Plugins Folder',
            key = '<leader>Cp',
            keymap = 'Plugins',
            key_format = ' %s',
            action = 'e ~/AppData/Local/nvim/lua/plugins/'
          },
          {
            icon = ' ',
            desc = 'Session',
            keymap = 'DashBoard-Session',
            key_format = ' <leader>sl',
          },
        },
        footer = {"C++ Is The World's Best Language and Nobody's allowed to disagree"}  --your footer       
      }
    })
  end,
  dependencies = { {"nvim-tree/nvim-web-devicons"}}
}
