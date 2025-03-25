return {
  "nvim-tree/nvim-tree.lua",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>t", "<cmd>NvimTreeToggle<cr>", desc = "Toggle tree" },
  },
  config = function()
    require("nvim-tree").setup({
      git = {},
      view = {
        adaptive_size = true,
        float = {
          enable = true,
        },
      },
    })
  end,
}
