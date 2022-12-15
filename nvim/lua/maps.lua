local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)

-- Resize with arrows
keymap("n", "<C-S-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-S-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-S-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-S-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<S-w>", ":Bdelete<CR>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Visual Block --

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
keymap("t", "<ESC>", "<Cmd>execute v:count . 'ToggleTerm'<CR>", term_opts)
-- Formating null-ls
keymap("n", "<leader>f", ":lua vim.lsp.buf.format()<CR>", opts)


-- Open telescope find_file
keymap("n", "<S-f><S-f>", ":lua require('telescope.builtin').find_files()<CR>",  opts)
keymap("n", "<S-f><S-b>", ":lua require('telescope.builtin').buffers()<CR>", opts)
keymap("n", "<S-f><S-g>", ":lua require('telescope.builtin').live_grep()<CR>", opts)

-- Python Running
keymap("n", "<F9>", ":w | TermExec cmd='python3 %'<CR>", opts)

-- hlSlens
keymap('n', 'n',[[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],opts)
keymap('n', 'N',[[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],opts)
keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], opts)
keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], opts)
keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], opts)
keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], opts)
keymap('n', '<Leader>l', ':noh<CR>', opts)
