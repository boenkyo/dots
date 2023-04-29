vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

if vim.g.vscode then
else
  local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable',
      lazypath,
    }
  end
  vim.opt.rtp:prepend(lazypath)

  require('lazy').setup({
    { import = 'plugins' },
    { import = 'config' },
  }, {
    change_detection = {
      enabled = false,
    },
  })
end
