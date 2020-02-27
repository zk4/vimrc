scriptencoding utf-8
set encoding=utf-8
set fileencoding=utf-8
set runtimepath+=~/.vim
" 设置 leader
let mapleader=" "
"let maplocalleader =" "
set updatetime=300
"显示颜色 在 kitty 里使分隔边框更细更好看
set termguicolors

set autoread
set foldmethod=indent

" 将 tab 转化为空格
"set expandtab
"let g:python_host_prog  = '/Users/zk/anaconda3/bin/python'

" 方便 gf 跳转
" set path+=**
" when scroll with track pad, cursor not move but page
set mouse=a


" show  control characters
" set list
" set listchars=eol:⏎,tab:␉·,trail:␠,nbsp:⎵
" set listchars=tab:⇤·,nbsp:⎵

"  指定换行符
if $TERM_PROGRAM  == "iTerm.app"
    set showbreak=↪\   
endif
"不显示键盘的命令
set noshowcmd
set noruler
" if fold file when open . 99: don` fold   0: fold     :help foldlevelstart
set foldlevel=99
" set gvim font size
if has("gui_running")
    set guifont=Droid\ Sans\ Mono\ Nerd\ Font\ Complete:h18
endif
" if show status line when only one window shown
set laststatus=2
" set text formating ------------
set formatprg=par   " 使用方法 gwip
"set textwidth=0
"超出 wrap-width 时显示红色
"match ErrorMsg '\%>80v.\+'


" vi 打开文件时,切换到这个文件的目录
" 换文件时,导致 ctrl-p 也会跟着变,怎么取舍吧
"set autochdir

" make search case insensitive
set hlsearch
" 渐近搜索
set incsearch
" 忽略大小写
set ignorecase
" 但在自动补全时，大小写第三
set infercase
set magic
" 允许不写入 buffer 时,也只可以切换 buffer
set hidden
" 显示行号
set number
""" 显示相对行号
" set relativenumber
"" 支持系统剪贴板
set clipboard=unnamed
set guioptions+=a
" 自动保存

set autowrite
" 2 代表永远显示 tab
set showtabline=2
" 输命令时,提示
set wildmenu
set wildmode=full
set history=200

set tabstop=2               " 设置tab键的显示宽度，如果有时你觉得太宽，可以打印看看当前值
set shiftwidth=2           " 换行时行间交错使用4个空格
set backspace=2             " 设置退格键可用
set cindent shiftwidth=2    " 自动缩进4空格

"set autoindent              " 自动对齐
"hi Search term=standout ctermfg=5 ctermbg=12
" set smartindent             " 智能自动缩进
" set smarttab

" 设置分割, 
if $TERM_PROGRAM  == "iTerm.app"
set fillchars=vert:\|
else
"kitty suppoert very well
set fillchars=vert:\│
endif
" Override color scheme to make split the same color as tmux's default
autocmd ColorScheme * highlight VertSplit cterm=NONE ctermfg=WHITE ctermbg=NONE

set noshowmatch
set wrapscan                " 搜索到文件两端时重新搜索
"set list                   " 显示Tab符，使用一高亮竖线代替
syntax enable               " 打开语法高亮
syntax on                   " 开启文件类型侦测
filetype on                 
"filetype indent on         " 针对不同的文件类型采用不同的缩进格式
filetype  plugin on          " 针对不同的文件类型加载对应的插件
set nobackup                " 设置无备份文件
set backupskip=/tmp/*,/private/tmp/*
set noswapfile

" set spell
