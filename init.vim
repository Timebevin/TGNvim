"
""  插件列表
""
call plug#begin()
""  补全插件
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
""  主题插件
Plug 'ful1e5/onedark.nvim'
""  状态栏插件
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
""  git插件
Plug 'tpope/vim-fugitive'
"" 多光标插件
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
""  选择窗口插件
Plug 't9md/vim-choosewin'
"" 终端
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
"" 格式化
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'nvim-lua/plenary.nvim'
"" 文件树
Plug 'kyazdani42/nvim-tree.lua'
""  文件树图标
Plug 'kyazdani42/nvim-web-devicons'
""  快速移动
Plug 'easymotion/vim-easymotion'
"" 快速移动类似easymotion
Plug 'phaazon/hop.nvim'
"" 代码高亮
Plug 'nvim-treesitter/nvim-treesitter'
"" Plug 'nvim-lua/plenary.nvim'
"" 模糊搜索
Plug 'nvim-telescope/telescope.nvim'
"" 启动页
Plug 'glepnir/dashboard-nvim'
"" nvim-project
Plug 'ahmedkhalf/project.nvim'
"" 代码对齐线
Plug 'yggdroot/indentline'
""rust
Plug 'rust-lang/rust.vim'
""注释插件
Plug 'numToStr/Comment.nvim'
""注释插件
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
"" mason插件
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
""lsp增强
Plug 'glepnir/lspsaga.nvim', { 'branch': 'main' }
""cmp
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
""lspUI美化
Plug 'onsails/lspkind-nvim'
"" git插件
Plug 'kdheepak/lazygit.nvim'
""图片显示插件
Plug 'samodostal/image.nvim'
Plug 'm00qek/baleia.nvim', { 'tag': 'v1.2.0' }
call plug#end()

""
""  基础配置项
""
set number
set encoding=UTF-8
set signcolumn=number
"" 将tab扩展成空格
set ts=2
set shiftwidth=4
set backspace=2    " more powerful backspacing
set wrap
set timeoutlen=500
set splitbelow
set splitright
set pumheight=10
set wildmenu
"" 搜索不高亮
set nohlsearch
""leaders键配置
let mapleader=","
nmap q :q<CR>
nmap w :w<CR>
nmap <C-j> 4j<CR>
nmap <C-k> 4k<CR>
imap <C-h> <ESC>I
imap <C-l> <ESC>A
""向下移动一行
nmap <space>n :m -2<CR>
""向上移动一行
nmap <space>m :m +1<CR>
""设置切换Buffer快捷键"
nnoremap <TAB> :bn<CR>
nnoremap <leader>c :bd<CR>
""终端
""打开或关闭所有终端
nnoremap <C-a> :ToggleTermToggleAll<CR> 
""rust
let g:rustfmt_autosave = 1
""缩进线Yggdrootp/indentline
let g:indentLine_fileTypeExclude = ['dashboard']
let g:indentLine_char_list = ['¦']


""快捷键配置
""neo-tree文件树
""noremap <leader>m :Neotree<CR>
noremap <leader>g :Neotree git_status<CR>

""
""  主题
""
let g:everforest_better_performance = 1
""colorscheme everforest
colorscheme onedark
""let g:everforest_background = 'soft'
let g:rehash256 = 1
let g:molokai_original = 1

""git插件设置
" setup mapping to call :LazyGit
nnoremap <silent> <leader>gg :LazyGit<CR>
let g:lazygit_floating_window_winblend = 0 " transparency of floating window
let g:lazygit_floating_window_scaling_factor = 0.9 " scaling factor for floating window
let g:lazygit_floating_window_corner_chars = ['╭', '╮', '╰', '╯'] " customize lazygit popup window corner characters
let g:lazygit_floating_window_use_plenary = 0 " use plenary.nvim to manage floating window if available
let g:lazygit_use_neovim_remote = 1 " fallback to 0 if neovim-remote is not installed
let g:lazygit_use_custom_config_file_path = 0 " config file path is evaluated if this value is 1
let g:lazygit_config_file_path = '' " custom config file path

let s:baleia = luaeval("require('baleia').setup { }")
command! BaleiaColorize call s:baleia.once(bufnr('%'))

let s:baleia = luaeval("require('baleia').setup { }")
autocmd BufWinEnter my-buffer call s:baleia.automatically(bufnr('%'))
let g:conjure#log#strip_ansi_escape_sequences_line_limit = 0

lua << EOF
-- 依赖ascii-image-converter
require('image').setup {
  render = {
    min_padding = 5,
    show_label = true,
    use_dither = true,
    foreground_color = true,
    background_color = true
  },
  events = {
    update_on_nvim_resize = true,
  },
}

--注释插件Comment
require('Comment').setup()

--注释插件
local ft = require('Comment.ft')
require'nvim-treesitter.configs'.setup {
  context_commentstring = {
    enable = true,
		pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
  }
}

--nvim-lsp
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<leader>k', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
  debounce_text_changes = 150,
}
local lspconfig = require('lspconfig')
local servers = {'rust_analyzer','tsserver','sumneko_lua','jdtls','vimls','volar','jsonls','emmet_ls','zk','clanged','sqlls','gopls','html','cssls' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
  }
end


--cmp
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })
  local capabilities = require('cmp_nvim_lsp').default_capabilities()


	local lspkind = require('lspkind')
		cmp.setup {
						formatting = {
						format = lspkind.cmp_format({
						mode = 'symbol_text', -- show only symbol annotations
						maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
						ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

						-- The function below will be called before any actual modifications from lspkind
						-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
						before = function (entry, vim_item)
								return vim_item
						end
						})
				}
		}


--mason
		require('mason').setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        },
				keymaps = {
            -- Keymap to expand a package
            toggle_package_expand = "<CR>",
            -- Keymap to install the package under the current cursor position
            install_package = "i",
            -- Keymap to reinstall/update the package under the current cursor position
            update_package = "u",
            -- Keymap to check for new version for the package under the current cursor position
            check_package_version = "c",
            -- Keymap to update all installed packages
            update_all_packages = "U",
            -- Keymap to check which installed packages are outdated
            check_outdated_packages = "C",
            -- Keymap to uninstall a package
            uninstall_package = "X",
            -- Keymap to cancel a package installation
            cancel_installation = "<C-c>",
            -- Keymap to apply language filter
            apply_language_filter = "<C-f>",
        },
    },
    pip = {
          -- Whether to upgrade pip to the latest version in the virtual environment before installing packages.
          upgrade_pip = false,

         -- These args will be added to `pip install` calls. Note that setting extra args might impact intended behavior
          -- and is not recommended.
          --
          -- Example: { "--proxy", "https://proxyserver" }
          install_args = {"proxy","https://proxyserver"},
      },

      -- Controls to which degree logs are written to the log file. It's useful to set this to vim.log.levels.DEBUG when
      -- debugging issues with package installations.
      log_level = vim.log.levels.INFO,

      -- Limit for the maximum amount of packages to be installed at the same time. Once this limit is reached, any further
      -- packages that are requested to be installed will be put in a queue.
      max_concurrent_installers = 4,
      -- The provider implementations to use for resolving package metadata (latest version, available versions, etc.).
      -- Accepts multiple entries, where later entries will be used as fallback should prior providers fail.
      -- Builtin providers are:
      --   - mason.providers.registry-api (default) - uses the https://api.mason-registry.dev API
      --   - mason.providers.client                 - uses only client-side tooling to resolve metadata
      providers = {
            "mason.providers.registry-api",
     },
  })
--mason-lspconfig
require('mason-lspconfig').setup({
		ensure_installed = { 
				"sumneko_lua", -- lua
				"rust_analyzer", -- rust
				"jdtls", -- java
				"tsserver", -- typescript
				"vimls", -- vim
				"volar", -- vue3
				"jsonls", -- json
				"emmet_ls", --emmet
				"clangd", -- c++ c
				"zk", -- markdown
				"sqlls", -- sql
				"gopls", -- go
				"html", -- html
				"cssls", -- css
				},
})

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end



--lsp增强

local keymap = vim.keymap.set
local saga = require('lspsaga')

saga.init_lsp_saga()

-- Lsp finder find the symbol definition implement reference
-- if there is no implement it will hide
-- when you use action in finder like open vsplit then you can
-- use <C-t> to jump back
keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })

-- Code action
keymap({"n","v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })

-- Rename
keymap("n", "gr", "<cmd>Lspsaga rename<CR>", { silent = true })

-- Peek Definition
-- you can edit the definition file in this flaotwindow
-- also support open/vsplit/etc operation check definition_action_keys
-- support tagstack C-t jump back
keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })

-- Show line diagnostics
keymap("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })

-- Show cursor diagnostics
keymap("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })

-- Diagnostic jump can use `<c-o>` to jump back
keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })

-- Only jump to error
keymap("n", "[E", function()
  require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })
keymap("n", "]E", function()
  require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })

-- Outline
keymap("n","<leader>o", "<cmd>LSoutlineToggle<CR>",{ silent = true })

-- Hover Doc
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })

-- Float terminal
keymap("n", "<A-d>", "<cmd>Lspsaga open_floaterm<CR>", { silent = true })
-- if you want to pass some cli command into a terminal you can do it like this
-- open lazygit in lspsaga float terminal
keymap("n", "<A-d>", "<cmd>Lspsaga open_floaterm lazygit<CR>", { silent = true })
-- close floaterm
keymap("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })


--代码高亮
local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
    vim.notify("没有找到 nvim-treesitter")
    return
end

treesitter.setup({
  -- 安装 language parser
  -- :TSInstallInfo 命令查看支持的语言
  ensure_installed = { "json", "html", "css", "vim", "lua", "javascript", "typescript", "tsx","vue","scss","rust" },
  -- 启用代码高亮模块
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
})
--模糊搜索
local status, telescope = pcall(require, "telescope")
if not status then
  vim.notify("没有找到 telescope")
  return
end

telescope.setup({
  defaults = {
    -- 打开弹窗后进入的初始模式，默认为 insert，也可以是 normal
    initial_mode = "insert",
    -- 窗口内快捷键
     },
  pickers = {
    -- 内置 pickers 配置
    find_files = {
      -- 查找文件换皮肤，支持的参数有： dropdown, cursor, ivy
      -- theme = "dropdown", 
    }
  },
  extensions = {
     -- 扩展插件配置
  },
})

EOF

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fo <cmd>Telescope oldfiles<cr>

""
""  coc.nvim 配置项
""
" cnoremap <c-h> <left>
" inoremap <silent><expr> <TAB>
"             \ coc#pum#visible() ? coc#pum#next(1) :
"             \ CheckBackspace() ? "\<Tab>" :
"             \ coc#refresh()
" inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
"
" inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
"             \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" function! CheckBackspace() abort
"     let col = col('.') - 1
"     return !col || getline('.')[col - 1]  =~# '\s'
" endfunction
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)
"" HopWord移动
lua require'hop'.setup()
nmap <space>hd :HopWord<CR>
nmap <space>hn :HopPattern<CR>
nmap <space>he :HopLine<CR>
""  格式化基础配置
lua local async = require "plenary.async"
lua << EOF
require("null-ls").setup({
		sources={
				require("null-ls").builtins.formatting.stylua,
				require("null-ls").builtins.diagnostics.eslint,
				require("null-ls").builtins.completion.spell,
				require("null-ls").builtins.formatting.prettier,
				require("null-ls").builtins.formatting.rustfmt,
				require("null-ls").builtins.formatting.gofmt,
		},
})
EOF
noremap <leader>f :lua vim.lsp.buf.formatting_sync()<CR>
"" toggleterm终端基础配置
lua require("toggleterm").setup{
            \open_mapping = [[<c-\>]],
            \ direction = 'horizontal',
            \ close_on_exit = true,
            \ }
""  vim-choosewin基础配置
nmap - <Plug>(choosewin)
"" vim-visual-multi配置
noremap <silent>gdi :Gdiffsplit<CR>
noremap <silent>gvs :Gvsplit<CR>
""
let g:VM_mouse_mappings = 1
nmap   <C-LeftMouse>         <Plug>(VM-Mouse-Cursor)
nmap   <C-RightMouse>        <Plug>(VM-Mouse-Word)
nmap   <M-C-RightMouse>      <Plug>(VM-Mouse-Column)
""
""  airline基础配置
""
""打开tabline功能,方便查看Buffer和切换，这个功能比较不错"
""我还省去了minibufexpl插件，因为我习惯在1个Tab下用多个buffer"
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" cache :hi calls for optimization
let g:airline_highlighting_cache = 1
" enable none extensions for optimization
" if (has("nvim"))
"     let g:airline_extensions = ['hunks', 'branch']
" else
"     let g:airline_extensions = ['hunks', 'branch', 'tabline']
" endif
let g:airline_extensions = ['branch', 'tabline']
"let g:airline#extensions#hunks#enabled=0
"let g:airline#extensions#branch#enabled=1
"let g:airline_powerline_fonts=1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

"" nvim-tree 文件树
noremap <leader>m :NvimTreeToggle<CR>
lua << EOF
local nvim_tree = require'nvim-tree'
-- 列表操作快捷键
local list_keys = {
    -- 打开文件或文件夹
  { key = {"<CR>", "o", "<2-LeftMouse>"}, action = "edit" },
  -- 分屏打开文件
  { key = "v", action = "vsplit" },
  { key = "h", action = "split" },
  -- 显示隐藏文件
  { key = "i", action = "toggle_custom" }, -- 对应 filters 中的 custom (node_modules)
  { key = ".", action = "toggle_dotfiles" }, -- Hide (dotfiles)
  -- 文件操作
  { key = "<F5>", action = "refresh" },
  { key = "a", action = "create" },
  { key = "d", action = "remove" },
  { key = "r", action = "rename" },
  { key = "x", action = "cut" },
  { key = "c", action = "copy" },
  { key = "p", action = "paste" },
  { key = "s", action = "system_open" },
}
nvim_tree.setup({
    -- 不显示 git 状态图标
    git = {
        enable = false,
    },
    -- project plugin 需要这样设置
    update_cwd = true,
    update_focused_file = {
        enable = true,
        update_cwd = true,
    },
    -- 隐藏 .文件 和 node_modules 文件夹
    filters = {
        dotfiles = true,
        custom = { 'node_modules' },
    },
    view = {
        -- 宽度
        width = 40,
        -- 也可以 'right'
        side = 'left',
        -- 隐藏根目录
        hide_root_folder = false,
        -- 自定义列表中快捷键
        mappings = {
            custom_only = false,
            list = list_keys,
        },
        -- 不显示行数
        number = false,
        relativenumber = false,
        -- 显示图标
        signcolumn = 'yes',
    },
    actions = {
        open_file = {
            -- 首次打开大小适配
            resize_window = true,
            -- 打开文件时关闭
            quit_on_open = true,
        },
    },
    system_open = {
        cmd = 'open', -- mac 直接设置为 open
    },
})
-- 自动关闭
vim.cmd([[
  autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
]])
EOF
""  让 nvim-tree 支持切换目录
"" ahmedkhalf/project.nvim
lua << EOF
local status, project = pcall(require, "project_nvim")
if not status then
    vim.notify("没有找到 project_nvim")
  return
end

-- nvim-tree 支持
vim.g.nvim_tree_respect_buf_cwd = 1

project.setup({
  detection_methods = { "pattern" },
  patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", ".sln",".md",".vim"},
  datapath = vim.fn.stdpath("data"),
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  silent_chdir = false,
})

local status, telescope = pcall(require, "telescope")
if not status then
  vim.notify("没有找到 telescope")
  return
end
pcall(telescope.load_extension, "projects")
EOF

"" 启动页
""
nmap <Leader>d :Dashboard<CR>
lua << EOF
local status, db = pcall(require, "dashboard")
if not status then
  vim.notify("没有找到 dashboard")
  return
end

db.custom_footer = {
  "                   ",
}

db.custom_center = {
  {
    icon = "  ",
    desc = "Projects												",
    action = "Telescope projects",
  },
  {
    icon = "  ",
    desc = "Recently files						",
    action = "Telescope oldfiles",
  },
  {
    icon = "  ",
    desc = "Edit Projects							",
    action = "edit ~/.local/share/nvim/project_nvim/project_history",
  },
  {
    icon = "  ",
    desc = "Edit nvim config					",
    action = "edit /Users/tg/.config/nvim/init.vim",
  },
  {
     icon = "  ",
     desc = "Diary															",
     action = "edit /Users/tg/Desktop/L/init.md",
  },
  {
     icon = "  ",
     desc = "Find file											",
     action = "Telescope find_files",
  },
  {
     icon = "  ",
     desc = "Find text											",
     action = "Telescope live_grep",
 },
}

db.custom_header = {
[[]],
[[]],
[[]],
[[]],
  [[⠀⠀⠀⠀⠠⢐⠇⡍⠄⠀⢐⢸⡂⢰⣱⢀⠀⣗⡷⣕⢆⡂⢅⠘⡜⡜⡌⡊⢨⠠⠀⣽⣺⡽⠖⡡⢠⠂⠀⠀⠀⢀⠔⢁⠂⠀⠀⠀⠀]],
  [[⠀⠀⠀⠀⠀⠘⣦⣋⢐⠀⡢⢽⣳⣞⡞⣋⣤⠤⠙⠯⣗⣷⣠⢧⢋⢧⡐⠠⠳⡯⠄⢓⠁⠆⣦⣄⠺⡅⠀⡂⢀⡎⣀⢢⠃⠀⠀⠁⠀]],
  [[⠀⠀⠀⠀⠀⠀⢹⡆⠀⡇⢸⣽⣳⢽⣴⣿⣇⠀⢀⣷⡄⢅⠉⠑⣠⢧⡑⠀⢠⢠⣾⣇⣀⣠⣿⣿⣇⢣⢨⠂⣼⠀⡀⠜⠀⠀⠀⠀⠀]],
  [[⠀⠀⠀⠀⠀⠀⢀⠱⣄⣹⠘⣾⣺⢯⠺⣟⣿⣿⣿⡿⢳⣻⢤⣆⡈⣿⠡⡠⡪⣯⠻⢿⣯⣷⠿⡳⣗⢕⠕⠰⢃⢡⠐⠀⠀⠀⠀⠀⠀]],
  [[⠀⠀⠀⠀⠀⠀⠂⠀⠌⠻⡆⢹⢾⢽⢯⢶⢭⣕⡵⣼⢽⣺⢯⣿⠌⡷⡱⡱⣱⠳⣻⣲⣲⡒⠯⡙⡡⡣⠃⡏⠊⠀⠀⠀⠀⠀⠀⠀⠀]],
  [[⠀⠀⠀⠀⠀⢈⠀⠸⢀⠡⢐⠈⢯⢿⡝⠫⢻⣺⢽⡽⣽⣺⢽⠾⡂⡻⢮⣞⣗⣟⣶⣲⣲⠦⠻⡝⡜⠌⡨⡔⠀⠁⠀⠀⠀⠀⠀⠄⠀]],
  [[⠀⠀⠀⠀⠀⠂⠀⢕⢔⣜⣞⡮⡌⢯⢿⡀⢦⣦⣥⣍⣌⣍⣙⡑⣋⢓⡋⣊⣓⣩⣨⣨⢤⠂⡜⡜⡜⡸⡸⡌⠀⠐⠀⠀⠐⠈⠀⠀⠀]],
  [[⠀⣀⣀⡀⣈⡀⠀⠉⠉⠉⠉⠉⣑⣈⠉⣉⣀⣁⣈⣉⡉⡉⡉⣉⣉⣉⣉⣉⠉⡉⡉⣁⣀⣈⣁⡉⢀⢉⠉⠂⠀⠐⠀⠀⣀⣀⣀⡀⠀]],
  [[]],
  [[]],
  [[]],
}

db.custom_header = {
  [[⢕⢕⢕⢕⢕⢕⢕⢕⢕⢕⢕⠕⠕⡑⡡⡡⡕⡜⡔⡕⡕⡕⢕⢕⢕⢕⢱⢑⢎⢦⢲⢨⢢⢢⢪⢬⣘⡘⡘⠪⠪⢮⢲⡡⣃⠳⡱⡕⣕⢕⢇⢗⢕⢇⢗⢕⢇⢗⡕⣇⢗⢵⢹⢜⢮⡪]],
  [[⢕⢕⢝⢌⢎⢎⢎⠎⠎⡅⡆⡮⡺⡸⡱⡑⡅⡕⡔⡕⡕⡍⡎⡪⡪⡪⡪⢪⢪⢪⢪⡪⡣⡣⡇⡗⡆⡏⡮⡫⣚⡲⡢⡬⣊⠳⡸⣘⠜⡜⡜⡜⡬⡪⠮⡌⢇⢇⢇⢇⢗⢕⢧⢳⡱⡕]],
  [[⢕⢕⢕⢕⠕⡃⡕⡜⡕⡕⡕⡕⡕⡕⢕⢕⢕⢕⢜⠜⡜⡜⡜⡜⡜⠜⠜⠈⢈⠨⢐⠀⡐⡐⢈⠠⠑⢉⠊⡚⠜⡜⡎⡮⡪⡪⡒⢬⢑⠪⣘⠸⡌⡎⡇⣇⠪⡣⡫⣪⢣⡳⡱⡕⣕⠭]],
  [[⢕⢕⢕⠅⡎⡎⢜⢌⠎⢎⢎⢎⢎⢎⢎⢎⢎⢎⢎⢪⢜⡸⠘⡈⢀⠂⠀⠅⡰⢨⠂⠄⡢⡊⢆⠐⢈⠄⢂⠐⡀⢂⠑⠱⢹⢘⢌⢇⢇⢗⠦⡅⡂⣝⢜⡒⡸⡸⡪⣪⢪⢎⢞⡜⣜⢎]],
  [[⢕⢕⢅⠪⣒⢸⢨⠢⣑⢑⠜⡌⢆⢣⢪⢢⢣⢣⠣⡣⠃⢀⠁⠠⠀⠄⠡⣘⢜⠬⠐⡨⡪⡪⡂⡆⢐⠨⠀⡂⠐⠠⠈⡈⠄⠅⠣⡣⡣⡣⡓⡜⡜⡤⡑⠕⡜⡎⣎⢎⢮⢪⡣⡣⡇⡗]],
  [[⢕⢕⢕⠸⡰⡱⡑⡕⡌⣆⢳⠸⡐⡕⡅⡇⡕⡕⠑⠁⠠⠀⠂⠄⠡⠈⡜⡔⡕⡕⠀⡇⡇⡧⡳⡨⡀⡂⡁⠐⡈⠄⠡⢐⠀⠅⡁⠌⢺⢸⢸⢸⡸⢸⢘⢲⢨⠪⡪⣪⢪⢎⢎⢮⢺⢸]],
  [[⢕⠕⡕⡌⢪⠢⡣⢃⢇⠎⡆⡇⡇⢇⢕⠕⠑⠈⡀⠡⠀⠅⠨⠀⠌⡸⡸⡸⡸⡌⢂⢇⢇⢇⢇⢇⢇⠠⠀⠅⠄⡁⡪⠐⢀⠁⠄⠈⠄⡑⡕⡱⣘⢢⢱⢡⢣⢣⡘⢜⢜⢜⢎⢮⢪⢎]],
  [[⡊⡎⡎⡎⢆⠱⡨⡐⢅⢣⢊⠆⡣⢣⠣⡢⠬⡰⢀⠂⠂⡁⠐⡈⠠⠪⠪⠪⡪⡪⡠⡣⡣⡣⡳⡱⡱⡈⡐⢸⡀⡢⡣⡃⠄⠠⠁⠌⡀⠄⠪⡪⡢⡣⢕⢕⠕⡕⡅⢇⠱⡣⡳⡱⡱⡕]],
  [[⢸⢨⠪⡪⡪⢌⠢⡃⡇⢆⢣⢱⢑⠕⡕⡜⡜⠈⡀⠄⢁⠀⠂⠬⡐⡕⡕⡕⡆⡎⡢⡣⡣⡣⡣⡣⡫⡢⢂⢕⢕⢕⢕⢕⠈⠠⠈⠄⠠⢀⠁⢇⢇⢣⠣⡱⠱⡑⢜⠌⣎⠸⡸⡸⡸⡸]],
  [[⡱⡑⡕⢕⢕⢕⠥⡑⢜⠜⡨⢊⢢⢑⠱⠈⡀⢄⠄⠂⠠⢀⠡⡱⡱⠱⢱⠱⡱⡱⡱⡱⡱⡱⡱⡱⡱⡱⡨⠬⡌⡌⡊⢎⠄⠌⡀⠌⠀⠂⡈⢜⠌⡔⠅⡇⢕⢝⠄⡮⢂⢳⠘⡜⡕⡭]],
  [[⢜⢌⢎⢎⢆⢇⢣⢕⠤⡑⢔⠡⡱⡡⡣⠣⡊⡂⠆⠅⠂⢸⢐⢅⢔⢔⢔⢄⠂⢕⢜⢜⠌⡎⡎⡎⡎⡎⡎⡇⡇⡇⡏⡆⢄⠢⠀⢐⠀⡁⠠⠈⡸⡨⡃⢎⢎⠪⢰⢱⢐⢕⠱⡈⡎⡎]],
  [[⢪⠢⡣⢪⠢⡣⢣⢱⢑⢕⠤⡑⢜⠔⢅⠣⠂⠥⡁⡅⠅⢜⢜⢜⢸⢘⢜⢜⢸⢰⠱⡑⢨⢪⢪⠪⡪⠊⠌⠘⠸⢸⢸⢘⢜⠌⡀⠂⠐⢀⠀⠂⡘⢬⠂⡣⡱⢁⢇⢕⠰⡨⡊⢆⢜⠜]],
  [[⢪⢊⢎⢪⠪⡊⡎⡪⡊⡎⡪⡪⡢⢌⠢⢑⢅⠕⠐⠄⡃⠕⢑⠘⠌⠎⡎⡪⡊⡎⡪⢂⢕⢱⢡⢓⢔⠎⡎⡝⡔⣄⠱⡱⡑⡅⡂⠀⡁⠐⡄⡅⢨⢪⠂⡪⡨⠠⡣⡣⢨⢢⠣⡑⡐⡡]],
  [[⢸⠰⡡⢣⠱⡑⡕⡅⢇⢕⢕⠜⡌⡎⢎⢲⢈⢄⠡⡡⡂⠅⢕⠕⡕⢕⢔⠬⡨⣘⢘⠔⠅⢇⢕⢕⢱⢑⢥⢨⠬⢄⢇⢣⢣⠃⢠⠐⡄⢀⢢⠢⢨⢨⠂⡕⢜⠨⢌⠆⡊⠆⡇⢁⢔⠕]],
  [[⢸⠨⡊⢎⠪⡊⡆⡣⡣⡱⡸⡘⡌⡎⡪⡊⡆⢇⢕⠤⡡⠨⢐⢌⢊⠪⡢⢣⢣⠪⡢⡣⡣⡱⡰⡰⡡⡡⡡⣁⠃⡃⢱⢑⢁⢈⠄⡂⠕⠢⡐⠕⢐⠕⡅⠌⡆⠡⡣⡃⠌⡊⡀⡪⡊⢔]],
  [[⢸⠨⡊⡎⡪⢪⢘⢌⢆⢣⢊⢎⢜⠌⠎⠜⠌⠎⡆⡣⢣⢃⠂⢕⠅⡇⢕⢱⠰⡑⡕⡸⠰⡱⡸⢰⠱⡸⡨⡢⢣⠃⡌⠔⢀⢢⢑⢐⢑⢅⠣⡑⢐⠕⠅⡘⡠⡑⡜⠄⡊⡐⢔⠬⢐⢕]],
  [[⡘⡌⡪⢢⠱⡡⢣⠱⡘⠌⢂⢅⠢⡢⡒⡜⢔⢱⢠⢑⠑⠅⢇⠠⠑⢅⢇⢕⢱⢑⢜⢌⢕⠕⡜⢔⢱⢨⢢⢡⠅⡑⡠⡠⢑⠡⢂⢑⠌⠔⡑⠈⡰⡑⡕⡱⡘⡌⡎⡪⡐⡌⡎⠢⠱⠑]],
  [[⢌⠆⡕⢅⠣⡊⠆⡡⢐⢌⠪⡢⢣⠱⡘⡌⢎⢢⠱⡑⠍⡊⡂⢐⢈⠐⠄⡕⡈⠢⠃⢎⠢⡣⡪⡊⢎⠢⢃⠅⡂⡔⢔⠌⡆⡣⡒⡢⡪⢪⠘⡠⡊⢜⢈⠌⡊⠊⡜⡌⢎⢪⢸⢨⢢⠣]],
  [[⢢⠱⡘⢔⠑⡡⡁⠢⡡⡑⢕⠜⡌⡪⢪⠘⢌⠐⡐⠌⡂⡂⡂⢔⠐⢄⠡⠀⠣⢱⢘⢔⠰⠰⠐⠅⡑⢨⢐⡈⡂⢆⢢⢡⠑⢜⢌⢪⠨⢊⠔⡕⢌⠒⡐⠅⡌⡢⢈⠸⡨⢪⢂⠇⡎⢠]],
  [[⠢⡱⠈⡔⢌⠢⠐⢄⠑⡜⢔⢑⢕⠸⡨⡈⢀⠢⡈⣂⠢⢂⢠⢑⠥⡡⢂⠌⡐⡐⠄⢂⠄⡡⠡⠨⠀⢌⠂⠇⠢⡡⡑⠜⡈⢔⠔⢔⢔⠢⡣⠪⡊⡆⡑⠅⡪⢢⢂⠅⡌⠢⡣⠱⡀⢇]],
  [[⠑⡠⠑⢌⠢⡡⡑⡐⡐⠨⡊⡢⡑⢕⢌⡂⠠⡁⠂⢄⠆⡕⢌⢆⠣⡊⢆⢕⠐⡄⢕⢐⢌⠢⡃⠇⠨⢂⠅⡡⠁⢜⠌⡆⡌⣐⠑⡅⡢⡃⢎⢕⠱⡘⡄⡁⢇⠕⡅⡣⡊⡢⡱⢁⢪⠢]],
  [[⠨⡐⡡⡡⠱⡨⡊⡌⡪⡂⡊⡢⡑⢕⢔⠸⡀⢂⠕⢅⠣⡪⡨⠢⡣⡑⢕⢔⠱⡘⢔⠱⡘⡌⡪⡑⡅⠄⡁⡂⡨⠢⡃⡎⢜⡐⡅⠌⡢⡑⢕⢌⢪⠸⡰⠠⡑⢕⢌⢆⢣⠱⡈⡢⡑⢕]],
  [[⠰⡐⡐⡄⠅⡂⠌⠂⠒⠌⠢⠈⠜⡐⢌⢊⡂⢌⠪⡘⢌⠢⡊⡪⡂⢎⢢⢑⢅⠣⡑⡅⡣⡊⡢⡱⠨⡂⠄⢔⠸⡘⡌⢜⠔⡔⢌⠪⢀⠣⢱⠨⡢⠣⡊⢎⠪⡊⡢⡊⢢⠱⢐⢌⠪⡢]],
  [[⠨⡂⢕⠨⡨⢂⠢⡁⠅⡅⢌⠠⡨⠰⠈⢆⠪⢀⠃⠎⠜⢌⢊⠢⡊⢆⠕⠔⡅⢕⢑⠌⢆⠪⡂⢎⠕⢀⠎⢜⢌⠒⠜⡐⡁⡂⡂⡌⡐⡀⡂⢑⠘⠌⡪⠪⡘⢌⠆⡕⢔⢁⠪⢢⠱⡨]],
}

 -- local home = os.getenv('HOME')
 --  db.preview_command = 'cat | lolcat -F 0.3'
 -- db.preview_file_path =  home .. '/.config/nvim/neovim.cat'
 --  db.preview_file_height = 21
 --  db.preview_file_width = 70

EOF
