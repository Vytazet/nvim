-- :help options
vim.opt.backup = false
vim.opt.hlsearch = false
vim.opt.timeoutlen = 500
vim.opt.scrolloff = 8
vim.opt.linebreak = true
vim.opt.swapfile = false
vim.opt.winborder = "rounded"

-- Proper tabs
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Line numbers
vim.opt.nu = true
vim.opt.rnu = true

-- Autocomplete options
vim.opt.complete = ".,o"
vim.opt.completeopt = "fuzzy,menuone,noinsert"
vim.opt.pumheight = 7

-- Extra global options
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  group = 'YankHighlight',
  callback = function()
    vim.hl.on_yank({ higroup = 'IncSearch', timeout = '200' })
  end
})
