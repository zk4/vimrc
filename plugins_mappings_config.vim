
call plug#begin('~/.vim/plugged')
" 写 vim wiki 的好工具
"Plug 'vimwiki/vimwiki'

"https://github.com/justinmk/vim-sneak
Plug 'justinmk/vim-sneak'
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1

" sneak
map f <Plug>Sneak_s
map F <Plug>Sneak_S
map f <Plug>Sneak_f
map F <Plug>Sneak_F
"map t <Plug>Sneak_t
"map T <Plug>Sneak_T
"====================================================================================================
" 还行.. 可以直接 n p 键上下
"Plug 'vim-scripts/mru.vim'
"nnoremap <leader>m :Mru<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           coc                            
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Plug 'neoclide/coc.nvim', {'do': './install.sh nightly'}
Plug 'neoclide/coc.nvim', { 'do': 'yarn install --frozen-lockfile'}
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


nmap <silent> <leader>1 <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>2 <Plug>(coc-diagnostic-next)
nmap <silent> <leader>3 :<C-u>CocList diagnostics<cr>
" Remap keys for goto
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

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
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           snippets                            
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 因为不能自动补全关键字,放弃ultisnips.使用 coc. 加载 honza/vim-snippets 的库
" 功能是一样的, 也可以在里面定义代码
Plug 'honza/vim-snippets'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  lightline                                 
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           auto-pairs                            
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'jiangmiao/auto-pairs'
" Jump outside '"({
"if !exists('g:AutoPairsShortcutJump')
    "let g:AutoPairsShortcutJump = '<C-g>'
"endif
let g:AutoPairsFlyMode = 1 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           buffer explorer                            
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 更好用的 buffer explorer
Plug 'vim-scripts/bufexplorer.zip'
"nnoremap <D-e> :BufExplorerHorizontalSplit<cr>j<cr>
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           tabular                            
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
" 对齐任意符号用,visual 选择后 :Tab \:   : 可以是任何你想对齐的符号
Plug 'godlygeek/tabular'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           vim-easy-align                            
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 对齐 =号. visual 选择后, 按= 号
Plug 'junegunn/vim-easy-align'
vnoremap <silent> <Enter> :EasyAlign<cr> 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           leaderF                            
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
let g:Lf_ShortcutF = '<c-P>'
let g:Lf_MruFileExclude = ['*.so']

let g:Lf_WildIgnore = {
            \ 'dir': ['.svn','.git','.hg'],
            \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
            \}
let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_ShowRelativePath=0
nnoremap π :LeaderfFunction!<cr>
nnoremap <leader>m :LeaderfMru<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           vimwiki                            
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'vimwiki/vimwiki'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           vim-surround                            
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'tpope/vim-surround'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           ack                            
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'mileszs/ack.vim'
let g:ackhighlight = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           vim-easygrep                            
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'dkprice/vim-easygrep'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           vim-markdown                            
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'plasticboy/vim-markdown'
" 只用来预览 markdown . 别用它来编辑. 用 typora

set conceallevel=2
let g:vim_markdown_math = 1
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_autowrite = 1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           color-schema                            
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'sickill/vim-monokai'
Plug 'morhetz/gruvbox'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           accelerated-jk                            
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'rhysd/accelerated-jk'
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           fugitive                            
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'tpope/vim-fugitive'
set diffopt+=vertical
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           nerdcommenter                            
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'scrooloose/nerdcommenter'
" for quick comment
" like  <leader>c<leader>  comment  current link

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'start'
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           NERDTree                            
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
"Plug 'Xuyuanp/nerdtree-git-plugin'
"git plugin 禁了.光标上下移动时会闪动
let NERDTreeHijackNetrw=1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeShowHidden=0
let NERDTreeIgnore = ['\.pyc$', '__pycache__','\~$','node_modules']
let g:NERDTreeWinSize=35
"open NERDTree automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
""close vim if the only window left open is a NERDTree
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
if exists("g:NERDTree") && g:NERDTree.IsOpen()
    autocmd VimLeavePre * NERDTreeClose
endif
" 在打开 buffer 时自动将 nerdtree 滚到相应位置
""autocmd BufEnter * call SyncTree()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           fzf                            
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
"                                   ctags                                    
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           object                            
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'bps/vim-textobj-python'
Plug 'kana/vim-textobj-user'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           vim-visual-mutli                            "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'mg979/vim-visual-multi'
nmap ∆  <C-down>  
nmap ˚  <C-up>  
" quick use
" 速度很快多光标  c-left/right/up/down启动
"   <tab> 进入区域选择
"   jklm 将移动选择条
" ctrl-n 选择当前光标下相同的单词, 按 c 改变
" 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           vim-searchindex                            
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'google/vim-searchindex'
" 搜索时,显示当前匹配第几个与总匹配数
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           vim-startify                            
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Plug 'mhinz/vim-startify'
" 打开 vim 时的欢迎页
"Plug 'thaerkh/vim-workspace'
"nnoremap <leader>s :ToggleWorkspace<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           vim_which-key
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Plug 'liuchengxu/vim-which-key'
" show  leader key tips

"nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           iterm2                            "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Plug 'zephod/vim-iterm2-navigator'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           searchfold                            
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Plug 'vim-scripts/searchfold.vim'
" 在搜索高亮后, 按<leader>z 可以只显示搜索的行
" <leader>Z 显示全部
" .vimrc
call plug#end()
