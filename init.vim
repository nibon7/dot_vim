lua << EOF
local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(0, ...) end
local function win_set_option(...) vim.api.nvim_win_set_option(0, ...) end
local function set_option(...) vim.api.nvim_set_option(...) end
local function get_option(...) return vim.api.nvim_get_option(...) end
local function set_var(...) vim.api.nvim_set_var(...) end

-- Show line numbers
win_set_option('number', true)

-- Highlight search
set_option('hlsearch', true)

-- Incremental search
set_option('incsearch', true)

-- Show matching bracket
set_option('showmatch', true)

-- Ignore case in search patterns
set_option('ignorecase', true)

-- Set completeopt to have a better completion experience
set_option('completeopt', 'menuone,noinsert,noselect')

-- Avoid showing message extra message when using completion
local shortmess = get_option('shortmess')
if shortmess then
  shortmess = shortmess..'c'
else
  shortmess='c'
end
set_option('shortmess', shortmess)

-- Format rust code on save
set_var('rustfmt_autosave', 1)

-- Color scheme
require('zephyr')

-- Treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = { 'bash', 'c', 'cpp', 'go', 'json', 'lua', 'python', 'rust', 'toml', 'yaml' },
  highlight = {
    enable = true
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = 1000,
  }
}

local lsp = require('lspconfig')
-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
local servers = { 'rust_analyzer', 'clangd' }
for _, v in ipairs(servers) do
  lsp[v].setup { on_attach=require'completion'.on_attach }
end

-- Key bindings
local opts = { noremap=true, silent=true }
buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

-- Use <Tab> and <S-Tab> to navigate through popup menu
opts['expr'] = true

local function replace_termcodes(s) return vim.api.nvim_replace_termcodes(s, true, true, true) end

function _G.smart_tab(next)
  if next then
    return vim.fn.pumvisible() ~= 0 and replace_termcodes('<C-n>') or replace_termcodes('<Tab>')
  else
    return vim.fn.pumvisible() ~= 0 and replace_termcodes('<C-p>') or replace_termcodes('<S-Tab>')
  end
end

buf_set_keymap('i', '<Tab>', 'v:lua.smart_tab(v:true)', opts)
buf_set_keymap('i', '<S-Tab>', 'v:lua.smart_tab(v:false)', opts)
EOF
