local function read_package_json(path)
  local lines = vim.fn.readfile(path)

  local ok, pkg = pcall(vim.json.decode, table.concat(lines, '\n'))
  if ok and type(pkg) == 'table' then
    return pkg
  end

  return nil
end

local function package_json_uses_prettier(pkg)
  if pkg.prettier ~= nil then
    return true
  end

  for _, field in ipairs({ 'dependencies', 'devDependencies' }) do
    local deps = pkg[field]
    if type(deps) == 'table' and deps.prettier ~= nil then
      return true
    end
  end

  return false
end

-- Checks if project uses prettier. There must be either:
-- * .prettierrc file
-- * prettier defined in package.json as dependency
local function uses_prettier(bufnr)
  local root = vim.fs.root(bufnr, function(name, path)
    local is_prettier_config_file = name:match('^%.prettierrc') ~= nil or name:match('^prettier%.config%.') ~= nil
    if is_prettier_config_file then
      return true
    end

    if name == 'package.json' then
      local pkg = read_package_json(vim.fs.joinpath(path, name))
      return pkg ~= nil and package_json_uses_prettier(pkg)
    end

    return false
  end)

  return root ~= nil
end

-- Returns formatter for "web" languages. This is oxfmt, unless
-- project uses prettier as decided by `uses_prettier` function
local function web_formatter(bufnr)
  if uses_prettier(bufnr) then
    return { 'prettier' }
  end

  return { 'oxfmt' }
end

return {
  'stevearc/conform.nvim',
  config = function()
    local opts = {
      lsp_format = 'fallback',
      timeout_ms = 1000,
      notify_on_error = true,
    }

    local conform = require('conform')
    conform.setup({
      formatters_by_ft = {
        markdown = web_formatter,
        html = web_formatter,
        javascript = web_formatter,
        javascriptreact = web_formatter,
        typescript = web_formatter,
        typescriptreact = web_formatter,
        json = web_formatter,
        yaml = web_formatter,
        astro = { 'prettier' },
        askamahtml = { 'djlint_askama' },
        nix = { 'nixfmt' },
        typst = { 'typstyle' },
      },

      formatters = {
        djlint_askama = {
          inherit = 'djlint',
          prepend_args = { '--profile=askama', '--max-blank-lines', '1' },
        },
      },

      format_on_save = function()
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat then
          return
        end
        return opts
      end,
    })

    vim.keymap.set({ 'n', 'x' }, '<leader>f', function()
      conform.format(opts)
    end, { desc = '[F]ormat' })

    vim.api.nvim_create_user_command("FormatDisable", function()
      vim.g.disable_autoformat = true
    end, {
      desc = "Disable autoformat-on-save",
      bang = true,
    })

    vim.api.nvim_create_user_command("FormatEnable", function()
      vim.g.disable_autoformat = false
    end, {
      desc = "Re-enable autoformat-on-save",
    })
  end,
}
