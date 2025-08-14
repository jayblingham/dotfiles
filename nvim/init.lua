vim.g.loaded_netwr = 1
vim.g.loaded_netrwPlugin = 1
require("core.keymaps")
require("config.lazy")

require('neo-tree').setup({
  filesystem = {
    hijack_netrw_behavior = 'open_current',
  },
})
