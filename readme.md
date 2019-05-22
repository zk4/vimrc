# The ultimate vim config for human 
With the power of kitty terminal. which is blazing fast and customizable, comparing to mac terminal or iTerm2.

# Features
1. <c-h/j/k/l> move between termnial tab  and vim inner split pane smoothly.
2. support all hot key in vim in terminal with `option/alt,command` via kitty binding, since vim in normal temrinal would not respond these two key.


# Install  (on Mac)
1. git clone https://github.com/zk4/vimrc ~/.zk_vimrc
1. run `install.sh` Open vim in kitty.app 

# Quick Tutorial
Show some basic editor operation. 

## move arond
Move around like emacs if you want.

- `<c-b>`    move cursor one character left 
- `<c-f>`    move cursor one character right 
- `<c-a>`    move cursor to the begin of line 
- `<c-e>`    move cursor to the end of line 
- `<c-p>`  move cursor to the previous line
- `<c-n>`  mvoe cursor the the next line
- `<alt+b>`  move cursor one word left
- `<alt+f>`  move cursor one word right


![movement](https://github.com/zk4/vimrc/blob/master/imgs/movement.gif)

Works in insert and command mode!
When do we need this?

For Ex, most auto pair plugin tends to auto complete the bracket for you when you type '(',like the below:
```
    def func(arg1,arg2)
```
But the cursor is in the bracket. and you are in insert mode.
Now you want to move the cursor out the bracket to make a ':' like this 
```
    def func(arg1,arg2):
```
The normal operation like this:
1. Quit insert mode.
2. Go normal mode. press A.
3. There is three key strokes.

the fastest way moving the cursor to the end of line is by pressing <c-a>.And you are still in insert mode! Only one strokes. 

There are other methods to solove this issue. But I find this is the easiest way.
Plus emacs type movement is the default option in Mac editor, why not in vim ~

## locate file
### find file
With the power of leaderF,it is async fuzzy search!

<ctrp+p> is the default key to fuzzy file search in current workspace. you can change your workspace by typing :cd <where you want to locate>
More detail you can check :help leaderF

### switch to buffer/file
<cmd+e>  is bound to switch between two buffers.  this key binding is similar to intelliJ. And I am used to it. 

### find the mostly used file
`<leader>`m

## locate word or selection
\* # for current word search. when you cursor move away from founded word. it will automatically disable the color.  



# Customize
1. kitty config is located in ~/.config/kitty/kitty.conf,check https://github.com/kovidgoyal/kitty for more information.The kitty.conf file comment is informative enough to config.

# Plugs
    - lightline.vim
    - LeaderF
    - vim-kitty-navigator
    - vim-textobj-user
    - fzf.vim
    - vim-snippets
    - coc.nvim
    - nerdtree
    - vim-searchindex
    - vim-gutentags
    - vim-sneak
    - Colorizer
    - vim-textobj-python
    - gruvbox
    - vim-dispatch
    - vim-easygrep
    - vim-workspace
    - accelerated-jk
    - vim-fugitive
    - vim-monokai
    - ack.vim
    - vim-surround
    - vim-visual-multi
    - auto-pairs
    - tabular
    - nerdcommenter
    - incsearch.vim
    - vim-easy-align
    - vim-markdown

# Thanks
This project is largly inspired by  https://github.com/amix/vimrc


