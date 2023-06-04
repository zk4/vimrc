Just my personal config for vim.

Not an IDE fan. No fancy stuff. Try use plugins as less as possible. Try focus on contents.


What only matters:
- vim moving & motions
	- Plug 'easymotion/vim-easymotion'
- LSP & snippets
	- Plug 'neoclide/coc.nvim'
- find anything? almost
	- Plug 'junegunn/fzf.vim'
- seamless roaming
	- kitty
	- Plug 'knubie/vim-kitty-navigator'
- version control
    - fugitive



``` bash
git clone https://github.com/zk4/kitty_config  ~/.config/kitty

```

# Why do I choose kitty over iTerm2?
Because of the problem jumping between vim buffers and terminal window.
There are solutions for that problem.But none of them are perfect from my experience.

Some Solutions:
1. use tmux and tmux-plugin in vim. Then you MUST use tmux.
2. use iterm plugin in vim.But it is slow as hell because of applescript. But if you insist, you can use my tweak version.The original repo is out of maintainence for 5 years.  [link](https://github.com/zk4/vim-iterm2-navigator)


# Install  (on Mac)
1. git clone https://github.com/zk4/vimrc ~/.zk_vimrc
1. run `install.sh` Open vim in kitty.app
   ``` bash
   git clone https://github.com/zk4/kitty_config ~/.config/kitty
   ```


# Quick Tips
The default leader key is `space`.

jump to  config

1. `<leader>ev`   Edit Vim config file
1. `<leader>et`   Edit kitty config file
1. `<leader>es`   Edit Snippet file for current file type
1. `<leader>ep`   Edit .bash_Profile file


## Move around Addition
Move around like emacs or mac style. Why Emacs binding? Sometime you do not want to switch mode when only a tiny nudge is needed to complish the task.

- `<c-b>`          move cursor one character left
- `<c-f>`          move cursor one character right
- `<c-a>`          move cursor to the begin of line
- `<c-e>`          move cursor to the end of line
![movement](https://github.com/zk4/vimrc/blob/master/imgs/movement.gif)|

Works in insert and command mode.

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

The fastest way moving the cursor to the start of line is by pressing <c-a>.And you are still in insert mode! Only one strokes.
There are other methods to solve this issue. But I find this is the easiest way.

## local search and replace
\*   search  current word or selected text in current file



# Customize
kitty config is located in ~/.config/kitty/kitty.conf,check https://github.com/kovidgoyal/kitty for more information.The kitty.conf file comment is informative enough to config.


# QA

**How do I debug the code in vim?**
Well, you should not depend on debug tools unless you have no other choice finding the bug.
Use TDD, Use log. Make debug tools the final savior. If you heavily depend on debugging code .You should use a decent IDE, like intellij IDEA.



