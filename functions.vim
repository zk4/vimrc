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
"exec "!clear && python3 % | jq -C"
"endif
"endfunc
