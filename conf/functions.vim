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
        exec "silent ! gcc % -o %<"
        exec "!./%<"
    elseif &filetype == 'javascript.jsx'
        exec "!node %"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        "exec "!time ./%<"
    elseif &filetype == 'java'
        "exec "!source ~/.bash_profile &&    mvnexec"
        exec "!javac % && java -verbose:gc -Xms10M -Xmx10M -Xmn10M -XX:+PrintGCDetails -XX:SurvivorRatio=8 %< "
"        exec "!time java %< "
    elseif &filetype == 'xml'
        exec "!pwd &&mvn package -DskipTests &&  java  -jar -XX:+TraceClassLoading target/*.jar "
        "exec "!source ~/.bash_profile &&    mvnexec"
        "exec "!time java %<"
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
        exec "!python3 %"
    elseif &filetype == 'html'
        exec "!open % "
    elseif &filetype == 'yaml'
        exec "!kubectl apply -f % "
    elseif &filetype == 'go'
        "exec "!go build %<"
        exec "!go run -race %"
    elseif &filetype == 'markdown'
        exec "!~/.vim/markdown.pl % > %.html &"
        exec "!chrome %.html &"
    elseif &filetype == 'vim'
        :source %
"    else
"        :make
    endif
endfunc


"function! s:get_visual_selection_in_oneline()
"    " Why is this not a built-in Vim script function?!
"    let [line_start, column_start] = getpos("'<")[1:2]
"    let [line_end, column_end] = getpos("'>")[1:2]
"    let lines = getline(line_start, line_end)
"    if len(lines) == 0
"        return ''
"    endif
"    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
"    let lines[0] = lines[0][column_start - 1:]
"    return join(lines, "")
"endfunction

function! FindSelectionMeaning ()
  try
    let v_save = @v
    normal! gv"vy
    return @v
  finally
    let @v = v_save
  endtry
endfunction

"func! CompileRunSelection()
"    if &filetype == 'sql'
""       if you specify -p after msyql. it will prompt a warming. so use MYSQL_PWD
"       :  exec "!bash -c \'MYSQL_PWD=root mysql -h 127.0.0.1 -uroot  -P 3307 -e \"use test;" . s:get_visual_selection_in_oneline() . "\"\'"
""vnoremap _X  :<C-U>'>put =system(join(getline('''<','''>'),\"\n\").\"\n\")<cr>
""vnoremap _X  :<C-U>'>put =<cr>
"    endif
"endfunc
"https://stackoverflow.com/questions/36406366/function-is-called-several-times-in-vimscript
" add <c-u> to avoid call CompileRunSelection  multipal times
" vnoremap <F5> :<c-u>call CompileRunGcc()<CR>
vnoremap <F5> :<esc>:Dispatch call CompileRunGcc()<CR>

"xmap <F5> :.w !bash<CR>
"func! CompileRunSelection()
"    normal! y
"    if &filetype == 'sh'
"       exec  '!bash ' . getline('.')<cr>
""       exec '!bash @"'
"    elseif &filetype == 'python'
"        exec "!python .getline('.')"
"    else
"        :make
"    endif
"endfunc
func! ProfileStart()
    profile start profile.log
    profile func *
    profile file *
endfunc

func! ProfileEnd()
    profile pause
    noautocmd qall!

endfunc
" rotate split
function! Rotate()
    " save the original position, jump to the first window
    let initial = winnr()
    exe 1 . "wincmd w"

    wincmd l
    if winnr() != 1
        " succeeded moving to the right window
        wincmd J " make it the bot window
    else
        " cannot move to the right, so we are at the top
        wincmd H " make it the left window
    endif

    " restore cursor to the initial window
    exe initial . "wincmd w"
endfunction

"func! CompileRunGcc()
"exec "w"
"if &filetype == 'python'
"exec "!python3 % | jq -C"
"endif
"endfunc
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



function! MaximizeToggle()
    if exists("s:maximize_session")
        exec "source " . s:maximize_session
        call delete(s:maximize_session)
        unlet s:maximize_session
        let &hidden=s:maximize_hidden_save
        unlet s:maximize_hidden_save
    else
        let s:maximize_hidden_save = &hidden
        let s:maximize_session = tempname()
        set hidden
        exec "mksession! " . s:maximize_session
        only
    endif
endfunction
" URL encode a string. ie. Percent-encode characters as necessary.
function! UrlEncode(string)

    let result = ""

    let characters = split(a:string, '.\zs')
    for character in characters
        if character == " "
            let result = result . "+"
        elseif CharacterRequiresUrlEncoding(character)
            let i = 0
            while i < strlen(character)
                let byte = strpart(character, i, 1)
                let decimal = char2nr(byte)
                let result = result . "%" . printf("%02x", decimal)
                let i += 1
            endwhile
        else
            let result = result . character
        endif
    endfor

    return result

endfunction

" Returns 1 if the given character should be percent-encoded in a URL encoded
" string.
function! CharacterRequiresUrlEncoding(character)

    let ascii_code = char2nr(a:character)
    if ascii_code >= 48 && ascii_code <= 57
        return 0
    elseif ascii_code >= 65 && ascii_code <= 90
        return 0
    elseif ascii_code >= 97 && ascii_code <= 122
        return 0
    elseif a:character == "-" || a:character == "_" || a:character == "." || a:character == "~"
        return 0
    endif

    return 1

endfunction
"　直接使用 getlien(".")或者@*都不太对。。
" 因为减贴板已经不是 vim　的默认模式了
function! s:get_visual_selection()
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction

function! GoogleSearch()
"     let searchterm =s:get_visual_selection()
     let searchterm =@"
         
     let url =':!open "https://google.com/search?q=' . searchterm . '"'
     echom url
     silent exec  url
endfunction
function! KubeSearch()
"     let searchterm =s:get_visual_selection()
     let searchterm =@"
         
     let url =':!open "https://kubernetes.io/docs/search/?q=' . searchterm . '"'
     echom url
     silent exec  url
endfunction
function! PythonSearch()
     let searchterm =@"
     let url =':!open "https://docs.python.org/3/search.html?q=' . searchterm . '"'
     silent exec  url
endfunction
vnoremap gg "gy<Esc>:call GoogleSearch()<CR>
vnoremap gp "gy<Esc>:call PythonSearch()<CR>
vnoremap gk "gy<Esc>:call KubeSearch()<CR>
"vnoremap gs "gy<Esc>:call StackOverFlow()<CR>
"https://docs.python.org/3/library/functools.html
"
"
"
"
"写括号时{} ， 在括号里回车自动对齐
"class {|}
"class {
"    |
"}
inoremap <expr> <CR> InsertMapForEnter()
function! InsertMapForEnter()
    if pumvisible()
        return "\<C-y>"
    elseif strcharpart(getline('.'),getpos('.')[2]-1,1) == '}'
        return "\<CR>\<Esc>O"
    elseif strcharpart(getline('.'),getpos('.')[2]-1,1) == ')'
        return "\<CR>\<Esc>O"
    elseif strcharpart(getline('.'),getpos('.')[2]-1,2) == '</'
        return "\<CR>\<Esc>O"
    else
        return "\<CR>"
    endif
endfunction

" inoremap <buffer> > ></<C-x><C-o><C-y><C-o>%<CR><C-o>O
"function WriteCreatingDirs()
"    execute ':silent !mkdir -p %:h'
"    write
"endfunction
"command W call WriteCreatingDirs()
"" ----------------------------------------------------------------------------
" DiffRev
" ----------------------------------------------------------------------------
" ----------------------------------------------------------------------------
" DiffRev
" ----------------------------------------------------------------------------
let s:git_status_dictionary = {
            \ "A": "Added",
            \ "B": "Broken",
            \ "C": "Copied",
            \ "D": "Deleted",
            \ "M": "Modified",
            \ "R": "Renamed",
            \ "T": "Changed",
            \ "U": "Unmerged",
            \ "X": "Unknown"
            \ }
function! s:get_diff_files(rev)
  Gcd
  exe 'nnoremap <leader>gr :Gdiff ' . a:rev . ':%<CR>'

  let list = map(split(system(
              \ 'git diff --name-status '.a:rev), '\n'),
              \ '{"filename": matchstr(v:val, "\\S\\+$"),"text":s:git_status_dictionary[matchstr(v:val, "^\\w")]}'
              \ )
  call setqflist(list)
  copen

endfunction

command! -nargs=1 DiffRev call s:get_diff_files(<q-args>)
