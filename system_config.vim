scriptencoding utf-8
set encoding=utf-8
set fileencoding=utf-8
set runtimepath+=~/.vim
set foldmethod=indent
" 将 tab 转化为空格
set expandtab 
"  指定换行符
set showbreak=↪\ 
"显示键盘的命令
set showcmd
" if fold file when open . 99: don` fold   0: fold     :help foldlevelstart
set foldlevel=99
" 设置 leader
let mapleader=" "
let maplocalleader =" "
" set gvim font size
if has("gui_running")
    set guifont=Droid\ Sans\ Mono\ Nerd\ Font\ Complete:h18
endif
" if show status line when only one window shown
set laststatus=2
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile
" set text formating ------------
set formatprg=par
" font 平滑
"set antialias

" vi 打开文件时,切换到这个文件的目录
" 换文件时,导致 ctrl-p 也会跟着变,怎么取舍吧
"set autochdir

" make search case insensitive
set hlsearch
" 渐近搜索
set incsearch
" 忽略大小写
set ignorecase
set magic
" 允许不写入 buffer 时,也只可以切换 buffer
set hidden
set backupskip=/tmp/*,/private/tmp/*
" 显示行号
"set number
"" 显示相对行号
"set relativenumber
" 支持系统剪贴板
set clipboard=unnamed
set guioptions+=a
" 自动保存
set autowrite
" 2 代表永远显示 tab
set showtabline=2
" 输命令时,提示
set wildmenu
set wildmode=longest:list,full
"hi Search term=standout ctermfg=5 ctermbg=12
set tabstop=4               " 设置tab键的宽度
set shiftwidth=4            " 换行时行间交错使用4个空格
set autoindent              " 自动对齐
set backspace=2             " 设置退格键可用
set cindent shiftwidth=4    " 自动缩进4空格
set smartindent             " 智能自动缩进

" 设置分割
set fillchars=vert:\| 
" Override color scheme to make split the same color as tmux's default
autocmd ColorScheme * highlight VertSplit cterm=NONE ctermfg=WHITE ctermbg=NONE

" 设置自动缩进,当超出 textwidth 时,根据前一行 indent
set ai

" 显示括号配对情况
set showmatch
"set nowrapscan             " 搜索到文件两端时不重新搜索
"set cursorline             " 突出显示当前行
"set list                   " 显示Tab符，使用一高亮竖线代替
syntax enable               " 打开语法高亮
syntax on                   " 开启文件类型侦测
filetype on                 "
"filetype indent on         " 针对不同的文件类型采用不同的缩进格式
filetype plugin on          " 针对不同的文件类型加载对应的插件
"set nobackup               " 设置无备份文件
"set nocompatible           " 不使用vi兼容的模式

" theme
"colorscheme peaksea
colorscheme wombat
"colorscheme gruvbox
