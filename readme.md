# Still  in construction....
Just my personal config. 

# The light vim for human 
With the power of kitty terminal. which is blazing fast and customizable, comparing to mac terminal iTerm2.

# Why I choose kitty over iTerm2?
Because of the problem jumping between vim window and terminal window.
There are solutions for that problem.But none of them are perfect from my experience.

Some Solutions:
1. use tmux and tmux-plugin in vim. Then you MUST use tmux.
2. use iterm plugin in vim.But it is slow as hell because of applescript. But if you insist, you can use my tweak version.The original repo is out of maintainence for 5 years.  [link](https://github.com/zk4/vim-iterm2-navigator)

![logo](https://github.com/zk4/vimrc/blob/master/imgs/logo.png)

# Features
1. Move in vim and kitty smoothly with <c-h/j/k/l>. 
2. Move with <c-p/n/a/e/f/b> in insert mode which is borrowed from mac navigation concept.You can navigate in any mac editor like that. Why not in vim.
2. Support all hot key in vim in terminal with `option/alt,command` via kitty binding, since vim in normal temrinal would not respond these two key.
4. Auto load config when I change the config.
4. Search and replace in file or in project is intuitive and fast.


# Install  (on Mac)
1. git clone https://github.com/zk4/vimrc ~/.zk_vimrc
1. run `install.sh` Open vim in kitty.app 


# Quick Tutorial

The default leader key is `space`. Feel free to change that.

jump to  config 

1. `<leader>ev`   Edit Vim config file
1. `<leader>et`   Edit kitty config file
1. `<leader>es`   Edit Snippet file for current file type
1. `<leader>ep`   Edit .bash_Profile file


## Move around
Move around like emacs or mac style.

- `<c-b>`          move cursor one character left 
- `<c-f>`          move cursor one character right 
- `<c-a>`          move cursor to the begin of line 
- `<c-e>`          move cursor to the end of line 
- `<c-p>`          move cursor to the previous line
- `<c-n>`          move cursor to the next line
- `<c-k>`          kill link 
- `<cmd-s>`        save file 
- `<cmd-f>`        search file 
- `<cmd-shift+f>`  search in project
- `<cmd-shift+r>`  replace in project 
- `<alt+b>`        move cursor one word left
- `<alt+f>`        move cursor one word right
![movement](https://github.com/zk4/vimrc/blob/master/imgs/movement.gif)| 

Works in insert and command mode!
When do we need this?

For Ex, most auto pair plugin tends to auto complete the bracket for you when you type '(',like the below:
    ` def func(arg1,arg2) `
    But the cursor is in the bracket. And you are in insert mode.
    Now you want to move the cursor out the bracket to make a ':' like this 
    ` def func(arg1,arg2): `
The normal operation like this:

1. Quit insert mode.
2. Go normal mode. Press A.
3. There is three key strokes.

            
The fastest way moving the cursor to the end of line is by pressing <c-a>.And you are still in insert mode! Only one strokes. 

There are other methods to solve this issue. But I find this is the easiest way.


## Locate file
**Find file**

With the power of leaderF,it is async fuzzy search!

<ctrp+p> is the default key to fuzzy file search in current workspace. you can change your workspace by typing 
:cd <where you want to locate>
More detail you can check :help leaderF

**Switch to buffer/file**

<cmd+e>  is bound to switch between two buffers.  This key binding is similar to intelliJ. And I am used to it. 

**Find the mostly used file**
`<leader>`m

## Locate word or selection
\* # for current word search. When you cursor move away from founded word. It will automatically disable the color.  



# Customize
kitty config is located in ~/.config/kitty/kitty.conf,check https://github.com/kovidgoyal/kitty for more information.The kitty.conf file comment is informative enough to config.

# Thanks
This project is largly inspired by  https://github.com/amix/vimrc


# QA
**How do I debug the code ?** 
Well, you should not depend on debug tools unless you have no other choice finding the bug.
Use TDD, Use log. Make debug tools the final savior. If you heavily depends on debuging code .You should use a decent IDE like intellij.


# Bla Bla
- VIM is a great TEXT EDITOR. but it is not a good IDE. Don`t even try to function like an IDE. If you do. Maybe you should just go with the IDE. It`s fine. Ex. Writing JAVA.
- Switch language IME is pain in vim.  I always use VS CODE as an secondary editor if I have to type a lot of chinese.
