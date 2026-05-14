vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes:1'
vim.o.confirm = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- catppuccin

vim.pack.add({
    { src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' },
})

vim.cmd.colorscheme('catppuccin')

-- treesitter

vim.pack.add({
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
})

-- blink

vim.pack.add({
    { src = 'https://github.com/saghen/blink.lib' },
    { src = 'https://github.com/saghen/blink.cmp' },
})

local cmp = require('blink.cmp')
cmp.build():wait(60000)
cmp.setup()

-- lsp 

vim.pack.add({
    { src = 'https://github.com/mason-org/mason.nvim' },
    { src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
    { src = 'https://github.com/neovim/nvim-lspconfig' },
})

local capabilities = require('blink.cmp').get_lsp_capabilities()

local servers = {
    'html',
    'cssls',
    'jsonls',
    'jdtls',
    'rust_analyzer',
    'ts_ls',
    'clangd',
    'pyright',
    'intelephense',
    'lua_ls',
    'bashls',
    'yamlls',
    'dockerls',
    'docker_compose_language_service',
}

require('mason').setup()

require('mason-lspconfig').setup({
    ensure_installed = servers,
    automatic_installation = true
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } }
    }
  }
})

for _, server in ipairs(servers) do 
    vim.lsp.config(server, {
        capabilities = capabilities
    })

    vim.lsp.enable(server)
end

-- other

vim.pack.add ({ 
    { src = 'https://github.com/stevearc/oil.nvim' },
    { src = 'https://github.com/folke/trouble.nvim' },
    { src = 'https://github.com/windwp/nvim-autopairs' },
    { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
})

require('oil').setup()
