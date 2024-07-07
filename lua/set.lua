vim.opt.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,a:blinkwait700-blinkoff400-blinkon250'

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append('@-@')


vim.opt.colorcolumn = ''

vim.opt.spelllang = 'en_us'
vim.opt.spelloptions = 'camel'
vim.opt.spellcapcheck = ''
vim.opt.spell = true

vim.diagnostic.config({
  virtual_text = true
})

vim.g.skip_ts_context_commentstring_module = true

vim.filetype.add({
  extension = {
    templ = "templ",
  },
})
