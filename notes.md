# todo                            
快速回到过去编辑的地方　
coc.nvim 打开某些文件时，会报错。
对歌的输入法支持非常不好。打字时输入法的框左下角了。　

"https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text
研究一下 yank ring

paste  reigster 
https://unix.stackexchange.com/questions/88714/vim-how-can-i-do-a-change-word-using-the-current-paste-buffer

研究一下 diff
https://www.youtube.com/watch?v=zEah_HDpHzc

研究一下 space vim  看有没有啥好东西搞过来.

git 怎么快速查看以前的文件?
# tips                            
c+w 在　insert　mode　式下往回删一个单词
fzf 带有 Ag 功能
# run
运行当前选择行
https://stackoverflow.com/questions/19883917/execute-current-line-in-bash-from-vim
Here . (the part before w) refers to the range of lines you are writing, and . is only the current line. Then you use !bash to write those lines to bash.
```
:.w !bash

```
# Movement
## move in comnand line mode 
like emacs! 
''' vim
    cnoremap <C-A> <Home>
    cnoremap <C-F> <Right>
    cnoremap <C-B> <Left>
    cnoremap ∫ <S-Left>
    cnoremap ƒ <S-Right>
'''
全局搜索
:Ack <Keyword> --<filetype>
原生替换
https://harttle.land/2016/08/08/vim-search-in-file.html

## easygrep 的功能
### 全局搜索- 当前单词
<leader> vv
### 全局替换, 可以预览
<leader> vr

### 全局搜索 -自己输关键字
:grep -R 'keyword' . 

### 要改变搜索的范围
: GrepOption  上下移动回车就能改
比如要全局交互式替换当前 prject 里的东西
则将 GrepOption : 改成 Buffers
在要替换的词上面输入 <space>vr

还有一种替换当前文件的方式
先用c-v选择好 \\Adi 搞定
通过 item 映射了  command + s   -   :w

已经在选择模式下，加入了 <leader>r 的映射了，
``` bash
   \* 与 g* 的区别
   \* 搜索完整的单词     比如搜 lo 那 hello 不会匹配
       g* 搜索只要匹配就行  比如搜 lo 那 hello 里的 lo 就会匹配
``` 
## o 切换 visual 的上端与下端

## R 可以在文字上覆盖

## 原生加''
ciw '' Esc p 加 "" 的原生方法
r'f"r' 也是一种挺好的原生方法
" ctrll+6 在 buffer 中来回切换

## 同步NerdTree与当前文件
:call SyncTree

## 改变当前目录
change folder , 当你需要 ack 时, pwd 就是当前工具目录了
:cd <folder>
:cd %:p

## 要查询 ctrl-x 啥的
:help ^x

## 快速窗口管理
``` bash 
c-w c-w 快速切换 
c-w v    =>  :vsplist
c-w s    =>  :split
c-w o    =>  :only
c-w c    =>  :close
c-w h/j/i/k   -=> 将光标移到哪个窗口
c-w H/J/I/K   -=> 将窗口交换
c-w +/-  =>  :resize +/-  N  也可以不用符号,那就会 resize 到绝对的大小
c-w </>  =>  :vertical resize +/- N
```


## 关于 coc
跳转用的是jedi 绑定到了 gd, 但是 ctags 也会生成. 可以使用 ctrl+] 跳.
但很明显 ctags 跳的地方不太对. 尤其是针对系统库


## 去除空行
:g/^$/d

:g will execute a command on lines which match a regex. The regex is 'blank line' and the command is :d (delete)

## 背景有时出现两块色是因为 colorColumn
快速到行首字符  j-

## 每次在这打字时,总是自动出现" ,以下设置可以暂时关闭这个功能
set formatoptions-=cro     或者 set fo-=cro


## 捕捉 vim　退出时一闪而过的 error
启动 vim 时使用 vim -V9vim.log
-V[N] N 是 debug　

## fugitive 
:Glog --  显示+ - 界面的 git log
:Glog -- % 显示当前文件的git log
:copen fugitive 使用了 quickfix,直接用就行了
alt-p --> :cprevious
alt-n --> :nnext

## 在commnad mode 里 yank
<C-r>"


## break line
ctrl-j
https://stackoverflow.com/questions/3961730/how-to-break-a-line-in-vim-in-normal-mode


## about jump list, what qualify the jump command
https://medium.com/breathe-publication/understanding-vims-jump-list-7e1bfc72cdf0


## 问题
1. 当启用conda 时,python 环境变了, leaderf 用不了. 


超级有用的:g
:g/from/norm diw
会搜索当前文件所有的 from 关键字, 并执行 diw 命令



# cheet.sh 
超牛 b 的作弊工具
<leader>KB 注意这里是大写
https://github.com/chubin/cheat.sh
