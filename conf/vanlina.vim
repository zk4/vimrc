
"vallina vim
"""""""""""""""""""""
" default  fuzzy search 
"set path+=**
"find **py
"
"command! MakeTags !ctags -R .
"^ means ctrl
" ^] jump to tags
" g^] for ambiguous tags 
" ^t jump back 
"
"
" auto complete 
" ^n 
" ^p 
" ^x^n  just this file completion
" ^x^f  for filenames  (works with the path trik)
" ^x^]  tags only
"
"help: ins-completion
"
"netrw
"let g:netrw_banner=0         "disable annoying banner
"let g:netrw_browser_split=4  "open in prior window
"let g:netrw_altv=1  "oepn splits to the right
"let g:netrw_liststyle=3      "tree view
"let g:netrw_list_hide=netrw_gitignore#Hide()
"let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
"
"NOW WE CAN:
"<CR>/v/t to open in an h-split/v-split/tab
"check |netrw_browser_maps| for more mappings
"
"
"TEMPLATE:
"nnoremap ,html :-1read $HTML/.vim/.skeleton.html<CR>3jwf>a
" -1  change the line by one. just a tweak
"
"
"MAKE
"- Run :make to run 
"      :cl to list erroes
"      :cc# to jump to error by number 
"      :cn and :cp to navigate forward and back
"
"HELP
":help i_^n  show the the ctrl-n  in insert mode
":helpgrep  xxx  xxx is anything you want to find
"
"
"jumps and changes  command
"http://vimcasts.org/episodes/using-the-changelist-and-jumplist/


