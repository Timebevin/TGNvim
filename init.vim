""
""  插件列表
""
call plug#begin()
""  补全插件
Plug 'neoclide/coc.nvim', {'branch': 'release'}
""  主题插件
Plug 'sainnhe/everforest'
Plug 'folke/tokyonight.nvim'
Plug 'ful1e5/onedark.nvim'
""  状态栏插件
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
""  git插件
Plug 'tpope/vim-fugitive'
"" 多光标插件
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
"" 搜索当前目录下文件
Plug 'ctrlpvim/ctrlp.vim'
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
"" 代码注释
Plug 'preservim/nerdcommenter'
"" mason插件
Plug 'williamboman/mason.nvim'
"" 代码高亮
Plug 'nvim-treesitter/nvim-treesitter'
"" Plug 'nvim-lua/plenary.nvim'
"" 模糊搜索
Plug 'nvim-telescope/telescope.nvim'
"" 输入法切换
Plug 'keaising/im-select.nvim'
"" 启动页
Plug 'glepnir/dashboard-nvim'
"" nvim-project
Plug 'ahmedkhalf/project.nvim'
call plug#end()

""
""  基础配置项
""
set number
set autoindent
set encoding=UTF-8
set signcolumn=number
""  根据文件中其他地方的缩进空格数来确定一个tab是多少空格
set smarttab
"" 将tab扩展成空格
set ts=2
set expandtab
set autoindent
set shiftwidth=4
set mousefocus
set backspace=2    " more powerful backspacing
set wrap
""
""  基础快捷键配置
""
let mapleader=","
nmap q :q<CR>
nmap w :w<CR>
nmap <C-j> 4j<CR>
nmap <C-k> 4k<CR>
imap <C-h> <ESC>I
imap <C-l> <ESC>A
""设置切换Buffer快捷键"
 nnoremap <space>h :bn<CR>
 nnoremap <space>l :bp<CR>
 nnoremap <space>c :bd<CR>
""  git基础配置
set statusline^=%{get(g:,'coc_git_status','')}%{get(b:,'coc_git_status','')}%{get(b:,'coc_git_blame','')}
"" 初始化执行命令
""autocmd VimEnter * :edit /Users/tg/Desktop/L/init.md
""autocmd VimEnter * CocCommand explorer --toggle /Users/tg/Desktop/WorkSpace/agv_smartmonitor_front

"" im-selected 输入法切换
lua << EOF
require('im_select').setup {
	-- IM will be set to `default_im_select` in `normal` mode(`EnterVim` or `InsertLeave`)
	-- For Windows, default: "1003", aka: English US Keyboard
	-- You can use `im-select` in cli to get the IM name of you preferred
	default_im_select  = "com.apple.keylayout.ABC",

	-- Set to 1 if you don't want restore IM status when `InsertEnter`
	disable_auto_restore = 0,
}
EOF
""
""  mason补全配置
""
lua require("mason").setup()
"" 代码高亮
lua << EOF
local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
    vim.notify("没有找到 nvim-treesitter")
    return
end

treesitter.setup({
  -- 安装 language parser
  -- :TSInstallInfo 命令查看支持的语言
  ensure_installed = { "json", "html", "css", "vim", "lua", "javascript", "typescript", "tsx","vue","scss" },
  -- 启用代码高亮模块
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
})
EOF

"" git插件配置 tpope/vim-fugitive'


""  模糊搜索
lua << EOF
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

""
""  coc.nvim 配置项
""
cnoremap <c-h> <left>
inoremap <silent><expr> <TAB>
            \ coc#pum#visible() ? coc#pum#next(1) :
            \ CheckBackspace() ? "\<Tab>" :
            \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
""  easymotion基础配置
let g:EasyMotion_do_mapping = 0 " Disable default mappings
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-overwin-f2)

" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

"" nerdcommenter注释配置
" [count]|<Leader>|cc |NERDCommenterComment|
" Comment out the current line or text selected in visual mode.
" [count]|<Leader>|cn |NERDCommenterNested|
" Same as |<Leader>|cc but forces nesting.
" [count]|<Leader>|c<space> |NERDCommenterToggle|
" Create default mappings
let g:NERDCreateDefaultMappings = 1

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1

"" HopWord移动
lua require'hop'.setup()
nmap <space>hd :HopWord<CR>
nmap <space>hn :HopPattern<CR>
nmap <space>he :HopLine<CR>
""  格式化基础配置
lua local async = require "plenary.async"
lua require("null-ls").setup({
\sources={
\require("null-ls").builtins.formatting.stylua,
\require("null-ls").builtins.diagnostics.eslint,
\require("null-ls").builtins.completion.spell,
\require("null-ls").builtins.formatting.prettier,
\},
\})
noremap <space>f :lua vim.lsp.buf.formatting_sync()<CR>
"" toggleterm终端基础配置
lua require("toggleterm").setup{
            \open_mapping = [[<c-\>]],
            \ direction = 'horizontal',
            \ close_on_exit = true,
            \ }
""
""  vim-choosewin基础配置
""
nmap - <Plug>(choosewin)
""  ctrlp基础配置
""
let g:ctrlp_extensions = ['notes']
""
"" vim-visual-multi配置
noremap <leader>gdi :Gdiffsplit<CR>
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
let g:airline_extensions = ['hunks', 'branch', 'tabline', 'coc']
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


""
""  coc-git基础配置
""
" lightline
let g:lightline = {
            \ 'active': {
            \   'left': [
            \     [ 'mode', 'paste' ],
            \     [ 'ctrlpmark', 'git', 'diagnostic', 'cocstatus', 'filename', 'method' ]
            \   ],
            \   'right':[
            \     [ 'filetype', 'fileencoding', 'lineinfo', 'percent' ],
            \     [ 'blame' ]
            \   ],
            \  },
            \  'component_function': {
            \   'blame': 'LightlineGitBlame',
            \  }
            \ }

function! LightlineGitBlame() abort
    let blame = get(b:, 'coc_git_blame', '')
    " return blame
    return winwidth(0) > 120 ? blame : ''
endfunction

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
  "冲  冲  冲  冲  冲  冲  冲  冲  冲  冲  冲  冲",
}

db.custom_center = {
  {
    icon = "  ",
    desc = "Projects                            ",
    action = "Telescope projects",
  },
  {
    icon = "  ",
    desc = "Recently files                      ",
    action = "Telescope oldfiles",
  },
  {
    icon = "  ",
    desc = "Edit Projects                       ",
    action = "edit ~/.local/share/nvim/project_nvim/project_history",
  },
  {
     icon = "  ",
     desc = "Diary                               ",
     action = "edit /Users/tg/Desktop/L/init.md",
  },
  {
    icon = "  ",
    desc = "Edit nvim config                     ",
    action = "edit /Users/tg/.config/nvim/init.vim",
  },
  {
     icon = "  ",
     desc = "Find file                           ",
     action = "Telescope find_files",
  },
  {
     icon = "  ",
     desc = "Find text                           ",
     action = "Telescope live_grep",
 },
}


db.custom_header = {
  [[                                                             ]],
  [[                                                             ]],
  [[               ▀████▀▄▄              ▄█                      ]],
  [[                 █▀    ▀▀▄▄▄▄▄    ▄▄▀▀█                      ]],
  [[         ▄        █          ▀▀▀▀▄  ▄▀                       ]],
  [[        ▄▀ ▀▄      ▀▄              ▀▄▀                       ]],
  [[       ▄▀    █     █▀   ▄█▀▄      ▄█                         ]],
  [[       ▀▄     ▀▄  █     ▀██▀     ██▄█                        ]],
  [[        ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █                       ]],
  [[         █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀                       ]],
  [[        █   █  █      ▄▄           ▄▀                        ]],
  [[                                                             ]],
  [[                ███████╗██╗   ██╗                            ]],
  [[                ██╔════╝╚██╗ ██╔╝                            ]],
  [[                ███████╗ ╚████╔╝                             ]],
  [[                ╚════██║  ╚██╔╝                              ]],
  [[                ███████║   ██║                               ]],
  [[                ╚══════╝   ╚═╝                               ]],
  [[                                                             ]],
}
EOF

""
""  coc-explorer文件树基础配置
""
" let g:coc_explorer_global_presets = {
"             \   'nvim': {
"             \     'root-uri': '~/.config/nvim',
"             \   },
"             \   'cocConfig': {
"             \      'root-uri': '~/.config/coc',
"             \   },
"             \   'WorkSpace':{
"             \    'position': 'left',
"             \    'root-uri': '~/Desktop/WorkSpace',
"             \   },
"             \   'tab': {
"             \     'position': 'left',
"             \     'quit-on-open': v:true,
"             \   },
"             \   'floating': {
"             \     'position': 'floating',
"             \     'open-action-strategy': 'sourceWindow',
"             \   },
"             \   'simplify': {
"             \     'file-child-template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
"             \   },
"             \   'buffer': {
"             \     'sources': [{'name': 'buffer', 'expand': v:true}]
"             \   },
"             \ }
"
" " Use preset argument to open it
" nmap <space>ef <Cmd>CocCommand explorer --preset floating<CR>
" nmap <space>et <Cmd>CocCommand explorer --preset tab<CR>
"
" " List all presets
" nmap <space>el <Cmd>CocList explPresets<CR>

""
""  主题
""
let g:everforest_better_performance = 1
""colorscheme everforest
colorscheme onedark
""let g:everforest_background = 'soft'
let g:rehash256 = 1
let g:molokai_original = 1
