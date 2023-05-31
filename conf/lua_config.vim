" Somewhere after plug#end()
" github: https://github.com/numToStr/Comment.nvim
lua << EOF
require('Comment').setup{
    toggler = {
        ---Line-comment toggle keymap
        line = '<leader>c<leader>'
    },
   opleader = {
        ---Line-comment keymap
        line = '<leader>c<leader>',
    },
		pre_hook = function(ctx)

    local U = require "Comment.utils"
    \
    local location = nil
    if ctx.ctype == U.ctype.block then
      location = require("ts_context_commentstring.utils").get_cursor_location()
    elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
      location = require("ts_context_commentstring.utils").get_visual_start_location()
    end
    return require("ts_context_commentstring.internal").calculate_commentstring {
      key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
      location = location,
    }
  end,
}

require('nvim-treesitter.configs').setup {
	ensure_installed = {
		'astro', 'css', 'glimmer', 'graphql',  'html', 'javascript', 'lua', 'php', 'python',  'scss', 'svelte', 'tsx', 'twig', 'typescript', 'vim', 'vue', },
  autopairs = {
    enable = true,
  },
  highlight = {
    enable = false, -- false will disable the whole extension
    disable = { "" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = false, disable = { "yaml","python" } },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
}









EOF
