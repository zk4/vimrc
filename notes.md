
# ''
this jump is kind of useful 

# jump back and forth by jumplist
c-o 
c-i


# jump back and foth by change list
g; 
g,
2g;

# quick swap word 
```
 apple pear
^
<cursor here> 
```

`deep`
# todo

https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text
研究一下 yank ring

paste  reigster
https://unix.stackexchange.com/questions/88714/vim-how-can-i-do-a-change-word-using-the-current-paste-buffer

研究一下 diff
https://www.youtube.com/watch?v=zEah_HDpHzc

git 怎么快速查看以前的文件?

# 看这本书

Vim实用技巧（第2版）

# tips

:verbose imap <tab>  查看定义

c+w 在　insert　mode　式下往回删一个单词
fzf 带有 Ag 功能

## 运行

### 当前选择行

https://stackoverflow.com/questions/19883917/execute-current-line-in-bash-from-vim
Here . (the part before w) refers to the range of lines you are writing, and . is only the current line. Then you use !bash to write those lines to bash.

```
:.w !bash
```

### 执行 norm 命令

:g/from/norm diw

会搜索当前文件所有的 from 关键字, 并执行 diw 命令

### 在全部行尾执行 norm 命令

https://stackoverflow.com/questions/594448/how-can-i-add-a-string-to-the-end-of-each-line-in-vim

:%norm A*

This is what it means:

 %       = for every line
 norm    = type the following commands
 A*      = append '*' to the end of current line

### 执行异步任务

call jobstart("mpv *.mp4")



### eval string

```
<c-r>=  eval your input
```



## 内容编辑（CRUD,move,jump)

about jump list, what qualify the jump command

https://medium.com/breathe-publication/understanding-vims-jump-list-7e1bfc72cdf0

### add break line

ctrl-j
https://stackoverflow.com/questions/3961730/how-to-break-a-line-in-vim-in-normal-mode

###  跳转到行首字符

j-

### 移动到屏幕行的行尾

有时一行太长，你如果用 $，则在视觉上感觉跳了几行，

```
g$
```



### move like emacs in comnand line mode

```
cnoremap <C-A> <Home>
cnoremap <C-F> <Right>
cnoremap <C-B> <Left>
cnoremap ∫ <S-Left>
cnoremap ƒ <S-Right>
```



### force uppser/lower seach

/\Ca     search for A
/\ca     search for a



### 创建数字序列

https://stackoverflow.com/questions/9903660/how-to-generate-a-number-sequence-in-file-using-vi-or-vim





### 原生加''

ciw '' Esc p 加 "" 的原生方法
r'f"r' 也是一种挺好的原生方法
" ctrll+6 在 buffer 中来回切换



###   mark 的跳转

大写的 mark 可以在文件间跳
小写的 mark 只能在本件内跳

**寄存器大写的作用**

https://www.cnblogs.com/bwangel23/p/4421957.html
命名寄存器了，这个一共是a-z26个寄存器，分别用英文字母来表示。这个感觉主要需要讲的就是大写字母和小写字母的区别，当向寄存器中写入内容的时候（即复制或者剪切的时候），大写字母表示的是将当前要复制的内容追加到寄存器中，而小写字母表示的是将当前要复制的内容将寄存器中的原有内容给覆盖掉。这个可以类比于数据流重定向中的">"和">>"命令。



### jump to line location not include blank

g_   jump to end

- jump to uppper line not include space
  ^    jump to start of current line not include  space
  0    jump to start of current line include  space



### 内容删除

####  删除 blank line

 :g/^$/d

#### 删除 previous char

c-h

#### 删除 previous word

c-w

#### 删除 to the start of line

c-u delete



####  删除两个括号内

```
d2ip
[
  [
   hello world
  ]
]
```





#### 反向搜索删除

v/href/d
可以删除掉里只包含 href 的行。v 的帮助见 :vglobal

g/href/j
join文件里包含 href 的行，前面的 g 代表后面是执行 norm 命令, 你可能觉得奇怪，不是说 J 才是 join么，因为j 是 ex command( 用:执行的). 如果你要执行 normal commands ，还得像上面提过的一样，用 g/xxxx/norm  commands

g 的帮助写:global





### 选择当前行，除去空字符

https://stackoverflow.com/questions/20165596/select-entire-line-in-vim-without-the-new-line-character
vil
val



### change tag in vim-surround

<body>  hello world </body>  ---->

<head>  hello world </head>

```
cstthead
```



### yank

#### 在command mode 里 yank

<C-r>"



#### 将 visual select 的贴到 command

 <c-r>*





#### paste register a to buffer

```
"ap

@"  execute reigster "


```



## 文件移动与跳转

### 改变当前目录

change folder , 当你需要 ack 时, pwd 就是当前工具目录了
:cd <folder>
:cd %:p

>  切目录改变当前目录，会影响 c-p 的结果

### jump between files

ctrl-^

## 视觉效果



### hex  mode

:%!xxd        hex 模式，注意，保存时会将 hex 保存为文本，应该通过以下命令转为原文本再保存
:%!xxd -r





### quick change tab viusal effect

``` vim
:retab 4   " change tab width to 4
<leader>f   " format the docuemnt to take effect
```

### 背景有时出现两块色

是因为 colorColumn

每次在这打字时,总是自动出现" ,以下设置可以暂时关闭这个功能

set formatoptions-=cro     或者 set fo-=cro



### 快速窗口管理

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



## search & replace

Don't use Ack. use Rg.
:Rg <Keyword> --<filetype>
^r^w   put current buffer word to command input

文章: https://harttle.land/2016/08/08/vim-search-in-file.html
文章: https://speak.sh/posts/vim-cfdo-ale-and-ripgrep

### Rg 搜索包含文件名的问题

:Rg <keyword>
将不会搜索文件名

:Rg <cr> ,然后再搜索,
则会包含文件名



### 替换选中

:%s//new-string/g
If you don't put anything in the first field it uses the last searched pattern. I use this at least 20 times per day. Combine it with * and you are golden.

### 原生替换

replace needs to use quickfix. So use Ack is better to go. Since Rg use fzf .

- :Ack foo
- :cdo s/foo/bar/cg
  这是我现在实验最好的方法,可以增量替换
  c 代表需要你确认， 如果不需要确认直接用 g

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



### search and replace

you can serach first , then leave replace  search slot blank
 In general, an empty regular expression means to use the previously entered regular expression, so :%s//\1/g should do what you want.

### yank to reigster  a

V"ay

### repeat last colon command

@:
further reqeat
@@



## 内容对比

###  对比 split window

:windo diffthis
:diffoff!





## 查文档与 DEBUG

### 查带 ctrl 的命令

如 ctrl-x

```
:help ^x
```



### vim help next previous

you must use :helpgrep  instead of :h
then you can :cnext  :cprevious



### 捕捉 vim　退出时一闪而过的 error

启动 vim 时使用 vim -V9vim.log
-V[N] N 是 debug　



# plugin tips

## 同步NerdTree与当前文件

:call SyncTree



##  coc 函数定义跳转不正确

跳转用的coc， jedi 绑定到了 gd, 但是 ctags 也会生成. 可以使用 ctrl+] 跳.
但很明显 ctags 跳的地方不太对. 尤其是针对系统库
但是，在 ts 里，如果直接使用 gd 跳，只会跳到 d.ts ，完全没用。 这时候就要用上 ctags 了

如果使用了插件： ludovicchabant/vim-gutentags
当目录为 .git 时，会自动生成。

使用 c-w c-]  可以打开预览 tag 窗口
g ] 可以打开所找到的例表

:g will execute a command on lines which match a regex. The regex is 'blank line' and the command is :d (delete)



## 如果 coc 不工作

:CocCommand workspace.showOutput

or
check .vim  in project
maybe something is disabled


这个vimrc  很精简,可以参考一下, 还带有视频
https://www.youtube.com/watch?v=n9k9scbTuvQ
https://github.com/erkrnt/awesome-streamerrc/blob/master/ThePrimeagen/init.vim



## coc-java language server 总是崩溃的问题

https://github.com/neoclide/coc-java/issues/99

```
Version 57 of JDT Lang Sever works fine
https://download.eclipse.org/jdtls/milestones/0.57.0/

Quick hack for those who are facing this issue
Replace all directories/files in ~/.config/coc/extensions/coc-java-data/server with directories/files from above extracted JDT lang server tar.
```



## fugitive

```
:Glog --  显示+ - 界面的 git log
:Glog -- % 显示当前文件的git log
:copen      fugitive 使用了 quickfix,直接用就行了
alt-p --> :cprevious alt-n --> :nnext

:0Glog
只看当前文件的历史，非常好用

:Glog HEAD~1
对比上一个版本
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



## tabulalize

https://blog.csdn.net/techfield/article/details/84186402
Tabularize 可简化为 :Tab，以下都省略了选中区域后自动生成的 `'<,'>`：

```
冒号对齐：:Tab /:
逗号对齐 :Tabularize /,
运行上一个对齐命令 :Tab
// 对齐（需要 escape）: :Tab /\/\/
:Tabularize /,/r1c1l0 含义是：对齐指定区域的文本，以逗号分割。将第一个逗号前的所有文本右对齐，然后添加一个空格；将逗号居中对齐，然后添加一个空格；然后将逗号后所有文本左对齐，不添加空格（添加 0 个空格）。
```



##  不使用插件启动 vim

# 其他信息

vim -u NONE



# 未解决问题

- 当启用 conda 时,python 环境变了, leaderf 用不了



## kite

是一个基于 ai 的 python 补全.还行,



## cheet.sh

超牛 b 的作弊工具
<leader>KB 注意这里是大写
https://github.com/chubin/cheat.sh



## / could be part of motion
^
kd/mot<cr>
=>
motion

