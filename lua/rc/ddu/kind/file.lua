local ddu = require('lib.ddu')

ddu.map('file', {
  { '<C-s>', ddu.item_action('open', { command = 'split' }) },
  { '<C-v>', ddu.item_action('open', { command = 'vsplit' }) },
  { '<M-r>', ddu.item_action('rename') },
  { '<M-d>', ddu.item_action('delete') },
  { '<M-n>', ddu.item_action('newFile') },
})
