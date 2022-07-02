local set = vim.opt
local c = vim.cmd
set.shiftwidth = 2
set.number = true         -- Show numbers on the left
set.shiftwidth = 0 -- Number of spaces to use for each step of (auto)indent
set.expandtab = true      -- Use appropriate number of spaces (no so good for PHP but we can fix this in ft)
set.wrap = false         -- Wrapping sucks (except on markdown)
set.swapfile = false      -- Do not leave any backup files
set.showmatch  = true     -- Highlights the matching parenthesis
set.termguicolors = true  -- Required for some themes
set.cursorline = true     -- Highlight the current cursor line (Can slow the UI)
set.signcolumn = "yes"    -- Always show the signcolumn, otherwise it would shift the text
set.encoding = "utf-8"    -- Just in case
set.tabstop = 4       -- Tab size of 4 spaces
set.softtabstop = 4
set.cmdheight = 1
c([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])
