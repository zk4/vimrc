"指定脚本使用的字符编码为 UTF-8。
scriptencoding utf-8

"设置 Vim 内部和 RPC 通信使用的字符串编码为 UTF-8。
set encoding=utf-8

"	设置当前缓冲区的文件内容编码为 UTF-8。
set fileencoding=utf-8

" 将 ~/.vim 目录添加到 Vim 运行时文件的搜索路径中。
set runtimepath+=~/.vim

" 禁止响铃提示。
set noerrorbells

" 设置 Leader 键为空格键。
let mapleader=" "

"	If this many milliseconds nothing is typed the swap file will be
" written to disk (see |crash-recovery|).  Also used for the
" |CursorHold| autocommand event.
" 设置光标停留多少毫秒后自动写入交换文件。
set updatetime=300

" 启用终端颜色。
" 在 kitty 里使分隔边框更细更好看
set termguicolors

" 自动读取文件修改。
set autoread

" 使用缩进来折叠代码。
set foldmethod=indent

" 设置 Python 的路径。
" let g:python_host_prog='/usr/local/Cellar/python@3.8/3.8.11/'

" 将当前目录及其子目录添加到文件搜索路径中。方便 gf 跳转
" This is a list of directories which will be searched when using the
"	|gf|, [f, ]f, ^Wf, |:find|, |:sfind|, |:tabfind| and other commands,
" set path+=**

" 启用鼠标支持。
set mouse=a

" 设置标签文件的搜索路径。
set tags=./.tags;,.tags,tags
" 手动在 ~/node_modules, ~/Library/Caches/typescript/4.4/node_modules 里创建了 tags
set tags+=~/node_modules/tags,~/Library/Caches/typescript/4.4/node_modules/tags

set tags+=~/Library/Caches/typescript/4.4/node_modules/fs-extra/lib/tags

set tags+=~/git/working/next_web/react/tags

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

" 设置垂直分隔符的填充字符。
set fillchars=vert:\│
" -----------------------------------------

" 禁止显示命令行。
set noshowcmd

" 禁止显示标尺。
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
" 0 代表不显示
set showtabline=0
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

" 禁止隐藏光标，coc 貌似总有 bug 会导致光标丢失
set nomousehide

 "when search with gf. it there is no suffix. try add the above
 augroup autocmd_guard_me2
 autocmd FileType javascriptreact setlocal suffixesadd=.jsx,.js,.vue,.scss
 augroup END


colorscheme quiet
