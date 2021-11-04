
call plug#begin('~/.vim/plugged') """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           search
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plug 'easymotion/vim-easymotion'
" nmap s <Plug>(easymotion-s)


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           language -go
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
" https://github.com/fatih/vim-go/wiki/Tutorial

" split and join recommanded by vim-go author
"Plug 'AndrewRadev/splitjoin.vim'
"gS to split the line to multiple lines
"gJ to join multiple lines to one line

" Plug 'fatih/molokai'

" all location list message goes to quickfix
let g:go_list_type = "quickfix"

" use goimports instad of gofmt
let g:go_fmt_command = "goimports"

" https://github.com/fatih/vim-go/issues/2149
" when go.mod exists, godef will not work, add the above line to solve
let g:go_def_mode = 'godef'
" let g:go_def_mode = 'gopls'


augroup guard_group
	autocmd!
	autocmd FileType go nmap <leader>t  <Plug>(go-test)
	autocmd FileType go nmap <leader>r  <Plug>(go-run)
	autocmd FileType go nmap <leader>tf  :GoTestFunc<cr>
	autocmd FileType go nmap <leader>c  <Plug>(go-coverage-toggle)
	autocmd FileType go nmap <leader>cb  <esc>:GoCoverageBrowser<cr>
	autocmd FileType go nmap <leader>f  <Plug>(go-test-func)
	autocmd FileType go nmap <leader>s  <Plug>(go-alternate-edit)
	autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

	autocmd FileType go nmap <leader>ds :GoDebugStart<CR>
	autocmd FileType go nmap <leader>dS :GoDebugStop<CR>
	autocmd FileType go nmap <leader>dn :GoDebugNext<CR>

	autocmd FileType go nmap <F7> :GoDebugStep<CR>
	autocmd FileType go nmap <F8> :GoDebugNext<CR>
	autocmd FileType go nmap <F9> :GoDebugStepOut<CR>

	autocmd FileType go nmap <leader>dc :GoDebugContinue<CR>
	autocmd FileType go nmap <leader>dd :GoDebugBreakpoint<CR>
	autocmd FileType go nmap <leader>d<space> :GoDebugBreakpoint<CR>
	autocmd FileType go nmap <leader>dp :GoDebugPrint
	autocmd FileType go nmap <leader>di :GoDebugStep<CR>
	autocmd FileType go nmap <leader>do :GoDebugStepOut<CR>
	autocmd FileType go nmap <leader>dr :GoDebugRestart<CR>
	autocmd FileType go nmap <leader>dt :GoDebugTest<CR>
" switch between cpp and h file
  autocmd FileType cpp nnoremap <buffer> <leader>s :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
  autocmd FileType c nnoremap <buffer> <leader>s :e %:p:s,.h$,.X123X,:s,.c$,.h,:s,.X123X$,.c,<CR>
augroup END

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           coc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}

" go configuration
" auto imports before save, so slow
" autocmd bufwritepre *.go :call cocaction('runcommand', 'editor.action.organizeimport')
"
" all extension source
" https://www.npmjs.com/search?q=keywords%3acoc.nvim&page=2&perpage=20
"
" gitter
" https://gitter.im/neoclide/coc-cn
"
" show extension
" CocList extensions

Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}

"让coc服务，在neovim启动后，500ms后才启动
let g:coc_start_at_startup=0
function! CocTimerStart(timer)
		exec "CocStart"
endfunction
call timer_start(500,'CocTimerStart',{'repeat':1})

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"解决coc.nvim大文件卡死状况
let g:trigger_size = 0.5 * 1048576

augroup hugefile
	autocmd!
	autocmd BufReadPre *
				\ let size = getfsize(expand('<afile>')) |
				\ if (size > g:trigger_size) || (size == -2) |
				\   echohl WarningMsg | echomsg 'WARNING: altering options for this huge file!' | echohl None |
				\   exec 'CocDisable' |
				\ else |
				\   exec 'CocEnable' |
				\ endif |
				\ unlet size
augroup END

function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction

augroup coc_guard
	autocmd!
	"  正确高亮 jsonc 的注释
	autocmd FileType json syntax match Comment +\/\/.\+$+
	"autocmd FileType java  exec "CocDisable"
	" Close preview window after completion is done
	autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
	" Show signature help while editing
"    autocmd CursorHoldI * silent! call CocAction('showSignatureHelp')

command! -nargs=0 Prettier :CocCommand prettier.formatFi<le
	" Highlight symbol under cursor on CursorHold
"    autocmd CursorHold * silent call CocActionAsync('highlight')
	autocmd FileType *  xnoremap <buffer> <leader>F :CocFormat<CR>
	autocmd FileType *  nnoremap <buffer> <leader>F :CocFormat<CR>
	"autocmd FileType js,html,vue,css  xnoremap <buffer> <leader>F :Prettier<CR>
	"autocmd FileType js.html,vue,css  nnoremap <buffer> <leader>F :Prettier<CR>
	"autocmd FileType *  vmap <leader>f  <Plug>(coc-format-selected)
	"autocmd FileType *  nmap <leader>f  <Plug>(coc-format-selected)
" To enable highlight current symbol on CursorHold
	autocmd CursorHold * silent call CocActionAsync('highlight')

" delete in insert mode in html file is super slow especially in big file
	" autocmd FileType html iunmap <bs>
augroup END

" coc snippet
"编辑当前文件类型的snippet
nnoremap <leader>es :CocCommand snippets.editSnippets<cr>
nnoremap <leader>rr <plug>(coc-rename)
nnoremap <leader>S :CocSearch <C-R>=expand("<cword>")<CR><CR>

imap <Tab> <Plug>(coc-snippets-expand-jump)
inoremap <silent><expr> <TAB>
			\ pumvisible() ? coc#_select_confirm() :
			\ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction
let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'

"nnoremap <expr><C-f> coc#float#has_float() ? coc#util#float_scroll(1) : "\<C-f>"
"nnoremap <expr><C-b> coc#float#has_float() ? coc#util#float_scroll(0) : "\<C-b>"


" Use <c-space> for trigger completion.
inoremap <silent><expr> <C-Space> coc#refresh()

nmap <silent> <leader>1 <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>2 <Plug>(coc-diagnostic-next)
nnoremap <leader>3 :CocAction<cr>
nmap <silent> <leader>4 :<C-u>CocFix<cr>
" Remap keys for goto
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

"nore Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Remap for rename current word
nmap <F2> <Plug>(coc-rename)

" Use `:Format` for format current buffer
command! -nargs=0 CocFormat :call CocAction('format')
command! -nargs=0 Prettier :CocCommand prettier.formatFile
let g:coc_global_extensions=[
 \ 'coc-snippets',
 \ 'coc-pairs',
 \ 'coc-tsserver'
 \]
 " so slow with big file, called  coc#insert
" debug
" CocCommand workspace.showOutput
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           tab
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'godlygeek/tabular'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           vim-easy-align
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 对齐 =号. visual 选择后, 按= 号
"Plug 'junegunn/vim-easy-align'
"vnoremap <silent> <Enter> :EasyAlign<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           leaderF
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
" 搜索中文时会有乱码的情况。
" https://github.com/Yggdroot/LeaderF/issues/203
" 解决方法 git config --global core.quotepath false
"
" ctrl-p 时开头为。
"https://github.com/Yggdroot/LeaderF/issues/567
let g:Lf_ShowDevIcons = 0

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
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           vimwiki
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plug 'vimwiki/vimwiki'
" autocmd FileType markdown nmap <buffer><silent> t :VimwikiTable<cr>
" let g:vimwiki_list = [{'path': '~/bdcloud/notes',
"  \'custom_wiki2html': '$GOPATH/bin/vimwiki-godown',
"                        \ 'syntax': 'markdown', 'ext': '.md'}]

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           ack
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'mileszs/ack.vim'
" let g:ackhighlight = 1
" if executable("ag")
" 	let g:ackprg = 'ag --nogroup --nocolor --column'
" endif
" write ignore directory or file to ~/.ackrc

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


"Plug 'plasticboy/vim-markdown'
""  不要在打开 markdown 时自动折叠, 没蛋用.
"let vim_markdown_folding_disabled = 1

" let g:vim_markdown_conceal=1
" set conceallevel=2
" let g:vim_markdown_conceal_code_blocks = 1


"Plug 'zk4/md-img-paste.vim'
"augroup markdown_vim
"" autocmd FileType markdown nnoremap <buffer><silent> <Leader>i :call <SID>MkdxFzfQuickfixHeaders()<Cr>
"autocmd FileType markdown nmap <buffer><silent> p :call mdip#MarkdownClipboardImage("")<CR>
"autocmd FileType markdown nmap <buffer><silent> P <up>:call mdip#MarkdownClipboardImage("")<CR>
"augroup END

"" there are some defaults for image directory and image name, you can change them
 "let g:mdip_imgdir = 'assets'
" let g:mdip_imgname = 'image'
"Plug 'mzlogin/vim-markdown-toc'
Plug 'iamcco/markdown-preview.nvim',{'do': 'cd app & yarn install'}
" config help
" https://github.com/markdown-it/markdown-it
let g:mkdp_preview_options = {
    \ 'mkit': {"breaks":1,"html":1,"linkify":1},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {}
    \ }
let g:mkdp_auto_close = 0
let g:mkdp_markdown_css="/Users/zk/vue.css"


augroup gp_group
	autocmd!
	autocmd FileType markdown nnoremap <buffer> gp :MarkdownPreview<cr>


augroup END
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           color-schema
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'morhetz/gruvbox'

" Plug 'sheerun/vim-wombat-scheme'
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
" make gpush async
"Plug 'tpope/vim-dispatch'
" easy mapping for fugitive
Plug 'tpope/vim-unimpaired'
" for github
Plug 'tpope/vim-rhubarb'

Plug 'tpope/vim-surround'
set diffopt+=vertical
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
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
"                           NERDTree
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           language-jsx
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'mxw/vim-jsx'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           fzf
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" https://bluz71.github.io/2018/12/04/fuzzy-finding-in-vim-with-fzf.html
" https://github.com/junegunn/fzf/wiki
" this is a good place to learn fzf
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

set rtp+=/usr/local/opt/fzf

nnoremap <c-p> :GFiles<CR>
nnoremap <leader>p :Files<CR>
"nnoremap <leader>P :Files<CR>
"nnoremap <leader>f :Rg<CR>
"nnoremap <leader>pw :Rg <C-R>=expand("<cword>")<CR><CR>


" search md ,this is very good for search code snippets in markdown
" Plug 'alok/notational-fzf-vim'
" let g:nv_search_paths = ['~/bdcloud/notes']
" if not found, creat note with ctrl-x
" let g:nv_create_note_key = 'ctrl-x'
" let g:fzf_preview_window = 'right:60%'
" nnoremap <leader>n  <esc>:NV<cr>
"nmap <c-m>  :Marks<cr>


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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   ctags
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Plug 'ludovicchabant/vim-gutentags'

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           object
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'bps/vim-textobj-python'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'terryma/vim-expand-region'
Plug 'whatyouhide/vim-textobj-xmlattr'
map vv <Plug>(expand_region_expand)
"map J <plug>(expand_region_shrink)

" let g:expand_region_use_select_mode = 1
let g:expand_region_text_objects = {
      \ 'i}'  :1,
      \ 'i)'  :1,
      \ 'i`'  :1,
      \ 'i>'  :1,
      \ 'i"'  :1,
      \ 'i''' :1,
      \ 'il' :1,
      \ 'ia' :1,
      \ 'iW' :1,
      \ 'i]'  :1
      \ }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           vim-visual-mutli                            "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'mg979/vim-visual-multi'
"Plug 'terryma/vim-multiple-cursors'
" nmap ∆  <C-down>
" nmap ˚  <C-up>
" quick use
" 速度很快多光标  c-left/right/up/down启动
"   <tab> 进入区域选择
"   jklm 将移动选择条
" ctrl-n 选择当前光标下相同的单词, 按 c 改变

" 会导致 vim 假死
" Plug 'terryma/vim-multiple-cursors'
" let g:multi_cursor_select_all_word_key = '<c-a>'


Plug 'wellle/targets.vim'
let g:targets_nl = 'np'
" a cheetsheet for that
" https://github.com/wellle/targets.vim/blob/master/cheatsheet.md

"Targets.vim is a Vim plugin that adds various text objects to give you more targets to operate on. It expands on the idea of simple commands like di' (delete inside the single quotes around the cursor) to give you more opportunities to craft powerful commands that can be repeated reliably. One major goal is to handle all corner cases correctly.


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           kitty                            "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" I don` need this.. it navigate from kitty  vim seamlessly
Plug 'knubie/vim-kitty-navigator'
set title
let &titlestring='%t - nvim'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           vim-searchindex
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'google/vim-searchindex'
" 搜索时,显示当前匹配第几个与总匹配数

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           vim-workspace
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"使用 leader-s 切换是否创建工程
"在打开当前文件夹时，可以回到工程现场

"Plug 'thaerkh/vim-workspace'
"let g:workspace_persist_undo_history = 0
"let g:workspace_autocreate =1
"let g:workspace_session_name = '.Session.vim'
""all trailing spaces will not be removed upon autosave.
"let g:workspace_autosave_untrailspaces = 0
"let g:workspace_autosave_ignore = ['gitcommit']
"nnoremap <leader>s :ToggleWorkspace<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           vim_which-key
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" wil cause crash
Plug 'liuchengxu/vim-which-key'
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           inscearch
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'bronson/vim-visual-star-search'


""""""""""""""""""""""
"  window managment  "
""""""""""""""""""""""
" Plug 'pmalek/toogle-maximize.vim'
" nmap <silent> <c-m> :call ToggleMaximizeCurrentWindow()<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           others
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'stephpy/vim-yaml'


Plug 'junegunn/vim-peekaboo'
" when press  " or @, will pop the resgiter on the right side


" let g:peekaboo_ins_prefix= '<c-x>'

" Plug 'yuttie/comfortable-motion.vim'
" let g:comfortable_motion_friction = 200.0
" let g:comfortable_motion_air_drag = 10.0
" let g:comfortable_motion_no_default_key_mappings = 1
" let g:comfortable_motion_impulse_multiplier = 1  " Feel free to increase/decrease this value.
" nnoremap <silent> <C-d> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 2)<CR>
" nnoremap <silent> <C-u> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -2)<CR>
" nnoremap <silent> <C-f> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 4)<CR>
" nnoremap <silent> <C-b> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -4)<CR>
"Plug 'vim-scripts/loremipsum'
" Plug 'honza/vim-snippets'

""""""""""""""""""""""
"  undo history   "
""""""""""""""""""""""
 Plug 'mbbill/undotree'
 if has("persistent_undo")
		set undodir=~/.vim_undo
		set undofile
 endif

Plug 'tpope/vim-abolish'
" 这个插件有两个牛 b 的功能
" 1. ：S/{dog,man}/{man,dog}/g
" 2. 驼峰转换
"  Want to turn fooBar into foo_bar? Press crs (coerce to snake_case). MixedCase (crm), camelCase (crc), snake_case (crs), UPPER_CASE (cru), dash-case (cr-), dot.case (cr.), space case (cr<space>), and Title Case (crt) are all just 3 keystrokes away.

" Plug 'vifm/vifm.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_experimental_template_highlight = 1


Plug 'preservim/nerdcommenter'
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' },'js': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1

Plug 'terryma/vim-expand-region'


" for typescript highligh , 自带的有 bug
Plug 'leafgarland/typescript-vim'


Plug 'dhruvasagar/vim-open-url'
nmap gx <Plug>(open-url-browser)
vmap gx <Plug>(open-url-browser)

call plug#end()


