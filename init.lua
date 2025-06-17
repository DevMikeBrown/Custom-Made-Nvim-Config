require("config.GPP").Run()
require("config.Build").Build()
require("config.lazy")

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.wrap = false
vim.opt.relativenumber = true

vim.cmd.colorscheme("catppuccin")
require("catppuccin").setup({flavour = "macchiato"})

require("mason").setup()

require("lualine").setup()
local bufferline = require("bufferline")
bufferline.setup({
  options = {
    mode = "buffers",
    style_preset = bufferline.style_preset.default,
    themable = true,
    numbers = ordinal,
    close_command = "bdelete! %d",
    right_mouse_command = "bdelete! %d",
    middle_mouse_command = nil,
    indicator = {
      icon = '▎', -- this should be omitted if indicator style is not 'icon'
      style = 'icon',
    },
    buffer_close_icon = '󰅖',
    modified_icon = '*',
    close_icon = ' ',
    left_trunc_marker = ' ',
    right_trunc_marker = ' ',
    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    truncate_names = true, -- whether or not tab names should be truncated
    tab_size = 18,
    diagnostics ="nvim_lsp",
    diagnostics_update_on_event = true,
    color_icons = true,
    show_buffer_icons = true,
    show_buffer_close_icons = true
  }
})

-- Load LuaSnip snippets
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  performance = {
    max_view_entries = 10
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    -- Disable arrows from jumping through snippets
    ["<Down>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        fallback()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<Up>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        fallback()
      else
        fallback()
      end
    end, { "i", "s" }),

    -- Manual snippet jump (your chosen key)
    ["<M-j>"] = cmp.mapping(function()
      if cmp.visible then
        cmp.select_next_item()
      end
    end, { "i", "s" }),

    ["<M-k>"] = cmp.mapping(function()
      if cmp.visible then
        cmp.select_prev_item()
      end
    end, { "i", "s" }),

    -- Confirm
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip", max_item_count = 10 },
  },
})

-- Setup Mason and LSP
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "clangd" },
})

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("mason-lspconfig").setup()

require("lspconfig").clangd.setup({
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

require("bufferline").setup({
  options = {
    mode = "buffers",
    diagnostics = "nvim_lsp",
    separator_style = "slant",
    show_close_icon = true,
    show_buffer_close_icons = false,
    always_show_bufferline = true,
    offsets = {
      {
        filetype = "neo-tree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "center"
      }
    },
    custom_filter = function(bufnr, buflist)
      local filetype = vim.bo[bufnr].filetype
      return filetype ~= "neo-tree"
    end,
    groups = {
      items = {
        require("bufferline.groups").builtin.pinned:with({ icon = "📌" }), -- show pinned buffers
      },
    },
  }
})

require("neo-tree").setup({
  
  close_if_last_window = true,
  popup_border_style = "rounded",
  enable_git_status = true,
  enable_diagnostics = true,
  sources = {
    "filesystem",
    "buffers",
    "git_status",
  },
  source_selector = {
  winbar = true,         -- show tabs in the top bar
  statusline = false,    -- disable in statusline
  show_scrolled_off_parent_node = true,
  },

  filesystem = {
    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = true,
    },
  },
})

vim.g.mapleader = ' '

vim.keymap.set('n', "<leader>e", ":Neotree position=left toggle source=filesystem action=show reveal<CR>", {noremap=true, silent=true})
vim.keymap.set('n', "<leader>ll", ":Lazy<CR>", {noremap=true,silent=true})

vim.keymap.set('n', "<leader>bd", ":lua require('bufdelete').bufdelete(0, true)<CR>", {noremap=true, silent=true})

vim.keymap.set('n', '<leader>ff', ":Telescope find_files<CR>", {noremap=true,silent=true})
vim.keymap.set('n', '<leader>fb', ":Telesope buffers<CR>", {noremap=true,silent=true})
vim.keymap.set('n', '<leader>mm', ":Mason<CR>", {noremap=true,silent=true})

vim.keymap.set('n', '<leader>bb', ':Neotree toggle buffers left<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>Cp', ":e ~/AppData/Local/nvim/lua/plugins<CR>", {noremap=true,silent=true})

vim.keymap.set('n', '<leader>Cf', ":e ~/AppData/Local/nvim/init.lua<CR>", {noremap=true,silent=true})
vim.keymap.set('n', '<leader>ss', ":SessionSave<CR>", {noremap=true,silent=true})
vim.keymap.set('n', '<leader>sl', ":SessionLoad ", {noremap=true,silent=true})

vim.keymap.set('n', '<C-s>', ':w<CR>', {noremap=true,silent=true})

vim.keymap.set('n', '<C-Up>',    ':resize +2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Down>',  ':resize -2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Left>',  ':vertical resize +2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Right>', ':vertical resize -2<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })

vim.keymap.set('n', '<Tab>', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>fb', ':Telescope buffers<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '[b', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })
vim.keymap.set('n', ']b', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>bb', ':enew<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>bp', ':BufferLineTogglePin<CR>', { noremap = true, silent = true })

vim.keymap.set('n', [[\]], ':split<CR>', { noremap = true, silent = true })
vim.keymap.set('n', [[|]], ':vsplit<CR>', { noremap = true, silent = true })

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "clangd" },
})

lspconfig.clangd.setup({
  capabilities = capabilities,
})

