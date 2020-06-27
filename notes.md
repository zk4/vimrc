
# todo
- 自动补全与 snippet 总是很痛苦。。按 tab 键不是很智能

- "https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text
研究一下 yank ring

paste  reigster
https://unix.stackexchange.com/questions/88714/vim-how-can-i-do-a-change-word-using-the-current-paste-buffer

研究一下 diff
https://www.youtube.com/watch?v=zEah_HDpHzc

git 怎么快速查看以前的文件?

# 都应该看这本书
Vim实用技巧（第2版）

# tips
c+w 在　insert　mode　式下往回删一个单词
fzf 带有 Ag 功能

## 运行当前选择行
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

# quick change tab viusal effect

``` vim
:retab 4   " change tab width to 4
<leader>f   " format the docuemnt to take effect

```

# global search
Don't use Ack. use Rg.
:Rg <Keyword> --<filetype>
^w^r   put current buffer word to command input

## Rg 搜索包含文件名的问题

:Rg <keyword> 
将不会搜索文件名

:Rg <cr> ,然后再搜索,
则会包含文件名

# replace
文章: https://harttle.land/2016/08/08/vim-search-in-file.html
文章: https://speak.sh/posts/vim-cfdo-ale-and-ripgrep

## 原生替换
replace needs to use quickfix. So use Ack is better to go. Since Rg use fzf .
- :Ack foo
- :cdo s/foo/bar/cg
这是我现在实验最好的方法,可以增量替换

解释: ack 搜出来的结果在 quickfix 里.
cdo 可以针对 quickfix 里的结果做处理. 其他的还有 :bufdo :windo
具体看 :help cdo

功能如下:
				:cfirst
				:{cmd}
				:cnext
				:{cmd}
				etc.

另一种从实用技巧里学来的
```
args **/*.js
先将 js 文件搞到 args 例表
```
argdo %s/xx/bb/cg  使用 argdo 执行批量命令，
这个方法有个缺点，最后停的位置不太可控，而且如果文件里找不到的话还会报错影响视线


另一种也是实用技巧里来的
```
/xxx
:vimgrep // **/*.txt
:cfdo %s//bbb/gc
:cfdo update

可以将上面两条合写成一条
:cfdo %s//bbb/gc | update

```


### 全局搜索 -自己输关键字
```
:grep -R 'keyword' .
```
#切换 visual 的上端与下端
o

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


## plugins
kite 是一个基于 ai 的 python 补全.还行,

## tips
- 快速到行首字符  j-
- 去除空行 :g/^$/d
- 超级有用的:g
  :g/from/norm diw
  会搜索当前文件所有的 from 关键字, 并执行 diw 命令
- via 给定 func(args1,args2), 当光标在args1上时, 会选择 args1

## info
- 关于 coc
  跳转用的是jedi 绑定到了 gd, 但是 ctags 也会生成. 可以使用 ctrl+] 跳.
  但很明显 ctags 跳的地方不太对. 尤其是针对系统库

使用 c-w c-]  可以打开预览 tag 窗口


:g will execute a command on lines which match a regex. The regex is 'blank line' and the command is :d (delete)

## info
 背景有时出现两块色是因为 colorColumn

## 每次在这打字时,总是自动出现" ,以下设置可以暂时关闭这个功能
set formatoptions-=cro     或者 set fo-=cro


## 捕捉 vim　退出时一闪而过的 error
启动 vim 时使用 vim -V9vim.log
-V[N] N 是 debug　

## fugitive
```
:Glog --  显示+ - 界面的 git log
:Glog -- % 显示当前文件的git log
:copen      fugitive 使用了 quickfix,直接用就行了
alt-p --> :cprevious alt-n --> :nnext
```

how to diff version?
- Diff index and local
```
:Gdiff :0
```

- Diff between current file and current file 3 commits ago:
```

:Gdiff ~3
```
map diffget  do
map diffput  dp

## 在commnad mode 里 yank
<C-r>"


## break line
ctrl-j
https://stackoverflow.com/questions/3961730/how-to-break-a-line-in-vim-in-normal-mode


## about jump list, what qualify the jump command
https://medium.com/breathe-publication/understanding-vims-jump-list-7e1bfc72cdf0


## 问题
1. 当启用conda 时,python 环境变了, leaderf 用不了.

## 选择当前行，除去空字符
https://stackoverflow.com/questions/20165596/select-entire-line-in-vim-without-the-new-line-character
vil
val

## jump to line location not include blank
g_   jump to end
-    jump to uppper line not include space
^    jump to start of current line not include  space
0    jump to start of current line include  space


# cheet.sh
超牛 b 的作弊工具
<leader>KB 注意这里是大写
https://github.com/chubin/cheat.sh


##  不使用插件启动 vim
vim -u NONE


## search and replace
you can serach first , then leave replace  search slot blank
 In general, an empty regular expression means to use the previously entered regular expression, so :%s//\1/g should do what you want.



## yank to reigster  a
V"ay

# paste register a to buffer
```
"ap

@"  execute reigster "


```
## repeat last colon command
@:
further reqeat
@@


## insert mode tips
c-h delete previous char
c-w delete previous word
c-u delete to the start of line


## eval string
<c-r>=  eval your input


## force uppser/lower seach
/\Ca     search for A
/\ca     search for a


## 寄存器大写的作用
https://www.cnblogs.com/bwangel23/p/4421957.html
命名寄存器了，这个一共是a-z26个寄存器，分别用英文字母来表示。这个感觉主要需要讲的就是大写字母和小写字母的区别，当向寄存器中写入内容的时候（即复制或者剪切的时候），大写字母表示的是将当前要复制的内容追加到寄存器中，而小写字母表示的是将当前要复制的内容将寄存器中的原有内容给覆盖掉。这个可以类比于数据流重定向中的">"和">>"命令。


## vim help next previous
you must use :helpgrep  instead of :h
then you can :cnext  :cprevious


## 反向搜索删除
v/href/d
可以删除掉里只包含 href 的行。v 的帮助见 :vglobal

g/href/j
join文件里包含 href 的行，前面的 g 代表后面是执行 norm 命令, 你可能觉得奇怪，不是说 J 才是 join么，因为j 是 ex command( 用:执行的). 如果你要执行 normal commands ，还得像上面提过的一样，用 g/xxxx/norm  commands

g 的帮助写:global

## 移动到屏幕行的行尾
有时一行太长，你如果用 $，则在视觉上感觉跳了几行，
g$


## if coc does not work
:CocCommand workspace.showOutput

or
check .vim  in project
maybe something is disabled


这个vimrc  很精简,可以参考一下, 还带有视频
https://www.youtube.com/watch?v=n9k9scbTuvQ
https://github.com/erkrnt/awesome-streamerrc/blob/master/ThePrimeagen/init.vim


##  关于 mark 的跳转
大写的 mark 可以在文件间跳
小写的 mark 只能在本件内跳


## jump between files 
ctrl-^

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
c-w =    =>  evenly resize your buffer
c-w r    =>  rotate your buffers 
```


##  删除两个括号内
d2ip
[
  [ 
   hello world 
  ]
]

## change tag in vim-surround
<body>  hello world </body>  ----> 
<head>  hello world </head>
``` 
cstthead
```
