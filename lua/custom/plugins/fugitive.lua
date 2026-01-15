return {
  'tpope/vim-fugitive',
  cmd = { 'Git', 'G', 'Gdiffsplit', 'Gread', 'Gwrite', 'Ggrep', 'GMove', 'GDelete', 'GBrowse' },
  keys = {
    { '<leader>gg', '<cmd>Git<cr>', desc = 'Git status' },
    { '<leader>gd', '<cmd>Gdiffsplit<cr>', desc = 'Git diff' },
    { '<leader>gc', '<cmd>Git commit<cr>', desc = 'Git commit' },
    { '<leader>gb', '<cmd>Git blame<cr>', desc = 'Git blame' },
  },
}
