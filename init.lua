---------------------------------------------------------------------------------
-- setup autocmd
---------------------------------------------------------------------------------
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'gitcommit', 'gitrebase', 'gitconfig' },
  callback = function()
    vim.bo.bufhidden = 'delete'
  end,
})

vim.api.nvim_create_autocmd({ 'TermOpen' }, {
  pattern = '*',
  callback = function()
    vim.opt_local.number = false
  end
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    vim.opt_local.formatoptions:remove { 'r', 'o' }
  end,
})

---------------------------------------------------------------------------------
-- define filetypes
---------------------------------------------------------------------------------
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'go', 'python', 'rust' },
  callback = function()
    vim.opt_local.autoindent = true
    vim.opt_local.smartindent = true
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'c', 'vim', 'lua', 'bash', 'fish', 'zsh' },
  callback = function()
    vim.opt_local.autoindent = true
    vim.opt_local.smartindent = true
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '*.yaml.j2' },
  command = 'set filetype=yaml',
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'javascript', 'typescript', 'typescriptreact', 'javascriptreact', 'typescript.tsx', 'javascript.jsx' },
  callback = function()
    vim.opt_local.autoindent = true
    vim.opt_local.smartindent = true
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

---------------------------------------------------------------------------------
-- define keymaps
---------------------------------------------------------------------------------
vim.g.mapleader = ' '

-- Basic movement (from your init.vim)
vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true })
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true })
vim.api.nvim_set_keymap('n', ';', ':', { noremap = true })

-- Yank to system clipboard
vim.api.nvim_set_keymap('n', 'gy', '"+y', { noremap = true })
vim.api.nvim_set_keymap('v', 'gy', '"+y', { noremap = true })

-- Escape with C-j in insert mode
vim.api.nvim_set_keymap('i', '<C-j>', '<Esc>', { noremap = true })

-- Movement shortcuts
vim.api.nvim_set_keymap('n', '<S-k>', '{', { noremap = true })
vim.api.nvim_set_keymap('n', '<S-j>', '}', { noremap = true })
vim.api.nvim_set_keymap('n', '<S-h>', '^', { noremap = true })
vim.api.nvim_set_keymap('n', '<S-l>', '$', { noremap = true })
vim.api.nvim_set_keymap('v', '<S-k>', '{', { noremap = true })
vim.api.nvim_set_keymap('v', '<S-j>', '}', { noremap = true })
vim.api.nvim_set_keymap('v', '<S-h>', '^', { noremap = true })
vim.api.nvim_set_keymap('v', '<S-l>', '$', { noremap = true })

-- Window navigation
vim.api.nvim_set_keymap('n', 'wh', '<C-w>h', { noremap = true })
vim.api.nvim_set_keymap('n', 'wj', '<C-w>j', { noremap = true })
vim.api.nvim_set_keymap('n', 'wk', '<C-w>k', { noremap = true })
vim.api.nvim_set_keymap('n', 'wl', '<C-w>l', { noremap = true })
vim.api.nvim_set_keymap('n', 'wn', ':tabn<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'wp', ':tabp<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'wt', ':tabnew<CR>', { noremap = true, silent = true })

-- Jump back
vim.api.nvim_set_keymap('n', '<S-o>', '<C-o>', { noremap = true })

-- Terminal
vim.api.nvim_set_keymap('t', ';;', '<C-\\><C-n>', { noremap = true })

-- Scroll
vim.api.nvim_set_keymap('n', '<ScrollWheelUp>', '<C-Y>', { noremap = true })
vim.api.nvim_set_keymap('n', '<ScrollWheelDown>', '<C-E>', { noremap = true })

-- Quickfix navigation
vim.api.nvim_set_keymap('n', '<C-j>', ':cnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', ':cprev<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-c>', ':cclose<CR>', { noremap = true, silent = true })

-- Copy filepath
vim.api.nvim_set_keymap('n', ';c', ':let @+=expand("%:p")<CR>', { noremap = true, silent = true })

-- Use Terminal shortcut
vim.cmd([[
  autocmd TermOpen * startinsert
  function! s:Openterm() abort
    let w = winwidth(win_getid())
    let h = winheight(win_getid()) * 2.1
    if h > w
      exe 'split'
      exe 'term'
    else
      exe 'vsplit'
      exe 'term'
    endif
  endfunction
  nmap <silent> tt :<C-u>silent call <SID>Openterm()<CR>
]])

-- Clear all buffers
function clearBuffers()
  local buffers = vim.api.nvim_list_bufs()

  for _, buffer in ipairs(buffers) do
    if vim.api.nvim_buf_get_option(buffer, 'modified') then
      print('Buffer ' .. buffer .. 'has unsaved changes')
    else
      vim.api.nvim_buf_delete(buffer, { force = true })
    end
  end
end

vim.api.nvim_set_keymap('n', '<Leader>cl', ':lua clearBuffers()<cr>', { noremap = true, silent = true })

---------------------------------------------------------------------------------
-- options
---------------------------------------------------------------------------------
vim.o.encoding = 'utf-8'
vim.o.fileformat = 'unix'
vim.o.fileencoding = 'utf-8'
vim.o.mouse = 'a'
vim.o.foldenable = false
vim.o.wildmenu = true
vim.o.completeopt = 'menu,menuone,noinsert,noselect,popup'
vim.o.belloff = 'all'
vim.o.number = true
vim.o.scrolloff = 999 -- Keep the cursor centered in the screen

-- From your init.vim
vim.o.backup = false
vim.o.swapfile = false
vim.o.autoread = true
vim.o.hidden = true
vim.o.showcmd = true
vim.o.showmode = false
vim.o.showmatch = true
vim.o.virtualedit = 'onemore'
vim.o.visualbell = true
vim.o.wrapscan = true
vim.o.inccommand = 'split'
vim.o.whichwrap = 'b,s,h,l,<,>,[,]'

-- Tab and Indentation
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.expandtab = true

-- String search settings
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true

-- window split config
vim.o.splitright = true

-- statusline & tabline
vim.o.showtabline = 1
vim.o.laststatus = 3
vim.o.cmdheight = 1

-- colorscheme
vim.opt.background = 'dark'
if vim.env.TERM == 'xterm-ghostty' or vim.env.COLORTERM == 'truecolor' then
  vim.opt.termguicolors = true
end

-- cursorline highlight
vim.o.cursorline = true

-- buffer
vim.o.autoread = true
vim.o.winborder = 'rounded'

-- session
vim.o.sessionoptions = 'buffers,curdir,folds,help,tabpages,winsize,terminal,options,globals'

-- configure searching path && ignore specify directory
vim.opt.path:append(vim.fn.getcwd() .. '/**')
vim.opt.wildignore:append { '*/.git/*', '*/node_modules/*' }

-- configure netrw
vim.g.netrw_liststyle = 3

---------------------------------------------------------------------------------
-- manage plugins by vim.pack
---------------------------------------------------------------------------------
local disabled_built_ins = {
  '2html_plugin',
  'getscript',
  'getscriptPlugin',
  'gzip',
  'logipat',
  'matchit',
  'tar',
  'tarPlugin',
  'rrhelper',
  'spellfile_plugin',
  'vimball',
  'vimballPlugin',
  'zip',
  'zipPlugin',
}
for _, plugin in pairs(disabled_built_ins) do
  vim.g['loaded_' .. plugin] = 1
end

vim.pack.add({
  { src = 'https://github.com/norcalli/nvim-colorizer.lua' },
  { src = 'https://github.com/shaunsingh/nord.nvim' },
  { src = 'https://codeberg.org/evergarden/nvim.git', name='evergarden' },
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
  { src = 'https://github.com/ibhagwan/fzf-lua' },
  { src = 'https://github.com/lewis6991/gitsigns.nvim' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'master' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter-context' },
  { src = 'https://github.com/windwp/nvim-ts-autotag' },
  { src = 'https://github.com/phaazon/hop.nvim', version = 'v2' },
  { src = 'https://github.com/folke/snacks.nvim' },
  { src = 'https://github.com/dcampos/nvim-snippy' },
  { src = 'https://github.com/hrsh7th/nvim-cmp' },
  { src = 'https://github.com/hrsh7th/cmp-nvim-lsp' },
  { src = 'https://github.com/hrsh7th/cmp-path' },
  { src = 'https://github.com/hrsh7th/cmp-buffer' },
  { src = 'https://github.com/dcampos/cmp-snippy' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/tpope/vim-surround' },
  { src = 'https://github.com/tpope/vim-fugitive' },
  { src = 'https://github.com/tpope/vim-commentary' },
})

-- configure treesitter
local treesitter = require('nvim-treesitter.configs')
treesitter.setup({
  ensure_installed = { 'c', 'lua', 'vim', 'vimdoc', 'query', 'markdown', 'markdown_inline', 'go', 'rust', 'typescript' },
  ignore_install = { 'javascript' },
  sync_install = false,
  auto_install = false,
  highlight = { enable = true },
  textobjects = { enable = true },
  context = {
    enable = true,
    multiwindow = true,
  },
  indent = {
    enable = true,
  },
})

local ts_autotag = require('nvim-ts-autotag')
ts_autotag.setup({
  opts = {
    enable_close = true,
    enable_rename = true,
    enable_close_on_slash = true,
  },
})

-- configure nord colorscheme
vim.g.nord_disable_background = true
vim.cmd('colorscheme nord')
vim.cmd('hi VertSplit guifg=#4C566A guibg=NONE ctermfg=8 ctermbg=NONE')
vim.cmd('hi CursorLine guibg=NONE ctermbg=NONE gui=underline cterm=underline guisp=#3B4252')

-- configure evergarden colorscheme
-- require('evergarden').setup({
--   theme = {
--     variant = 'fall', -- 'winter'|'fall'|'spring'|'summer'
--     accent = 'green',
--   },
--   editor = {
--     transparent_background = true,
--     sign = { color = 'none' },
--     float = {
--       color = 'mantle',
--       solid_border = false,
--     },
--     completion = {
--       color = 'surface0',
--     },
--   },
-- })
-- vim.cmd('colorscheme evergarden')

-- configure fzf-lua
local fzflua = require('fzf-lua')
vim.keymap.set('n', '<C-g>', function() fzflua.files() end)
vim.keymap.set('n', '<C-p>', function() fzflua.grep() end)
-- Telescope-style keymaps from your init.vim
vim.keymap.set('n', '<leader>ff', function() fzflua.files() end)
vim.keymap.set('n', '<leader>fg', function() fzflua.live_grep() end)
vim.keymap.set('n', '<leader>fb', function() fzflua.buffers() end)
vim.keymap.set('n', '<leader>fh', function() fzflua.help_tags() end)
vim.keymap.set('n', '<Leader>fz', function() fzflua.files() end)

-- configure hop.nvim
local hop = require('hop')
hop.setup({ multi_windows = true })
vim.keymap.set('n', 'f', function() hop.hint_char1() end)

-- configure snacks.nvim
local snacks = require('snacks')
snacks.setup({
  indent = { enabled = true },
})

-- configure nvim-cmp
local cmp = require('cmp')
local snippy = require('snippy')
local opts = {
  preselect = 'item',
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },
  sources = cmp.config.sources {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'snippy' },
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-n>'] = cmp.mapping(function(original)
      if snippy.can_jump(1) then
        snippy.next()
      elseif cmp.visible() then
        cmp.select_next_item()
      else
        original()
      end
    end, { 'i', 's' }),
    ['<C-p>'] = cmp.mapping(function(original)
      if snippy.can_jump(-1) then
        snippy.previous()
      elseif cmp.visible() then
        cmp.select_prev_item()
      else
        original()
      end
    end, { 'i', 's' }),
  }),
  snippet = {
    expand = function(args)
      require 'snippy'.expand_snippet(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered({ border = 'single' }),
    documentation = cmp.config.window.bordered({ border = 'single' }),
  },
}
cmp.setup(opts)

---------------------------------------------------------------------------------
-- LSP settings
---------------------------------------------------------------------------------
vim.lsp.config['lua_ls'] = {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        pathStrict = true,
        path = { "?.lua", "?/init.lua" },
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.list_extend(vim.api.nvim_get_runtime_file("lua", true), {
          "${3rd}/luv/library",
          "${3rd}/busted/library",
          "${3rd}/luassert/library",
        }),
        checkThirdParty = "Disable",
      },
    },
  }
}

vim.lsp.enable({
  'gopls',
  'lua_ls',
  'tsgo',
  'rust_analyzer',
  'pyright',
})

-- Keymaps of LSP
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    -- Disable default keymaps
    vim.bo[ev.buf].omnifunc = nil
    vim.bo[ev.buf].tagfunc = nil
    vim.bo[ev.buf].formatexpr = nil

    -- Set Keymaps
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    local keyopts = { remap = true, silent = true }
    if client:supports_method('textDocument/implementation') then
      vim.keymap.set('n', 'gD', vim.lsp.buf.implementation, keyopts)
    end
    if client:supports_method('textDocument/definition') then
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, keyopts)
    end
    if client:supports_method('textDocument/typeDefinition') then
      vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, keyopts)
    end
    if client:supports_method('textDocument/references') then
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, keyopts)
    end
    if client:supports_method('textDocument/rename') then
      vim.keymap.set('n', 'gn', vim.lsp.buf.rename, keyopts)
    end
    if client:supports_method('textDocument/codeAction') then
      vim.keymap.set('n', '<Leader>k', vim.lsp.buf.code_action, keyopts)
    end
    -- if client:supports_method('textDocument/inlineCompletion') then
    --   vim.keymap.set('i', '<C-j>', vim.lsp.inline_completion.get, keyopts)
    -- end
  end,
})

-- Auto format on save
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    if not client:supports_method('textDocument/willSaveWaitUntil') and client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = ev.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000, async = false })
        end
      })
    end
  end
})

-- configure gitsigns.nvim
local gitsigns = require('gitsigns')
gitsigns.setup({
  current_line_blame = false,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol',
    delay = 500,
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns
    local opts = { buffer = bufnr }

    -- Blame
    vim.keymap.set('n', '<Leader>hb', gs.toggle_current_line_blame, opts)
    vim.keymap.set('n', '<Leader>hB', function() gs.blame_line({ full = true }) end, opts)

    -- Navigation
    vim.keymap.set('n', ']c', gs.next_hunk, opts)
    vim.keymap.set('n', '[c', gs.prev_hunk, opts)

    -- Actions
    vim.keymap.set('n', '<Leader>hs', gs.stage_hunk, opts)
    vim.keymap.set('n', '<Leader>hr', gs.reset_hunk, opts)
    vim.keymap.set('n', '<Leader>hp', gs.preview_hunk, opts)
  end
})

-- configure colorizer
require('colorizer').setup({
  filetypes = { '*' },
  user_default_options = {
    RGB = true,
    RRGGBB = true,
    names = false,
    css = true,
  }
})
-- configure nvim-web-devicons
require('nvim-web-devicons').setup()

-- Diagnostics
vim.diagnostic.config({
  virtual_lines = true,
})
