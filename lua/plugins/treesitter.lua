-- Highlight, edit, and navigate code

local languages = {
  'go',
  'lua',
  'python',
  'rust',
  'vimdoc',
  'vim',
  { parser = 'tsx', filetype = 'typescriptreact' },
  'typescript',
  'javascript',
  'css',
  'astro',
  'markdown',
  'markdown_inline',
  'sql',
  'nu',
  'bash',
  'zsh',
  'json',
  'yaml',
}

local parsers = {}
local filetypes = {}
for _, lang in ipairs(languages) do
  if type(lang) == 'string' then
    table.insert(parsers, lang)
    table.insert(filetypes, lang)
  else
    table.insert(parsers, lang.parser)
    table.insert(filetypes, lang.filetype)
  end
end

return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    config = function()
      require('nvim-treesitter').install(parsers)
      vim.api.nvim_create_autocmd('FileType', {
        pattern = filetypes,
        callback = function() vim.treesitter.start() end,
      })
    end
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    branch = 'main',
    config = function()
      require('nvim-treesitter-textobjects').setup({
        select = {
          lookahead = true,
        },
      })

      vim.keymap.set({ "x", "o" }, "af", function()
        require "nvim-treesitter-textobjects.select".select_textobject("@function.outer", "textobjects")
      end)
      vim.keymap.set({ "x", "o" }, "if", function()
        require "nvim-treesitter-textobjects.select".select_textobject("@function.inner", "textobjects")
      end)
    end
  },
}
