
call plug#begin('~/.vim/plugged')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           cursor & motions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Plug 'rhysd/accelerated-jk'
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)


Plug 'easymotion/vim-easymotion'
nmap s <Plug>(easymotion-s)



Plug 'wellle/targets.vim'
"DEMO:
"1. cint  change in next tag

"2.      ............
" a ( b ( cccccccc ) d ) e
"    │   └── i) ──┘   │
"    └───── 2i) ──────┘

Plug 'bps/vim-textobj-python'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'terryma/vim-expand-region'
Plug 'whatyouhide/vim-textobj-xmlattr'
Plug 'inside/vim-textobj-jsxattr'
Plug 'neoclide/vim-jsx-improve'
map vv <Plug>(expand_region_expand)
"map J <plug>(expand_region_shrink)

" let g:expand_region_use_select_mode = 1
let g:expand_region_text_objects = {
      \ 'iw'  :0,
      \ 'iW'  :0,
      \ 'i"'  :0,
      \ 'i''' :0,
      \ 'i]'  :1,
      \ 'ib'  :1,
      \ 'iB'  :1,
      \ 'il'  :0,
      \ 'ip'  :0,
      \ 'ie'  :0,
      \ }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           LSP & snippets
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
so ~/.zk_vimrc/conf/coc_config.vim




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           vim-table-format
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" below sinpet code will align | when in insert mode. super cool , like the
" dhruvasagar/vim-table-mode plugin does
" https://gist.github.com/tpope/287147
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           git
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'tpope/vim-unimpaired'
" for github
Plug 'tpope/vim-rhubarb'

Plug 'tpope/vim-surround'

Plug 'tpope/vim-fugitive'
set diffopt+=vertical
set statusline+=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
autocmd FileType gitcommit set foldmethod=syntax
nnoremap <C-g>s <esc>:Git<cr>
"nnoremap <C-g>p <esc>:Gpush<cr>
nnoremap <C-g>c :Gcommit -v -q<CR>
nnoremap <C-g>a :Gcommit --amend<CR>
nnoremap <C-g>t :Gcommit -v -q %<CR>
nnoremap <C-g>d :Gdiff<CR>
nnoremap <C-g>e :Gedit<CR>
nnoremap <C-g>r :Gread<CR>
nnoremap <C-g>w :Gwrite<CR><CR>
nnoremap <C-g>l :silent! 0Glog <CR>
nnoremap <C-g>g :Ggrep<Space>
nnoremap <C-g>m :Gmove<Space>
nnoremap <C-g>b :Git branch<Space>
nnoremap <C-g>o :Git checkout<Space>
nnoremap <C-g>p :Git push <CR>
nnoremap <C-g>P :!x git pull <CR>



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   ctags
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plug 'ludovicchabant/vim-gutentags'
"
" " let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
"
" " 有时候有些大型工程都是 git 管理，还是手动创建这个文件较好
" let g:gutentags_project_root = ['+tags']
"
"
" "" 所生成的数据文件的名称
" let g:gutentags_ctags_tagfile = '.tags'
"
" "" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
" let s:vim_tags = expand('~/.cache/tags')
" let g:gutentags_cache_dir = s:vim_tags
"
" "" 配置 ctags 的参数
" let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
" let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
" let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
"
" "" 检测 ~/.cache/tags 不存在就新建
" if !isdirectory(s:vim_tags)
"    silent! call mkdir(s:vim_tags, 'p')
" endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           seamless roaming                            "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" this is better one for nerdtree, it`s async
Plug 'jojoyuji/nerdtree-async'
"git plugin 禁了.光标上下移动时会闪动
let NERDTreeHijackNetrw=1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeShowHidden=0
let NERDTreeIgnore = ['\.pyc$', '__pycache__','\~$']
let g:NERDTreeWinSize=25

"open NERDTree automatically when vim starts up on opening a directory
augroup nerdtree_guard
	autocmd!
	" autocmd FileType nerdtree nmap  <buffer> + :vertical resize +1<cr>
	" autocmd FileType nerdtree nmap  <buffer> - :vertical resize -1<cr>
	autocmd StdinReadPre * let s:std_in=1
	autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
	autocmd FileType *  nnoremap  gs :NERDTreeFind<CR>
	if exists("g:NERDTree") && g:NERDTree.IsOpen()
		autocmd VimLeavePre * NERDTreeClose
	endif
augroup END

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

" 在打开 buffer 时自动将 nerdtree 滚到相应位置
" autocmd BufEnter * call SyncTree()
nnoremap <f3> :call SyncTree()<cr>

nnoremap <C-\> :NERDTreeToggle  <CR> :vertical resize 25<CR>
inoremap <C-\> <esc>:NERDTreeToggle <cr> :vertical resize 25<CR>
nnoremap <leader>w :cd %:p:h <cr> : NERDTreeCWD<cr>  <C-w>l



" I don` need this.. it navigate from kitty  vim seamlessly
Plug 'knubie/vim-kitty-navigator'
set title
let &titlestring='%t - nvim'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           find stuff
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
" 搜索中文时会有乱码的情况。
" https://github.com/Yggdroot/LeaderF/issues/203
" 解决方法 git config --global core.quotepath false
"
" ctrl-p 时开头为。
"https://github.com/Yggdroot/LeaderF/issues/567
let g:Lf_ShowDevIcons = 1

"let g:Lf_ShortcutF = '<c-p>'
let g:Lf_MruFileExclude = ['*.so',"*.pyc"]

"  show in pop window
" let g:Lf_WindowPosition = 'popup'

let g:Lf_UseVersionControlTool=0
let g:Lf_WildIgnore = {
            \ 'dir': ["site-packages",".mypy_cache",'.svn','.git','.hg',".undodir",".*"],
            \ 'file': ["\.",".DS_Store","NERD_tree_*",'*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
            \}
let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_ShowRelativePath=1
let g:Lf_PreviewResult = {
            \ 'File': 1,
            \ 'Buffer': 1,
            \ 'Mru': 1,
            \ 'Tag': 1,
            \ 'BufTag': 1,
            \ 'Function': 1,
            \ 'Line': 1,
            \ 'Colorscheme': 1
            \}
"nnoremap π :LeaderfFunction!<cr>
nnoremap <leader>m :LeaderfMru<CR>
nnoremap <leader>i :LeaderfFunction<CR>

nnoremap <leader>o :LeaderfBuffer<cr>
nnoremap <leader>g :Leaderf rg<cr>
nnoremap <leader>G :Leaderf rg<cr>

Plug 'junegunn/fzf.vim'
" https://bluz71.github.io/2018/12/04/fuzzy-finding-in-vim-with-fzf.html
" https://github.com/junegunn/fzf/wiki
" Plug 'junegunn/fzf', { 'do': './install --bin' }
"
let g:fzf_buffers_jump = 1

set rtp+=/usr/local/opt/fzf

nnoremap <c-p> :GFiles<CR>
nnoremap <leader>p :Files<CR>
"nnoremap <leader>P :Files<CR>
"nnoremap <leader>f :Rg<CR>
"nnoremap <leader>pw :Rg <C-R>=expand("<cword>")<CR><CR>


"command! -bang -nargs=? -complete=dir Tags
   "\ call fzf#vim#tags(<q-args>, {'options': '--preview-window="80%" --preview "echo {4}"'}, <bang>0)

"command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4.. --preview-window="80%" --preview "echo {}"'}, <bang>0)

"command! -bang -nargs=* Rg
  "\ call fzf#vim#grep(
  "\   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  "\   fzf#vim#with_preview(), <bang>0)


"Hide statusline
if has('nvim') && !exists('g:fzf_layout')
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
endif


"autocmd FileType *  xnoremap <buffer> <leader>f :Rg<CR>
"autocmd FileType *  nnoremap <buffer> <leader>f :Rg<CR>


command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

command! -bang BTags
  \ call fzf#vim#buffer_tags('', {
  \     'down': '40%',
  \     'options': '--with-nth 1
  \                 --reverse
  \                 --prompt "> "
  \                 --preview-window="80%"
  \                 --preview "
  \                     tail -n +\$(echo {3} | tr -d \";\\\"\") {2}  |
  \                     head -n 16"'
  \ })

Plug 'mileszs/ack.vim'
" let g:ackhighlight = 1
" if executable("ag")
" 	let g:ackprg = 'ag --nogroup --nocolor --column'
" endif
" write ignore directory or file to ~/.ackrc
" 搜索时,显示当前匹配第几个与总匹配数
Plug 'google/vim-searchindex'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

function! SearchCount()
    let keyString=@/
    let pos=getpos('.')
    try
        redir => nth
        silent exe '0,.s/' . keyString . '//ne'
        redir => cnt
        silent exe '%s/' . keyString . '//ne'
        redir END
        return matchstr( nth, '\d\+' ) . '/' . matchstr( cnt, '\d\+' )
    finally
        call setpos('.', pos)
    endtry
endfunction
set statusline+=[%{SearchCount()}] " Nth of N when searching

Plug 'mbbill/undotree'
if has("persistent_undo")
	set undodir=~/.vim_undo
	set undofile
endif

Plug 'morhetz/gruvbox'

Plug 'godlygeek/tabular'

Plug 'mg979/vim-visual-multi'
"Plug 'terryma/vim-multiple-cursors'
" nmap ∆  <C-down>
" nmap ˚  <C-up>
" quick use
" 速度很快多光标  c-left/right/up/down启动
"   <tab> 进入区域选择
"   jklm 将移动选择条
" ctrl-n 选择当前光标下相同的单词, 按 c 改变

"Plug 'junegunn/vim-easy-align'
" 对齐 =号. visual 选择后, 按= 号
"vnoremap <silent> <Enter> :EasyAlign<cr>


" Plug 'terryma/vim-expand-region'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           contextual comments
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'numToStr/Comment.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
nnoremap <leader>c gcc
" these 3 files configs in 'lua.vim'

call plug#end()

