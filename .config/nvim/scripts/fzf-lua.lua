return {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' }, -- optional, für Icons
    config = function()
        require('fzf-lua').setup()
    end
}

