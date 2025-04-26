-- Kickstart: https://github.com/nvim-lua/kickstart.nvim

-- Load plugins
require("plugins.telescope")


-- Lazy loader
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


vim.opt.number = true
vim.opt.relativenumber = true
vim.cmd("syntax on")

-- Switch to 2 space tabs
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
