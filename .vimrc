
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           TODO                            
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  快速回到过去编辑的地方
"
"  fugitive 要好好学一下.. 好难用
"  

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           tips                            
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fzf 带有 Ag 功能
" 全局搜索
" :Ack <Keyword> --<filetype>

" easygrep 的功能
" 全局搜索
" <leader> vv     
" 全局替换, 可以预览
" <leader> vr      
" 
" 要改变搜索的范围
" : GrepOption  上下移动回车就能改
" 比如要全局交互式替换当前 prject 里的东西
" 则将 GrepOption : 改成 Buffers
" 在要替换的词上面输入 <space>vr
"
" 通过 item 映射了  command + s   --->   :w
"
"   * 与 g* 的区别
"   * 搜索完整的单词     比如搜 lo 那 hello 不会匹配
"   g* 搜索只要匹配就行  比如搜 lo 那 hello 里的 lo 就会匹配
"
" visoj 选中 function 内的 东西
" o 切换 visual 的上端与下端
"
" R 可以在文字上覆盖
"
" ciw '' Esc p 加 "" 的原生方法
" r'f"r' 也是一种挺好的原生方法
" " ctrll+6 在 buffer 中来回切换
"
" 同步NerdTree与当前文件
" :call SyncTree
"
" change folder , 当你需要 ack 时, pwd 就是当前工具目录了
" :cd <folder>
" :cd %:p
"
" 要查询 ctrl-x 啥的
" :help ^x

" 快速窗口管理
" c-w c-w 快速切换
" c-w v    =>  :vsplist
" c-w s    =>  :split
" c-w o    =>  :only
" c-w c    =>  :close
" c-w h/j/i/k   -=> 将光标移到哪个窗口
" c-w H/J/I/K   -=> 将窗口交换
" c-w +/-  =>  :resize +/-  N  也可以不用符号,那就会 resize 到绝对的大小
" c-w </>  =>  :vertical resize +/- N
"
"
"关于 coc 
"跳转用的是jedi 绑定到了 gd, 但是 ctags 也会生成. 可以使用 ctrl+] 跳.
"但很明显 ctags 跳的地方不太对. 尤其是针对系统库
"
"
source ~/.zk_vimrc/system_config.vim
source ~/.zk_vimrc/functions.vim
source ~/.zk_vimrc/autocmds.vim
source ~/.zk_vimrc/mappings.vim
"" all plugin related will put in this file , includ install, config, mapping
source ~/.zk_vimrc/plugins_mappings_config.vim

" netrw setting
"let g:netrw_retmap        = 1
"let g:netrw_silent        = 1
"let g:netrw_special_syntax=1
