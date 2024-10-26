return {
  'goolord/alpha-nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local startify = require 'alpha.themes.startify'
    startify.file_icons.provider = 'devicons'
    require('alpha').setup(require('alpha.themes.theta').config)
  end,
}

-- return {
--     'goolord/alpha-nvim',
--     config = function ()
--         require'alpha'.setup(require'alpha.themes.dashboard'.config)
--     end
-- };
