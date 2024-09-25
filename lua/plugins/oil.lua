return {
  'stevearc/oil.nvim',
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local oil = require("oil")
    oil.setup({
      use_default_keymaps = false,
      view_options = {
        show_hidden = true,
      },
      -- I'm not using default keymaps, because I want to discard some (commented out)
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        -- ["<C-s>"] = {
        -- 	"actions.select",
        -- 	opts = { vertical = true },
        -- 	desc = "Open the entry in a vertical split",
        -- },
        -- ["<C-h>"] = {
        -- 	"actions.select",
        -- 	opts = { horizontal = true },
        -- 	desc = "Open the entry in a horizontal split",
        -- },
        -- ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
        -- ["<C-p>"] = "actions.preview",
        -- ["<C-c>"] = "actions.close",
        -- ["<C-l>"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        -- ["g\\"] = "actions.toggle_trash",
      },
    })

    vim.keymap.set("n", "<leader>ex", function()
      oil.open()
    end)
  end
}
