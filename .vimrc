"PlugClean tips
"
" visoj 选中 function 内的 东西
" o 切换 visual 的上端与下端
"t9t 可以在文字上覆盖
"
" ciw '' Esc p 加 "" 的原生方法
" r'f"r' 也是一种挺好的原生方法
"
" ctrll+6 在 buffer 中来回切换
"
"
"

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"设定 vim 的编码,
scriptencoding utf-8
set encoding=utf-8
set fileencoding=utf-8
set runtimepath+=~/.vim
set foldmethod=indent

" if fold file when open . 99: don` fold   0: fold     :help foldlevelstart
set foldlevel=99

" global variables {{{
let g:jedi#force_py_version = 3
let g:python2_host_prog     = '/usr/local/bin/python'
let g:python3_host_prog     = '/usr/local/bin/python3'
" }}}

" 不开启这个打开py文件会出现莫名其妙的错
silent! py3 pass

" 设置 leader {{{
"let mapleader=" "
"let maplocalleader =" "
let mapleader=" "
let maplocalleader =" "
" 在选择模式下, 将 space 也强制应于 leader, 不然会导致 space 真成空格了,
" 面晃会触发 leader
vnoremap <space> <Nop>
"}}}

" autocmd {{{
" quit vim help with q instad of :q
autocmd FileType help noremap <buffer> q :q<cr>
autocmd FileType qf  noremap <buffer> q :q<cr>
autocmd FileTYpe gitcommit noremap <buffer> q :q<cr>
"  折叠 vim 脚本代码, za 开启与关闭, 下面注释的 {{{  }}}很重要, 不然不知道从哪折起哦!
"  {{{
augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
augroup END
"}}}

" 在保存.vimrc 后,自动刷新
autocmd! bufwritepost $HOME/.vimrc source %

" 保存后格式化
"autocmd BufWritePre * :normal gg=G

" }}}
" set gvim font size
if has("gui_running")
	set guifont=Droid\ Sans\ Mono\ Nerd\ Font\ Complete:h18
endif
" if show status line when only one window shown
set laststatus=2

" Add a bit extra margin to the left
"set foldcolumn=1


" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile


"set t_Co=256

"theme
"color monokai
"color wombat
"colorscheme peaksea

colorscheme wombat
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
set wildmenu wildmode=full

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
"filetype plugin on          " 针对不同的文件类型加载对应的插件
"set nobackup                " 设置无备份文件
"set nocompatible            " 不使用vi兼容的模式

" 设置光标反色:
"hi Cursor gui=reverse guibg=NONE guifg=NONE
"hi CursorLine gui=reverse

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
if has('vim')
	function s:MkNonExDir(file, buf)
		if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
			let dir=fnamemodify(a:file, ':h')
			if !isdirectory(dir)
				call mkdir(dir, 'p')
			endif
		endif
	endfunction
	:set guicursor=
endif

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

"====================================================================================================
" map
"====================================================================================================
"编辑当前文件类型的snippet
nnoremap <leader>es :CocCommand snippets.editSnippets<cr>
" 全用不需要转义的正则表达式搜索
nnoremap / ms/\v
nnoremap ? ms?\v

" select all
nnoremap <leader>a  ggVG

" open vifm
nnoremap <leader>1 :!vifm<cr>

"map zz to za in normal mode
nnoremap zz  za

" sudo write
cnoremap w!! w !sudo tee > /dev/null %

" navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
"set pastetoggle=<F9>


""""""""""""""""""""""
"Quick Run
""""""""""""""""""""""
noremap <F5> :call CompileRunGcc()<CR>
"function! IfPomXmlExists()
		"" define your commands here..
		"map <buffer> <C-F9> :echo "hello pom!"<CR>
	"endif
"endfunction
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
		exec "!time ./%<"
	"elseif &filetype == 'java'
		""exec "!clear && source ~/.bash_profile &&    mvnexec"
		"exec "!clear && javac % && java %<"
         ""exec "!time java %<"
	elseif &filetype == 'xml'
		exec "!clear && pwd &&mvn package -DskipTests &&  java  -jar -XX:+TraceClassLoading target/*.jar "
		"exec "!clear && source ~/.bash_profile &&    mvnexec"
         "exec "!time java %<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'


		exec "!clear &&  python3 % -10"
	elseif &filetype == 'html'
		exec "!open % &"
	elseif &filetype == 'go'
		"        exec "!go build %<"
		exec "!time go run %"
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
" create tab
nnoremap <leader>te :tabe<cr>
" close tab
nnoremap <leader>tc :tabc<cr>

" close buffer
nnoremap <leader>bd :bd<cr>
" close buffer
nnoremap <leader>bda :bwipe<cr>



nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)
"快速打开配置文件
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>ep :e ~/.bash_profile<cr>
" 快速  edit  snippet c
"nnoremap <leader>esc :e /Users/zk/.config/coc/extensions/node_modules/HdsCppSnippets/snippets/c_hds.json<cr>

nnoremap <leader>g :Ack<space>
nnoremap <C-\> :NERDTreeToggle<CR>
inoremap <C-\> <esc>:NERDTreeToggle<CR>




nnoremap <Leader><leader> :Commands<CR>

"Alternatively, you could use this mapping so that the final /g is already entered:
nnoremap <Leader>r :%s/\<<C-r><C-w>\>/
"nnoremap ,, <esc>A,
" format file without cursor moving to head, and move cursor the middle of screen
nnoremap <leader>f mmgg=G`mzz
" move page down with cursor in the middle of screen
nnoremap <C-f> <C-d>zz
" move page up with cursor in the middle of screen
nnoremap <C-b> <C-u>zz
" mru files
nnoremap <leader>m :Mru<CR>

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
nnoremap f <Plug>Sneak_s
nnoremap F <Plug>Sneak_S
nnoremap f <Plug>Sneak_f
nnoremap F <Plug>Sneak_F
nnoremap t <Plug>Sneak_t
nnoremap T <Plug>Sneak_T

"====================================================================================================
Plug 'vim-scripts/mru.vim'
"====================================================================================================
" auto complete
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
let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<S-Tab>'

"  正确高亮 jsonc 的注释
autocmd FileType json syntax match Comment +\/\/.\+$+

"====================================================================================================
Plug 'itchyny/lightline.vim'
let g:lightline = {
			\ 'colorscheme': 'wombat',
			\ 'active': {
			\   'left': [ ['mode', 'paste'],
			\             ['fugitive', 'readonly', 'filename', 'modified'] ],
			\   'right': [ [ 'lineinfo' ], ['percent'] ]
			\ },
			\ 'component': {
			\   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
			\   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
			\   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
			\ },
			\ 'component_visible_condition': {
			\   'readonly': '(&filetype!="help"&& &readonly)',
			\   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
			\   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
			\ },
			\ 'separator': { 'left': ' ', 'right': ' ' },
			\ 'subseparator': { 'left': ' ', 'right': ' ' },
			\ }
"====================================================================================================
"https://github.com/Chiel92/vim-autoformat
"自动缩进,需要一系列的外部程序配合
Plug 'Chiel92/vim-autoformat'
" 保存后,自动缩进
"au BufWrite * :Autoformat

"====================================================================================================
Plug 'jiangmiao/auto-pairs'
" Jump outside '"({
if !exists('g:AutoPairsShortcutJump')
	let g:AutoPairsShortcutJump = '<C-g>'
endif
"====================================================================================================
Plug 'AndrewRadev/splitjoin.vim'

"====================================================================================================


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
Plug 'posva/vim-vue'
"====================================================================================================
Plug 'fatih/molokai'
let g:rehash256 = 1
let g:molokai_original = 1

"====================================================================================================
"http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
" 对齐 = 号用的
Plug 'godlygeek/tabular'

Plug 'junegunn/vim-easy-align'
vnoremap <silent> <Enter> :EasyAlign<cr> 


"====================================================================================================
"Plug 'plasticboy/vim-markdown'
"====================================================================================================
Plug 'junegunn/seoul256.vim'
"====================================================================================================
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
let g:Lf_ShortcutF = '<c-P>'

nnoremap π :LeaderfFunction!<cr>
"let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git|bower_components'
"====================================================================================================
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
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
"====================================================================================================
Plug 'tpope/vim-fugitive'
set diffopt+=vertical

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

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
	exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
	exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
call NERDTreeHighlightFile('mp3', 'Magenta', 'none', '#ff00ff', '#151515')

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

let g:fzf_tags_command = 'ctags --extra=+f -R'
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

"Plug 'ludovicchabant/vim-gutentags'
"set tags=./.tags;,.tags

"" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
"let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

"" 所生成的数据文件的名称
"let g:gutentags_ctags_tagfile = '.tags'

"" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
"let s:vim_tags = expand('~/.cache/tags')
"let g:gutentags_cache_dir = s:vim_tags

"" 配置 ctags 的参数
"let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
"let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
"let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

"" 检测 ~/.cache/tags 不存在就新建
"if !isdirectory(s:vim_tags)
   "silent! call mkdir(s:vim_tags, 'p')
"endif
"====================================================================================================
" 在多线程程序下, 输出有问题
"Plug 'skywind3000/asyncrun.vim'

"" 自动打开 quickfix window ，高度为 6
"let g:asyncrun_open = 6

"" 任务结束时候响铃提醒
""let g:asyncrun_bell = 1

"" 设置 F10 打开/关闭 Quickfix 窗口
"nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>

"====================================================================================================
"Plug 'ryanoasis/vim-devicons'

"====================================================================================================
"Plug 'pangloss/vim-javascript'
"====================================================================================================
" python object depends on  user
Plug 'bps/vim-textobj-python'
Plug 'kana/vim-textobj-user'
call plug#end()


source ~/.vim/my_plugin/mygrep.vim
" support <c-a>  <c-e>  in insert mode for quick jump out
source ~/.vim/my_plugin/navigation.vim
