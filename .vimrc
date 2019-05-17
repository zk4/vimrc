"设定 vim 的编码,
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

" global variables {{{
let g:jedi#force_py_version = 3
let g:python2_host_prog     = '/usr/local/bin/python'
let g:python3_host_prog     = '/usr/local/bin/python3'
" }}}

" 不开启这个打开py文件会出现莫名其妙的错
silent! py3 pass

" 设置 leader
let mapleader=" "
let maplocalleader =" "
" 在选择模式下, 将 space 也强制应于 leader, 不然会导致 space 真成空格了,
vnoremap <space> <Nop>


" autocmd {{{
" quit vim help with q instad of :q
nnoremap  <leader>q  <C-w><C-j>:q<cr>
"nnoremap  <leader>q :cclose<cr>
"  折叠 vim 脚本代码, za 开启与关闭, 下面注释的 {{{  }}}很重要, 不然不知道从哪折起哦!
"  {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType help noremap <buffer> q :q<cr>
    autocmd FileType qf  noremap <buffer> q :q<cr>
    autocmd FileTYpe gitcommit noremap <buffer> q :q<cr>
    "注意, 打开文件夹时,会split窗口,所以仅用来 preview files
    autocmd FileTYpe nerdtree map <buffer> J jgo
    autocmd FileTYpe nerdtree map <buffer> K kgo
augroup END
"}}}

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" 在保存.vimrc 后,自动刷新
autocmd! bufwritepost $HOME/.vimrc source %

" 保存后格式化
"autocmd BufWritePre * :normal gg=G

"}}}
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

" 显示相对行号
"set relativenumber

" 支持系统剪贴板
set clipboard=unnamed

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

" 设置分割时的颜色
"set fillchars=vert:\│
" Override color scheme to make split the same color as tmux's default
autocmd ColorScheme * highlight VertSplit cterm=NONE ctermfg=WHITE ctermbg=NONE
" 设置自动缩进,当超出 textwidth 时,根据前一行 indent
set ai

" 显示括号配对情况
set showmatch
"set nowrapscan              " 搜索到文件两端时不重新搜索
"set cursorline             " 突出显示当前行
"set list                   " 显示Tab符，使用一高亮竖线代替
syntax enable               " 打开语法高亮
syntax on                   " 开启文件类型侦测
filetype on                 "
"filetype indent on          " 针对不同的文件类型采用不同的缩进格式
filetype plugin on          " 针对不同的文件类型加载对应的插件
"set nobackup                " 设置无备份文件
"set nocompatible            " 不使用vi兼容的模式

" netrw setting
"let g:netrw_sizestyle= "h"
"let g:netrw_altv          = 1
"let g:netrw_fastbrowse    = 2
"let g:netrw_keepdir       = 0
"let g:netrw_liststyle     = 2
"let g:netrw_retmap        = 1
"let g:netrw_silent        = 1
"let g:netrw_special_syntax=1


" 在创建文件时,自动创建不存在的文件夹
" nvim 时这个方法会出错
"augroup Mkdir
"autocmd!
"autocmd BufWritePre *
            "\ if !isdirectory(expand("<afile>:p:h")) |
            "\ call mkdir(expand("<afile>:p:h"), "p") |
            "\ endif
"augroup ENDas('vim')

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" 去除一层函数掉用  a(b)
nmap dc diwlds(

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           read & write                            "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" sudo write
cnoremap w!! w !sudo tee > /dev/null %

"map zz to za in normal mode
nnoremap zz  za

" open vifm
"nnoremap <leader>1 :!vifm<cr>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                copy & paste  & move & select  & folder               "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" select all
nnoremap <leader>a  ggVG

"set pastetoggle=<F9>

" 在quickfix 里移动
noremap ∆ :cn<cr>
noremap ˚ :cp<cr>

" 全用不需要转义的正则表达式搜索
nnoremap / ms/\v
nnoremap ? ms?\v

function! IsLeftMostWindow()
    let curNr = winnr()
    wincmd h
    if winnr() == curNr
        return 1
    endif
    wincmd p " Move back.
    return 0
endfunc

function! PaneMove()
if IsLeftMostWindow()
"attach-to-user-namespace osascript -e '
python3 << EOF
applescript = """
osascript -e '
tell application "iTerm"
		tell application "System Events" to key code 123 using {command down,option down}
end tell '
"""
os.system(applescript)
EOF
else
   wincmd h
endif
endfunc
" navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" 在 yank 的时候,保持光标在最下方,而不是跳加到前面
vnoremap y y`]

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           refactor                            "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              compile & run                            "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <F5> :call CompileRunGcc()<CR>
inoremap <F5> <esc>:call CompileRunGcc()<CR>

function! FindProjectRoot(lookFor)
    let pathMaker='%:p'
    while(len(expand(pathMaker))>len(expand(pathMaker.':h')))
        let pathMaker=pathMaker.':h'
        let fileToCheck=expand(pathMaker).'/'.a:lookFor
        if filereadable(fileToCheck)||isdirectory(fileToCheck)
            return expand(pathMaker)
        endif
    endwhile
    return 0
endfunction

func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "silent !clear && gcc % -o %<"
        exec "!./%<"
    elseif &filetype == 'javascript.jsx'
        exec "!clear && node %"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        "exec "!time ./%<"
        "elseif &filetype == 'java'
        "exec "!clear && source ~/.bash_profile &&    mvnexec"
        "exec "!clear && javac % && java %<"
        "exec "!time java %<"
    elseif &filetype == 'xml'
        exec "!clear && pwd &&mvn package -DskipTests &&  java  -jar -XX:+TraceClassLoading target/*.jar "
        "exec "!clear && source ~/.bash_profile &&    mvnexec"
        "exec "!time java %<"
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
        exec "!python %"
    elseif &filetype == 'html'
        exec "!open % &"
    elseif &filetype == 'go'
        "exec "!go build %<"
        exec "!clear && time go run %"
    elseif &filetype == 'markdown'
        exec "!~/.vim/markdown.pl % > %.html &"
        exec "!chrome %.html &"
    elseif &filetype == 'vim'
        :source %
    endif
endfunc

"nnoremap <leader>c :call CompileRunGcc()<CR>
"func! CompileRunGcc()
"exec "w"
"if &filetype == 'python'
"exec "!clear && python3 % | jq -C"
"endif
"endfunc

noremap <F2> :cprevious<CR>
noremap <F3> :cnext<CR>
noremap <F6> :exec  '!clear && '.getline('.')<cr>
noremap <F4> :NERDTreeToggle<CR>


" select all
nnoremap <leader>a  ggVG


" indent without lose the selection
noremap <Tab> >gv
noremap <S-Tab> <gv

" switch between tab
nnoremap <Tab> gt
nnoremap <S-Tab> gT
" 在 insert mode 下,让 s-tab 向前 indent
inoremap <S-Tab> <C-d>


" 切换 buffer
"nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
"nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>

" create tab
nnoremap <leader>te :tabe<cr>
" close tab
nnoremap <leader>tc :tabc<cr>

" close buffer
nnoremap <leader>bd :bd<cr>
" close buffer
nnoremap <leader>bda :bwipe<cr>



"快速打开配置文件
"nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>ev :e ~/.vimrc<cr>
nnoremap <leader>ep :e ~/.bash_profile<cr>
" 快速  edit  snippet c
"nnoremap <leader>esc :e /Users/zk/.config/coc/extensions/node_modules/HdsCppSnippets/snippets/c_hds.json<cr>

"nnoremap <leader>g :Ack<space>
nnoremap <C-\> :NERDTreeToggle<CR>
inoremap <C-\> <esc>:NERDTreeToggle<CR>



" 这个映射用的太少了..
nnoremap <Leader><leader> *<CR>

"Alternatively, you could use this mapping so that the final /g is already entered:
nnoremap <Leader>r :%s/\<<C-r><C-w>\>/
"nnoremap ,, <esc>A,
" format file without cursor moving to head, and move cursor the middle of screen
nnoremap <leader>f mmgg=G`mzz
" move page down with cursor in the middle of screen
nnoremap <C-f> <C-d>zz
" move page up with cursor in the middle of screen
nnoremap <C-b> <C-u>zz

" define operator
" ex dp  delete  content in ()
onoremap p i(
onoremap ( i(
onoremap < i<
onoremap " i"
onoremap ' i'
onoremap { i{
onoremap [ i[

inoremap jj <esc>A
inoremap jk <esc>
"inoremap ;; <esc>A;
"inoremap <C-l> <esc>la


call plug#begin('~/.vim/plugged')
" 写 vim wiki 的好工具
"Plug 'vimwiki/vimwiki'

"https://github.com/justinmk/vim-sneak
Plug 'justinmk/vim-sneak'
let g:sneak#label = 1
"nnoremap f <Plug>Sneak_s
"nnoremap F <Plug>Sneak_S
"nnoremap f <Plug>Sneak_f
"nnoremap F <Plug>Sneak_F
"nnoremap t <Plug>Sneak_t
"nnoremap T <Plug>Sneak_T


"====================================================================================================
" 还行.. 可以直接 n p 键上下
"Plug 'vim-scripts/mru.vim'
"nnoremap <leader>m :Mru<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           coc                            "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'neoclide/coc.nvim', {'do': './install.sh nightly'}
" install coc-snippet through  CocInstall coc-snippets
"Make <tab> used for trigger completion, completion confirm, snippet expand and jump like VSCode.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? coc#_select_confirm() :
            \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"  正确高亮 jsonc 的注释
autocmd FileType json syntax match Comment +\/\/.\+$+

" coc snippet
"编辑当前文件类型的snippet
nnoremap <leader>es :CocCommand snippets.editSnippets<cr>
let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<S-Tab>'

set updatetime=300

" Close preview window after completion is done
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Use <Tab> for confirm completion.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <Tab> pumvisible() ? "\<C-y>" : "\<Tab>"

" Use <c-space> for trigger completion.
"inoremap <silent><expr> <C-Space> coc#refresh()


nnoremap <silent> <leader>1 <Plug>(coc-diagnostic-prev)
nnoremap <silent> <leader>2 <Plug>(coc-diagnostic-next)
nnoremap <silent> <leader>3 :<C-u>CocList diagnostics<cr>
" Remap keys for goto
nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gy <Plug>(coc-type-definition)
nnoremap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> gr <Plug>(coc-references)

"nore Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction
"function! s:show_documentation()
"if &filetype == 'vim'
"execute 'h '.expand('<cword>')
"else
"call CocAction('doHover')
"endif
"endfunction

" Show signature help while editing
autocmd CursorHoldI * silent! call CocAction('showSignatureHelp')

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <F2> <Plug>(coc-rename)

" Use `:Format` for format current buffer
command! -nargs=0 CocFormat :call CocAction('format')


augroup filetype_python
    autocmd!
    autocmd FileTYpe python  xnoremap <buffer> <leader>f :CocFormat<CR>
    autocmd FileTYpe python  nnoremap <buffer> <leader>f :CocFormat<CR>
augroup END
" Use `:Fold` for fold current buffer
"command! -nargs=? CocFold :call CocAction('fold', <f-args>)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           ultisnips                            "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 因为不能自动补全关键字,放弃.使用 coc. 加载 honza/vim-ultisnips 的库
" 功能是一样的, 也可以在里面定义代码

"Track the engine.
"Plug 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<tab>"
"let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
"" If you want :UltiSnipsEdit to split your window.
"let g:UltiSnipsEditSplit="vertical"
"let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips"
""编辑当前文件类型的snippet
"nnoremap <leader>es :UltiSnipsEdit<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  lightline                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'itchyny/lightline.vim'
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }
"let g:lightline = {
            "\ 'colorscheme': 'wombat',
            "\ 'active': {
            "\   'left': [ [ 'mode', 'paste' ],
            "\             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
            "\ },
            "\ 'component_function': {
            "\   'gitbranch': 'fugitive#head',
            "\   'cocstatus': 'coc#status',
            "\ }
            "\ }
               ""'cocstatus': 'coc#status',
"let g:lightline = {
      ""\ 'colorscheme': 'wombat',
      "\ 'active': {
      "\   'left': [ [ 'mode', 'paste' ],
      "\             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      "\ },
      "\ 'component_function': {
      "\   'gitbranch': 'gitbranch#name'
      "\ }
      "\ }
"====================================================================================================
"https://github.com/Chiel92/vim-autoformat
"自动缩进,需要一系列的外部程序配合
"Plug 'Chiel92/vim-autoformat'
" 保存后,自动缩进
"au BufWrite * :Autoformat

"====================================================================================================
Plug 'jiangmiao/auto-pairs'
" Jump outside '"({
if !exists('g:AutoPairsShortcutJump')
    let g:AutoPairsShortcutJump = '<C-g>'
endif
"====================================================================================================
"Plug 'AndrewRadev/splitjoin.vim'
"====================================================================================================
" normal mode 下切换输入法
Plug 'ybian/smartim' 
"====================================================================================================
" 更好用的 buffer explorer
Plug 'vim-scripts/bufexplorer.zip'
nnoremap <leader>o :BufExplorerHorizontalSplit<cr>j
" if show help in buffer explorer
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
" 在其他窗口打开文件, 而不是在 buffer explorer 里打开
let g:bufExplorerFindActive=1
" 将未命名 buffer 也显示
let g:bufExplorerShowNoName=1
" 打开时的大小
let g:bufExplorerSplitHorzSize=8
let g:bufExplorerMaxHeight=12
" sort by mru
let g:bufExplorerSortBy='mru'
"====================================================================================================
Plug 'ferrine/md-img-paste.vim'
autocmd FileType markdown nmap <silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>

"====================================================================================================
" 不建议使用https://www.zhihu.com/search?type=content&q=vim
" 建议使用 LeaderfFunction
"Plug 'majutsushi/tagbar'
"map <F8> :TagbarToggle<CR>
"====================================================================================================
"Plug 'posva/vim-vue'
"====================================================================================================
"Plug 'fatih/molokai'
"let g:rehash256 = 1
"let g:molokai_original = 1

"====================================================================================================
"http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
" 对齐任意符号用,visual 选择后 :Tab \:   : 可以是任何你想对齐的符号
Plug 'godlygeek/tabular'
" 对齐 =号. visual 选择后, 按= 号
Plug 'junegunn/vim-easy-align'
vnoremap <silent> <Enter> :EasyAlign<cr> 
"====================================================================================================
"Plug 'plasticboy/vim-markdown'
"====================================================================================================
Plug 'junegunn/seoul256.vim'
"====================================================================================================
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
let g:Lf_ShortcutF = '<c-P>'
let g:Lf_MruFileExclude = ['*.so']

let g:Lf_WildIgnore = {
            \ 'dir': ['.svn','.git','.hg'],
            \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
            \}
let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
nnoremap π :LeaderfFunction!<cr>
nnoremap <leader>m :LeaderfMru<CR>
"let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git|bower_components'
"====================================================================================================
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
" 不显示相对路径
let g:Lf_ShowRelativePath=0
"====================================================================================================
Plug 'vimwiki/vimwiki'
"====================================================================================================
Plug 'tpope/vim-surround'
"====================================================================================================
Plug 'mileszs/ack.vim'
let g:ackhighlight = 1

"====================================================================================================
Plug 'dkprice/vim-easygrep'
"====================================================================================================
Plug 'plasticboy/vim-markdown'
"====================================================================================================
Plug 'sickill/vim-monokai'
"====================================================================================================
Plug 'rhysd/accelerated-jk'
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)
"====================================================================================================
Plug 'tpope/vim-fugitive'
set diffopt+=vertical
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
" show lightline  status of git 
"Plug 'itchyny/vim-gitbranch'
"====================================================================================================
" nerd tree group plugin
"====================================================================================================
" for quick comment
Plug 'scrooloose/nerdcommenter'
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'start'
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
"====================================================================================================
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
let NERDTreeHijackNetrw=1

let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
"let g:NERDTreeWinPos = "right"
let NERDTreeShowHidden=0
let NERDTreeIgnore = ['\.pyc$', '__pycache__','\~$','node_modules']
let g:NERDTreeWinSize=35
"open NERDTree automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
"close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" sync file and nerdtree {{{  so many bugs
" returns true if is NERDTree open/active
function! IsNTOpen()
    return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

"" calls NERDTreeFind iff NERDTree is active, current window contains a modifiable file, and we're not in vimdiff
function! SyncTree()
    if &modifiable && IsNTOpen() && strlen(expand('%')) > 0 && !&diff
        NERDTreeFind
        wincmd p
    endif
endfunction

"autocmd BufEnter * call SyncTree()
"}}}
"====================================================================================================
" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

set rtp+=/usr/local/opt/fzf

"let g:fzf_tags_command = 'ctags --extra=+f -R'
let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   ctags                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Plug 'ludovicchabant/vim-gutentags'
set tags=./.tags;,.tags
" 当filetype 是 python 时,自动加载 python3.7 的 tag
augroup python
    autocmd!
    autocmd FileType python set tags+=/Users/zk/.cache/tags/python3.7.tags
augroup END
" To know when Gutentags is generating tags
set statusline+=%{gutentags#statusline()}
" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
" 仅当发现这些文件后, 才自动生成 tags!
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
let g:gutentags_exclude_filetypes = ['.json',".xlsx",".txt"]

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
"let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
"let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
    silent! call mkdir(s:vim_tags, 'p')
endif

"====================================================================================================
" 在多线程程序下, 输出有问题
"Plug 'skywind3000/asyncrun.vim'

" 自动打开 quickfix window ，高度为 6
let g:asyncrun_open = 10

" 任务结束时候响铃提醒
let g:asyncrun_bell = 1

" 设置 F10 打开/关闭 Quickfix 窗口
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>

"====================================================================================================
" python object depends on  user
Plug 'bps/vim-textobj-python'
Plug 'kana/vim-textobj-user'
"====================================================================================================
" colorscheme 
Plug 'morhetz/gruvbox'


"====================================================================================================
" show  leader key tips
Plug 'liuchengxu/vim-which-key'
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

Plug 'plasticboy/vim-markdown'
set conceallevel=2
let g:vim_markdown_math = 1
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_autowrite = 1

" 在搜索高亮后, 按<leader>z 可以只显示搜索的行
" <leader>Z 显示全部
Plug 'vim-scripts/searchfold.vim'
"  速度很快多光标  c-left  c-right 启动
"  ctrl-n 选择当前光标下相同的单词, 按 c 改变
Plug 'mg979/vim-visual-multi'
" 写文件时,自动创建不存在的文件夹,但是有 bug
Plug 'Carpetsmoker/auto_mkdir2.vim'

" 打开 vim 时的欢迎页
"Plug 'mhinz/vim-startify'
call plug#end()

source ~/.vim/my_plugin/mygrep.vim
" support <c-a>  <c-e>  in insert mode for quick jump out
source ~/.vim/my_plugin/navigation.vim

"theme
"colorscheme peaksea
colorscheme wombat
"colorscheme gruvbox



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           TODO                            
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  快速回到过去编辑的地方
"
"  研究一下 rope 是个什么鬼
"
"  fugitive 要好好学一下.. 好难用
"  


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           tips                            
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 全局搜索
" :Ack <Keyword> --<filetype>

" easygrep 的功能
" 全局搜索
" <leader> vv     
" 全局替换, 可以预览
" <leader> vr      
" 
" 要改变搜索的范围
" : GrepOption  上下移动回车就能改
" 比如要全局交互式替换当前 prject 里的东西
" 则将 GrepOption : 改成 Buffers
" 在要替换的词上面输入 <space>vr
"
" 通过 item 映射了  command + s   --->   :w
"
"   * 与 g* 的区别
"   * 搜索完整的单词     比如搜 lo 那 hello 不会匹配
"   g* 搜索只要匹配就行  比如搜 lo 那 hello 里的 lo 就会匹配
"
" visoj 选中 function 内的 东西
" o 切换 visual 的上端与下端
"
" R 可以在文字上覆盖
"
" ciw '' Esc p 加 "" 的原生方法
" r'f"r' 也是一种挺好的原生方法
" " ctrll+6 在 buffer 中来回切换
"
" 同步NerdTree与当前文件
" :call SyncTree
"
" change folder , 当你需要 ack 时, pwd 就是当前工具目录了
" :cd <folder>
" :cd %:p
"
" 要查询 ctrl-x 啥的
" :help ^x

" 快速窗口管理
" c-w c-w 快速切换
" c-w v    =>  :vsplist
" c-w s    =>  :split
" c-w o    =>  :only
" c-w c    =>  :close
" c-w h/j/i/k   -=> 将光标移到哪个窗口
" c-w H/J/I/K   -=> 将窗口交换
" c-w +/-  =>  :resize +/-  N  也可以不用符号,那就会 resize 到绝对的大小
" c-w </>  =>  :vertical resize +/- N
"
"
"关于 coc 
"跳转用的是jedi 绑定到了 gd, 但是 ctags 也会生成. 可以使用 ctrl+] 跳.
"但很明显 ctags 跳的地方不太对. 尤其是针对系统库
