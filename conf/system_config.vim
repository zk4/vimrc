"Specify the character encoding used in the script.
scriptencoding utf-8

"String-encoding used internally and for |RPC| communication.
set encoding=utf-8

"	File-content encoding for the current buffer. Conversion is done with
"	iconv() or as specified with 'charconvert'.
set fileencoding=utf-8

" List of directories to be searched for these runtime files:
set runtimepath+=~/.vim

set noerrorbells

" 设置 leader
let mapleader=" "

"	If this many milliseconds nothing is typed the swap file will be
" written to disk (see |crash-recovery|).  Also used for the
" |CursorHold| autocommand event.
set updatetime=300

"显示颜色 在 kitty 里使分隔边框更细更好看
set termguicolors

set autoread
set foldmethod=indent


let g:python_host_prog  = '/usr/local/Cellar/python@3.8/3.8.11/'

" 方便 gf 跳转
" 	This is a list of directories which will be searched when using the
"	|gf|, [f, ]f, ^Wf, |:find|, |:sfind|, |:tabfind| and other commands,
" set path+=**

" when scroll with track pad, cursor not move but page
set mouse=a

" set tag name
set tags=./.tags;,.tags

" set iskeyword+=-
" -----------------------------------------
" show  control characters
" set listchars=eol:⏎,tab:␉·,trail:␠,nbsp:⎵
" set list
" set listchars=tab:⇤·,nbsp:⎵

"  指定换行符
"if $TERM_PROGRAM  == "iTerm.app"
    "set showbreak=↪\
"endif

set fillchars=vert:\│
" -----------------------------------------

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
"set relativenumber

"" 支持系统剪贴板
set clipboard=unnamed
set guioptions+=a

set autowrite
" 输命令时,提示
set wildmenu
set wildmode=full
set history=200

" 2 代表永远显示 tab
set showtabline=2
" 将 tab 转化为空格
set expandtab
" 设置tab键的显示宽度，如果有时你觉得太宽，可以打印看看当前值
set tabstop=2 softtabstop=2
" 换行时行间交错使用n个空格
set shiftwidth=2
" 设置退格键可用
set backspace=2

set smarttab

" Override color scheme to make split the same color as tmux's default
" autocmd ColorScheme * highlight VertSplit cterm=NONE ctermfg=WHITE ctermbg=NONE

set noshowmatch
set wrapscan                " 搜索到文件两端时重新搜索
syntax enable               " 打开语法高亮
syntax on                   " 开启文件类型侦测
filetype on
filetype  plugin on          " 针对不同的文件类型加载对应的插件
set nobackup                " 设置无备份文件

set backupskip=/tmp/*,/private/tmp/*
set noswapfile


" 退出后再打开文件，可以 redo
set undofile
set undodir=~/.vim/undo/
set foldnestmax=10
set nofoldenable
set foldlevel=2

