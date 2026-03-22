return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'master', -- Add this line!
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "lua", "ruby", "tsx", "typescript", "vim", "html", "javascript", 
        "query", "vimdoc", "bash", "c", "css", "csv", "json", 
        "markdown", "php", "powershell", "python"
      },
      auto_install = false,
    })
  end
}
