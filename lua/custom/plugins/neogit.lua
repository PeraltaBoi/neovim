return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim', -- required
    'sindrets/diffview.nvim', -- optional - Diff integration
  },
  config = true,
  -- add a leader + gg binding to open Neogit
  vim.api.nvim_set_keymap('n', '<Leader>gg', '<Cmd>Neogit<CR>', { noremap = true, silent = true }),
  -- add a leader + gb to open Telescope git_branches
  vim.api.nvim_set_keymap('n', '<Leader>gb', '<Cmd>Telescope git_branches<CR>', { noremap = true, silent = true }),
  -- add a leader + gc to open Telescope git_commits
  vim.api.nvim_set_keymap('n', '<Leader>gc', '<Cmd>Telescope git_commits<CR>', { noremap = true, silent = true }),
  -- add a leader + gs to open Telescope git_status
  vim.api.nvim_set_keymap('n', '<Leader>gs', '<Cmd>Telescope git_status<CR>', { noremap = true, silent = true }),
}
