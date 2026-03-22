return {
  {
    "tiagovla/tokyodark.nvim",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "tokyodark"
    end
  },
    {
    "nvim-lualine/lualine.nvim",
        dependencies = {
          "nvim-tree/nvim-web-devicons", -- imports icon dependency
        },
        opts = {
          theme = "tokyodark", -- sets the lualine theme to tokyodark
      }
  },
}
