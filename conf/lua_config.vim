" github: https://github.com/numToStr/Comment.nvim
lua << EOF
require('Comment').setup{
    toggler = {
        ---Line-comment toggle keymap
        line = '<leader>c'
    },
   opleader = {
        ---Line-comment keymap
        line = '<leader>c',
    },
   pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),

}

require('nvim-treesitter.configs').setup {
ensure_installed = {
	'astro', 'css',  'html', 'javascript', 'lua', 'php', 'python',  'scss', 'tsx', 'typescript', 'vim', 'vue', },
 autopairs = {
	 enable = false,
 },
 highlight = {
	 enable = false, -- false will disable the whole extension
	 disable = { "" }, -- list of language that will be disabled
	 additional_vim_regex_highlighting = false,
 },
 indent = { enable = true, disable = { "yaml","python" } },
 context_commentstring = {
	 enable = true,
	 enable_autocmd = false,
 },
}
