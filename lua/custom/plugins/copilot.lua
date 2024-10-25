return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = function()
    require('copilot').setup {
      suggestion = {
        enabled = false,
        accept = false,
        auto_trigger = true,
        hide_during_completion = true,
        debounce = 75,
        keymap = {
          accept = '<Tab>',
          accept_word = false,
          accept_line = false,
          -- next = '<M-]>',
          -- prev = '<M-[>',
          -- dismiss = '<C-]>',
        },
      },
      panel = {
        enabled = false,
      },
    }
  end,
}
