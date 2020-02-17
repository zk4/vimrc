
call plug#begin('~/.vim/plugged')
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           search                            
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'easymotion/vim-easymotion'
nmap s <Plug>(easymotion-s)


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           language -go                            
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
" https://github.com/fatih/vim-go/wiki/Tutorial

" split and join recommanded by vim-go author
Plug 'AndrewRadev/splitjoin.vim'
"gS to split the line to multiple lines 
"gJ to join multiple lines to one line

Plug 'fatih/molokai'

" all location list message goes to quickfix
let g:go_list_type = "quickfix"

" use goimports instad of gofmt
let g:go_fmt_command = "goimports"

augroup guard_group 
	autocmd!
	autocmd FileType go nmap <leader>t  <Plug>(go-test)
	autocmd FileType go nmap <leader>tf  :GoTestFunc<cr>
	autocmd FileType go nmap <leader>c  <Plug>(go-coverage-toggle)
	autocmd FileType go nmap <leader>cb  <esc>:GoCoverageBrowser<cr>
	autocmd FileType go nmap <leader>f  <Plug>(go-test-func)
	autocmd FileType go nmap <leader>v  <Plug>(go-alternate-edit)
	autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
	autocmd FileType go nmap <leader>ds :GoDebugStart<CR>
	autocmd FileType go nmap <leader>dS :GoDebugStop<CR>
	autocmd FileType go nmap <leader>dn :GoDebugNext<CR>
	autocmd FileType go nmap <leader>dc :GoDebugContinue<CR>
	autocmd FileType go nmap <leader>dd :GoDebugBreakpoint<CR>
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
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" go configuration 
" auto imports before save
" autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

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
	" Close preview window after completion is done
	autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
	" Show signature help while editing
"    autocmd CursorHoldI * silent! call CocAction('showSignatureHelp')

	" Highlight symbol under cursor on CursorHold
"    autocmd CursorHold * silent call CocActionAsync('highlight')
	autocmd FileTYpe *  xnoremap <buffer> <leader>f :CocFormat<CR>
	autocmd FileTYpe *  nnoremap <buffer> <leader>f :CocFormat<CR>
" To enable highlight current symbol on CursorHold
	autocmd CursorHold * silent call CocActionAsync('highlight')

"    autocmd FileType javascript let b:coc_pairs_disabled = ['>']
augroup END

" coc snippet
"编辑当前文件类型的snippet
nnoremap <leader>es :CocCommand snippets.editSnippets<cr>



" tab for completion and jump placehoders
" https://github.com/neoclide/coc-snippets
" method 1
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


" method 2 
" this won`t trigger auto-completion if expansion is on the fly
" and another cavet is allowing you tab after word in normal line
" inoremap <expr> <Tab> pumvisible() ? "\<C-y>" : "\<Tab>"
" let g:coc_snippet_next = '<TAB>'
" let g:coc_snippet_prev = '<S-TAB>'

nnoremap <expr><C-f> coc#util#has_float() ? coc#util#float_scroll(1) : "\<C-f>"
nnoremap <expr><C-b> coc#util#has_float() ? coc#util#float_scroll(0) : "\<C-b>"


" Use <c-space> for trigger completion.
inoremap <silent><expr> <C-Space> coc#refresh()

nmap <silent> <leader>1 <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>2 <Plug>(coc-diagnostic-next)
nmap <silent> <leader>4 <Plug>(coc-diagnostic-next)
nmap <silent> <leader>3 :<C-u>CocList diagnostics<cr>
" Remap keys for goto
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

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
 \ 'coc-tsserver',
 \ 'coc-eslint',
 \ 'coc-json',
 \]
" so slow with big file, called  coc#insert

" autocmd Filetype * iunmap  <bs>
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
"                           buffer explorer                            
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 更好用的 buffer explorer
"Plug 'vim-scripts/bufexplorer.zip'
"""nnoremap <D-e> :BufExplorerHorizontalSplit<cr>j<cr>
"nnoremap <leader>o :BufExplorerHorizontalSplit<cr>j
"" if show help in buffer explorer
"let g:bufExplorerDefaultHelp=0
"let g:bufExplorerShowRelativePath=1
"" 在其他窗口打开文件, 而不是在 buffer explorer 里打开
"let g:bufExplorerFindActive=1
"" 将未命名 buffer 也显示
"let g:bufExplorerShowNoName=1
"" 打开时的大小
"let g:bufExplorerSplitHorzSize=8
"let g:bufExplorerMaxHeight=12
"" sort by mru
"let g:bufExplorerSortBy='mru'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           tab
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plug 'godlygeek/tabular'
" 基于 ai 的代码补全
"Plug 'zxqfl/tabnine-vim'

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
let g:Lf_ShortcutF = '<c-p>'
let g:Lf_MruFileExclude = ['*.so',"*.pyc"]

"  show in pop window
" let g:Lf_WindowPosition = 'popup'

let g:Lf_UseVersionControlTool=0
let g:Lf_WildIgnore = {
            \ 'dir': [".mypy_cache",'.svn','.git','.hg',".undodir",".*"],
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
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           vimwiki                            
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plug 'vimwiki/vimwiki'
" autocmd FileType markdown nmap <buffer><silent> t :VimwikiTable<cr>
" let g:vimwiki_list = [{'path': '~/bdcloud/notes',
"  \'custom_wiki2html': '$GOPATH/bin/vimwiki-godown',
"                        \ 'syntax': 'markdown', 'ext': '.md'}]

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           vim-surround                            
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 教程
"http://www.futurile.net/2016/03/19/vim-surround-plugin-tutorial/
Plug 'tpope/vim-surround'
"support vim surround repeat
Plug 'tpope/vim-repeat'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           comment                            
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'tpope/vim-commentary'
Plug 'suy/vim-context-commentstring'
vnoremap <leader>c<leader> :Commentary<cr>
nnoremap <leader>c<leader> :Commentary<cr>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           ack                            
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'mileszs/ack.vim'
" let g:ackhighlight = 1
" if executable("ag")
" 	let g:ackprg = 'ag --nogroup --nocolor --column'
" endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           vim-markdown                            
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

 " Plug 'dhruvasagar/vim-table-mode'

 " function! s:isAtStartOfLine(mapping)
 "   let text_before_cursor = getline('.')[0 : col('.')-1]
 "   let mapping_pattern = '\V' . escape(a:mapping, '\')
 "   let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
 "   return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
 " endfunction

 " inoreabbrev <expr> <bar><bar>
 "           \ <SID>isAtStartOfLine('\|\|') ?
 "           \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
 " inoreabbrev <expr> __
 "           \ <SID>isAtStartOfLine('__') ?
 "           \ '<c-o>:silent! TableModeDisable<cr>' : '__'

 " let g:table_mode_corner='|'
 

" ----------------------------------------------------------------------------------------------------
" below sinpet code will align | when in insert mode. super cool , like the
" dhruvasagar/vim-table-mode plugin does 
" https://gist.github.com/tpope/287147
" inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

" function! s:align()
"   let p = '^\s*|\s.*\s|\s*$'
"   if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
"     let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
"     let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
"     Tabularize/|/l1
"     normal! 0
"     call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
"   endif
" endfunction

" ----------------------------------------------------------------------------------------------------




" Plug 'SidOfc/mkdx'
" :h mkdx-settings
" let g:mkdx#settings = {
"       \ 'image_extension_pattern': 'a\?png\|jpe\?g\|gif',
"       \ 'restore_visual':          1,
"       \ 'enter':                   { 'enable': 0, 'malformed': 0, 'o': 0,
"       \                              'shifto': 0, 'shift': 0 },
"       \ 'map':                     { 'prefix': '<leader>', 'enable': 1 },
"       \ 'tokens':                  { 'enter': ['-', '*', '>'],
"       \                              'bold': '**', 'italic': '*', 'strike': '',
"       \                              'list': '-', 'fence': '',
"       \                              'header': '#' },
"       \ 'checkbox':                { 'toggles': [' ', '-', 'x'],
"       \                              'update_tree': 2,
"       \                              'initial_state': ' ' },
"       \ 'toc':                     { 'text': "TOC", 'list_token': '-',
"       \                              'update_on_write': 0,
"       \                              'position': 0,
"       \                              'details': {
"       \                                 'enable': 0,
"       \                                 'summary': 'Click to expand {{toc.text}}',
"       \                                 'nesting_level': -1,
"       \                                 'child_count': 5,
"       \                                 'child_summary': 'show {{count}} items'
"       \                              }
"       \                            },
"       \ 'table':                   { 'divider': '|',
"       \                              'header_divider': '-',
"       \                              'align': {
"       \                                 'left':    [],
"       \                                 'center':  [],
"       \                                 'right':   [],
"       \                                 'default': 'center'
"       \                              }
"       \                            },
"       \ 'links':                   { 'external': {
"       \                                 'enable': 0, 'timeout': 3, 'host': '', 'relative': 1,
"       \                                 'user_agent':  'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/9001.0.0000.000 vim-mkdx/1.9.1'
"       \                              },
"       \                              'fragment': {
"       \                                 'jumplist': 1,
"       \                                 'complete': 1
"       \                              }
"       \                            },
"       \ 'highlight':               { 'enable': 0 },
"       \ 'auto_update':             { 'enable': 0 }
"     \ }
" fun! s:MkdxGoToHeader(header)
"     " given a line: '  84: # Header'
"     " this will match the number 84 and move the cursor to the start of that line
"     call cursor(str2nr(get(matchlist(a:header, ' *\([0-9]\+\)'), 1, '')), 1)
" endfun

" fun! s:MkdxFormatHeader(key, val)
"     let text = get(a:val, 'text', '')
"     let lnum = get(a:val, 'lnum', '')

"     " if the text is empty or no lnum is present, return the empty string
"     if (empty(text) || empty(lnum)) | return text | endif

"     " We can't jump to it if we dont know the line number so that must be present in the outpt line.
"     " We also add extra padding up to 4 digits, so I hope your markdown files don't grow beyond 99.9k lines ;)
"     return repeat(' ', 4 - strlen(lnum)) . lnum . ': ' . text
" endfun

" fun! s:MkdxFzfQuickfixHeaders()
"     " passing 0 to mkdx#QuickfixHeaders causes it to return the list instead of opening the quickfix list
"     " this allows you to create a 'source' for fzf.
"     " first we map each item (formatted for quickfix use) using the function MkdxFormatHeader()
"     " then, we strip out any remaining empty headers.
"     let headers = filter(map(mkdx#QuickfixHeaders(0), function('<SID>MkdxFormatHeader')), 'v:val != ""')

"     " run the fzf function with the formatted data and as a 'sink' (action to execute on selected entry)
"     " supply the MkdxGoToHeader() function which will parse the line, extract the line number and move the cursor to it.
"     call fzf#run(fzf#wrap(
"             \ {'source': headers, 'sink': function('<SID>MkdxGoToHeader') }
"           \ ))
" endfun

" finally, map it -- in this case, I mapped it to overwrite the default action for toggling quickfix (<PREFIX>I)


Plug 'plasticboy/vim-markdown'
" let g:vim_markdown_conceal=1
" set conceallevel=2
" let g:vim_markdown_conceal_code_blocks = 1






Plug 'zk4/md-img-paste.vim'
augroup markdown_vim
" autocmd FileType markdown nnoremap <buffer><silent> <Leader>i :call <SID>MkdxFzfQuickfixHeaders()<Cr>
autocmd FileType markdown nmap <buffer><silent> p :call mdip#MarkdownClipboardImage("")<CR>
autocmd FileType markdown nmap <buffer><silent> P <up>:call mdip#MarkdownClipboardImage("")<CR>
augroup END

" there are some defaults for image directory and image name, you can change them
 let g:mdip_imgdir = 'assets'
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
let g:mkdp_markdown_css='/Users/zk/vue.css'


augroup gp_group 
	autocmd!
	autocmd FileType markdown nnoremap <buffer> gp :MarkdownPreview<cr>

	
augroup END
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           color-schema                            
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'sickill/vim-monokai'
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
Plug 'tpope/vim-dispatch'
" easy mapping for fugitive
Plug 'tpope/vim-unimpaired'
" for github 
Plug 'tpope/vim-rhubarb'

set diffopt+=vertical
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
autocmd FileType gitcommit set foldmethod=syntax
nnoremap <C-g>s <esc>:Gstatus<cr>
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
nnoremap <C-g>p :Gpush <CR>
nnoremap <C-g>pl :!git pull <CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           nerdcommenter                            
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" does not support jsx context comment, abandoned
"Plug 'scrooloose/nerdcommenter'
"let g:NERDCustomDelimiters = { 'javascript.jsx': { 'left': '//', 'leftAlt': '/*', 'rightAlt': '*/' } }
"let g:NERDTrimTrailingWhitespace = 1
"let g:NERDDefaultAlign = 'left'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           NERDTree                            
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
"Plug 'Xuyuanp/nerdtree-git-plugin'
"git plugin 禁了.光标上下移动时会闪动
let NERDTreeHijackNetrw=1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 0
let NERDTreeShowHidden=0
let NERDTreeIgnore = ['\.pyc$', '__pycache__','\~$','node_modules']
let g:NERDTreeWinSize=25
"open NERDTree automatically when vim starts up on opening a directory
augroup nerdtree_guard
	autocmd!
	autocmd StdinReadPre * let s:std_in=1
	autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"    autocmd FileTYpe nerdtree  nnoremap <buffer> <f5> :NERDTreeFocus<CR>
	autocmd FileType *  nnoremap  gs :NERDTreeFind<CR>
	if exists("g:NERDTree") && g:NERDTree.IsOpen()
		autocmd VimLeavePre * NERDTreeClose
	endif
augroup END
""close vim if the only window left open is a NERDTree
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
" 在打开 buffer 时自动将 nerdtree 滚到相应位置
""autocmd BufEnter * call SyncTree()

" change current file root when toggled 
" nnoremap <C-\> :NERDTreeToggle %<CR>
" inoremap <C-\> <esc>:NERDTreeToggle %<CR>
" always resize it to 25
" nnoremap <C-\> :NERDTreeToggle <CR> :vertical resize 25<CR>
" inoremap <C-\> <esc>:NERDTreeToggle<cr> :vertical resize 25<CR>
nnoremap <C-\> :NERDTreeToggle <CR>
inoremap <C-\> <esc>:NERDTreeToggle<cr>

" autocmd BufEnter * :NERDTreeToggle 
" augroup nerdtree_guard
" 	autocmd!
" 	autocmd BufEnter nerdtree :vertical resize 25<CR>
" augroup END

nnoremap <leader>w :cd %:p:h <cr> : NERDTreeCWD<cr>  <C-w>l

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

" search md ,this is very good for search code snippets in markdown 
Plug 'alok/notational-fzf-vim'
let g:nv_search_paths = ['~/bdcloud/notes']
" if not found, creat note with ctrl-x
let g:nv_create_note_key = 'ctrl-x'
nmap <leader>n  <esc>:NV<cr>



"Hide statusline
if has('nvim') && !exists('g:fzf_layout')
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
endif

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

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
" let $GTAGSLABEL = 'native-pygments'
" let $GTAGSCONF = '/usr/local/etc/gtags.conf'

" let g:Lf_GtagsAutoGenerate = 1
" let g:Lf_Gtagslabel = 'native-pygments'
" noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
" noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
" noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
" noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
" noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>
" 将自动生成的 ctags/gtags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
"set tags=./.tags;,.tags
"" 当filetype 是 python 时,自动加载 python3.7 的 tag
"augroup python
"    autocmd!
"    autocmd FileType python set tags+=/Users/zk/.cache/tags/python3.7.tags
"augroup END
"" To know when Gutentags is generating tags
"set statusline+=%{gutentags#statusline()}
"" set statusline+=%<%f\ %h%m%r%{kite#statusline()}%=%-14.(%l,%c%V%)\ %P
"" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
"" 仅当发现这些文件后, 才自动生成 tags!
"let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
"let g:gutentags_exclude_filetypes = ['.json',".xlsx",".txt"]

"" 所生成的数据文件的名称
"let g:gutentags_ctags_tagfile = '.tags'

"" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
"let s:vim_tags = expand('~/.cache/tags')
"let g:gutentags_cache_dir = s:vim_tags

"" 配置 ctags 的参数
"let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
""let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
""let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

"" 检测 ~/.cache/tags 不存在就新建
"if !isdirectory(s:vim_tags)
"    silent! call mkdir(s:vim_tags, 'p')
"endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           object                            
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'bps/vim-textobj-python'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'terryma/vim-expand-region'
Plug 'whatyouhide/vim-textobj-xmlattr'
" map K <Plug>(expand_region_expand)
"map J <plug>(expand_region_shrink)
"
let g:expand_region_use_select_mode = 1
let g:expand_region_text_objects = {
      \ 'iw'  :1,
      \ 'iW'  :1,
      \ 'i"'  :1,
      \ 'i''' :1,
      \ 'i]'  :1, 
      \ 'ib'  :1, 
      \ 'iB'  :1, 
      \ 'il'  :1, 
      \ 'ip'  :1,
      \ 'ie'  :1,
      \ }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           vim-visual-mutli                            "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'mg979/vim-visual-multi'
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
"" show leader key tips, for debug purpose

nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
"Plug 'zephod/vim-iterm2-navigator'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           inscearch                            
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'bronson/vim-visual-star-search'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           others                             
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'stephpy/vim-yaml'
Plug 'pmalek/toogle-maximize.vim'

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
call plug#end()
