# Still  in construction....


# The light vim for human 
With the power of kitty terminal. which is blazing fast and customizable, comparing to mac terminal or iTerm2.

![logo](https://github.com/zk4/vimrc/blob/master/imgs/logo.png)

# Features
1. Move in vim and kitty smoothly with <c-h/j/k/l>.
2. Can move like emacs in insert mode.
2. Support all hot key in vim in terminal with `option/alt,command` via kitty binding, since vim in normal temrinal would not respond these two key.
4. Auto load config when I change the config.
4. Search and replace in file or in project is intuitive and fast.


# Install  (on Mac)
1. git clone https://github.com/zk4/vimrc ~/.zk_vimrc
1. run `install.sh` Open vim in kitty.app 

# Quick Tutorial

The default leadkey is space. feel free to change that.

modify config 
<leader>ev   Edit Vim config file
<leader>et   Edit kiTty config file
<leader>es   Edit Snippet file for current file type
<leader>ep   Edit .bash_Profile file

<space>ev  
Show some basic editor operation. 

## Move around
Move around like emacs if you want.

- `<c-b>`          move cursor one character left 
- `<c-f>`          move cursor one character right 
- `<c-a>`          move cursor to the begin of line 
- `<c-e>`          move cursor to the end of line 
- `<c-p>`          move cursor to the previous line
- `<c-n>`          mvoe cursor to the next line
- `<c-k>`          kill link 
- `<cmd-s>`        save file 
- `<cmd-f>`        search file 
- `<cmd-shift+f>`  search in project
- `<cmd-shift+r>`  replace in project 
- `<alt+b>`        move cursor one word left
- `<alt+f>`        move cursor one word right


![movement](https://github.com/zk4/vimrc/blob/master/imgs/movement.gif)

Works in insert and command mode!
When do we need this?

For Ex, most auto pair plugin tends to auto complete the bracket for you when you type '(',like the below:
```
    def func(arg1,arg2)
```
But the cursor is in the bracket. And you are in insert mode.
Now you want to move the cursor out the bracket to make a ':' like this 
```
    def func(arg1,arg2):
```
The normal operation like this:
1. Quit insert mode.
2. Go normal mode. Press A.
3. There is three key strokes.

The fastest way moving the cursor to the end of line is by pressing <c-a>.And you are still in insert mode! Only one strokes. 

There are other methods to solve this issue. But I find this is the easiest way.
Plus emacs type movement is the default option in Mac editor, why not in vim ~

## Locate file
**Find file**
*With the power of leaderF,it is async fuzzy search!

<ctrp+p> is the default key to fuzzy file search in current workspace. you can change your workspace by typing :cd <where you want to locate>
More detail you can check :help leaderF

**Switch to buffer/file**
<cmd+e>  is bound to switch between two buffers.  This key binding is similar to intelliJ. And I am used to it. 

**Find the mostly used file**
`<leader>`m

## Locate word or selection
\* # for current word search. When you cursor move away from founded word. It will automatically disable the color.  



# Customize
1. kitty config is located in ~/.config/kitty/kitty.conf,check https://github.com/kovidgoyal/kitty for more information.The kitty.conf file comment is informative enough to config.

# Plugs
- coc.nvim
    this puglin provide most features other seperate plugins do . And you shoud install it in vim . check the offical doc for more infomation.
    - auto-pair
    - LSP
    - snippet 
- fzf.vim
    - it never fails me in bash env,neither in vim.
- nerdtree
    - Just OK. Not that good ,not that bad.
- lightline.vim
    - light enough. I am not a fancy UI guy but a concise guy.
- LeaderF
    - Fast enough fro ctrl-p.
    - Maybe I will ditch this plugin  next time. I think fzf provide the same feature I need.
- vim-kitty-navigator
    - this is needed for kitty seamlessly movement.
- vim-searchindex
    - makes search more human.
- vim-easy-align
- vim-gutentags
    - Auto generate tags. Since there is LSP . I don`t use that much. May disable this next time.
- Colorizer
    - Not good enough. Terminal only has 256 color. 

- vim-textobj-python
- vim-textobj-user
    - well, if you want do vif in python. this plugin does the job. 

- vim-dispatch
    - async job manager.Well, not that useful.
- accelerated-jk
    - make move with acceleration.
- vim-fugitive
    - Git it hard. Just save some typing. And you need learn a whole bunch new keybinds. 
    - If you use the command line for git well,then you should ditch this plugin. It just try very hard to merge vim and git.
- ack.vim
    - just an interface between command ack and ccopen. 
- vim-visual-multi
    - This plugin is the best multi select I can find. You can switch between insert mode and normal mode without losing multi visual mode.

- tabular
- vim-easy-align
    - well,for alignment.

- nerdcommenter
    - This plugin has nothing to do with Nerdtree.. but for comment.

- incsearch.vim
- vim-easygrep
    - make search and replace more human.
- vim-markdown
    - Just for showing markdown as it should be.
    - Edit large markdown file in Typora.


# Thanks
This project is largly inspired by  https://github.com/amix/vimrc


# QA
**How do I debug the code ?** 
Well, you should not depend on debug tools unless you have no other choice finding the bug.
Use TDD, Use log. Make debug tools the final savior.

# Bla Bla
- VIM is a great TEXT EDITOR. but it is not a good IDE. Don`t even try to function like an IDE. If you do. Maybe you should just go with the IDE. It`s fine. Ex. Writing JAVA.
- Switch language IME is pain in vim.  I always use VS CODE as an secondary editor if I have to type a lot of chinese.
