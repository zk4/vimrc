
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
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
" https://bluz71.github.io/2018/12/04/fuzzy-finding-in-vim-with-fzf.html
" https://github.com/junegunn/fzf/wiki

let g:fzf_buffers_jump = 1
set rtp+=/usr/local/opt/fzf
nnoremap <c-p> :GFiles<CR>
nnoremap <leader>fp :Files<CR>
nnoremap <leader>fr :Rg<CR>
nnoremap <leader>fgs :GFiles?<CR>
nnoremap <leader>fgc :BCommits?<CR>
" mru
nnoremap <leader>fm :History<CR>
nnoremap <leader>fc :History:<CR>

"Hide statusline
if has('nvim') && !exists('g:fzf_layout')
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
endif


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


" Plug 'projekt0n/github-nvim-theme'

Plug 'mg979/vim-visual-multi'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           contextual comments
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'numToStr/Comment.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
" these 3 files configs in 'lua.vim'
call plug#end()

so ~/.zk_vimrc/conf/lua_config.vim
