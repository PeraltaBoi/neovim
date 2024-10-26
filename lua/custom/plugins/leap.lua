return {
  'ggandor/leap.nvim',
  config = function()
    require('leap').create_default_mappings()
    require('leap').opts.equivalence_classes = { ' \t\r\n', '([{', ')]}', '\'"`' }
    require('leap.user').set_repeat_keys('<enter>', '<backspace>')
  end,
}
