local vc = vim.cmd
vc([[ map q :q<CR> ]])
vc([[ nmap <TAB> :BufferLineCyclePrev <CR>]])
vc([[ nmap <C-n> :NvimTreeToggle<CR>]])
vc([[ nmap ff : :Telescope find_files theme=dropdown <CR>]])
