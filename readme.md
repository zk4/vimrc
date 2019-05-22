# The ultimate vim config for human 
With the power of kitty terminal. which is blazing fast and customizable, comparing to mac terminal or iTerm2.

# Features
1. <c-h/j/k/l> move between termnial tab  and vim inner split pane smoothly.
2. support all hot key in vim in terminal with `option/alt,command` via kitty binding, since vim in normal temrinal would not respond these two key.


# Install  (on Mac)
1. git clone https://github.com/zk4/vimrc ~/.zk_vimrc
1. run install.sh, Open vim in kitty.app 
   it will do 2 things. Install kitty for GUI. and config vim.


# Quick Tutorial
## move arond
move around like emacs if you want.
<c-b>    move cursor one character left 
<c-f>    move cursor one character right 
<c-a>    move cursor to the begin of line 
<c-e>    move curosr to the end of line 
<alt+b>  move cursor one word left
<alt+f>  move cursor one word right
works in insert and command mode!
when do we need this?
```
Ex:
    def func(args1,args2)
```
whe the cursor is in the bracket. and you are in insert mode.
you want to move the cursor out the bracket to make a ':' like this 
```
def func(args1,args2):
```
the vim noremal is to quit insert mode. go normal mode. press A. there is three key strokes.
the fastest way moving the cursor to the end of line is by pressing <c-a>.And you are still in insert mode! Only one strokes. 

Plus eamcs type movement is the default option in Mac editor, why not in vim ~


# Customize
1. kitty config is located in ~/.config/kitty/kitty.conf,check https://github.com/kovidgoyal/kitty for more information.The kitty.conf file comment is informative enough to config.

# Plugs
    - lightline.vim
      for ui 
    - LeaderF
      for ctrl-p like 
    - vim-kitty-navigator
      for smoothly navigtation between vim and terminal 
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


