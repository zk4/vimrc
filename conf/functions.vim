" 这个 Vim 函数名为 VisualSelection，它接受两个参数：direction 和 extra_filter。这个函数的作用是获取当前选中的文本，将其保存到寄存器中，并执行一些操作，具体操作取决于传递给函数的 direction 参数的值。
"
" 首先，函数会将当前选中的文本保存到寄存器中。然后，它会将选中的文本中的特殊字符进行转义，并将其保存到变量 l:pattern 中。接下来，如果 direction 参数的值为 'gv'，则函数会调用 CmdLine 函数，执行 Ack 命令来搜索匹配 l:pattern 的文本。如果 direction 参数的值为 'replace'，则函数会调用 CmdLine 函数，执行 s 命令来替换匹配 l:pattern 的文本。最后，函数会将 l:pattern 保存到寄存器 / 中，并将之前保存的寄存器内容恢复。
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
            return expand(pathMaker) endif
    endwhile
    return 0
endfunction

func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "silent ! gcc % -o %<"
        exec "!./%<"
		elseif &filetype == 'xxd'
			exec "qemu-system-x86_64 % --nographic -serial mon:stdio"
	  elseif &filetype == 'javascript.jsx'
        exec "!node %"
	  elseif &filetype == 'javascript'
        exec "!node %"
		"elseif &filetype == 'typescript'
        "exec "!tsc % --target es5 && node %:r"
	  elseif &filetype == 'rust'
        "exec "!rustc %"
        "exec "!time ./%<"
        exec "!cargo run"
	  elseif &filetype == 'typescript'
        exec "!ts-node % "
        " exec "!gcc -std=c++17 -lstdc++ % -o %<"
    elseif &filetype == 'cpp'
        exec "!gcc -std=c++17 -lstdc++ % -o %<"
        "exec "!time ./%<"
    elseif &filetype == 'java'
        "exec "!source ~/.bash_profile &&    mvnexec"
        exec "!javac % && java -verbose:gc -Xms10M -Xmx10M -Xmn10M -XX:+PrintGCDetails -XX:SurvivorRatio=8 %< "
"        exec "!time java %< "
    elseif &filetype == 'xml'
        exec "!pwd &&mvn package -DskipTests &&  java  -jar -XX:+TraceClassLoading target/*.jar "
    elseif &filetype == 'sh'
        :!bash '%'
    elseif &filetype == 'python'
        exec "!python3 '%'"
    elseif &filetype == 'groovy'
        exec "!groovy '%'"
    elseif &filetype == 'dart'
        exec "!dart '%'"
    elseif &filetype == 'gradle'
        exec "!gradle hello"
    elseif &filetype == 'html'
        exec "!open % &"
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
    elseif &filetype == 'mjs'
        exec "!%"
    endif
endfunc


function! FindSelectionMeaning ()
  try
    let v_save = @v
    normal! gv"vy
    return @v
  finally
    let @v = v_save
  endtry
endfunction


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


" http://www.danielbigham.ca/cgi-bin/document.pl?mode=Display&DocumentID=1053
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

" https://developers.google.com/custom-search/docs/xml_results_appendices?hl=en#url-escaping
function! GoogleSearch()
   let searchterm = getreg("g")
   let searchterm = substitute(searchterm, "\n", " ", "g")
   let searchterm = UrlEncode(searchterm)
   let searchterm = shellescape(searchterm, 1)
   " echo "searchterm: " . searchterm
   silent! exec "!open 'https://google.com/search?q=" . searchterm . "'"
   redraw!
endfunction

function! Strip(input_string)
    return substitute(a:input_string, '^\s*\(.\{-}\)\s*$', '\1', '')
endfunction


function! OpenChrome()
"     let searchterm =s:get_visual_selection()
     let searchterm =@"

		 " todo extract url from current line
		 " let cur_line=  getline('.')

		if Strip(searchterm) =~ "^http"
    		let url =':!open -a Google\ Chrome '. searchterm
		else
    let url =':!open -a Google\ Chrome '.'https://' . searchterm
		endif
     echom url
     silent exec  url
endfunction


function! FunReference()
   let cur_word =@"
   exec  ":cs find c " . cur_word
endfunction
function! FunReference2(cur_word)
   exec  ":cs find c " . a:cur_word
endfunction

function! LoadCscope()
	echo "try load cscope"
  let db = findfile("cscope.out", ".;")
  if (!empty(db))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . "cscope.out"
    set cscopeverbose
  endif
endfunction


"vnoremap gs "gy<Esc>:call StackOverFlow()<CR>
"https://docs.python.org/3/library/functools.html
"
"写括号时{} ， 在括号里回车自动对齐
"class {|}
"class {
"    |
"}
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

function! JumpOrCreateFile()
  " Get the filename under the cursor
  let filename = expand("<cfile>")

  " Expand the tilde in the file path
  let expanded_filename = expand(filename)

  " Check if the file path starts with "./"
  if expanded_filename =~# '^\.\/'
    " Get the current directory of the editing file
    let current_directory = expand('%:p:h')

    " Create the full path by appending the relative file path
    let expanded_filename = current_directory . '/' . expanded_filename
  endif

  " Check if the file exists
  if !filereadable(expanded_filename)
    " Prompt the user for file creation with the full path
    let choice = confirm('File does not exist. Create "' . expanded_filename . '"?', "&Yes\n&No", 1)

    " Handle the user's choice
    if choice == 1
      " Create the file and open it
      execute 'edit ' . expanded_filename
    endif
  else
    " File exists, perform normal gf behavior
    execute 'normal! gf'
  endif
endfunction

