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
        exec "!python %"
    elseif &filetype == 'html'
        exec "!open % &"
    elseif &filetype == 'go'
        "exec "!go build %<"
        exec "!time go run %"
    elseif &filetype == 'markdown'
        exec "!~/.vim/markdown.pl % > %.html &"
        exec "!chrome %.html &"
    elseif &filetype == 'vim'
        :source %
    else 
        :make
    endif
endfunc


xmap <F5> :.w !bash<CR>
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

