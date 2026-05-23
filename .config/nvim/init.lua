vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes:1'
vim.o.confirm = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
})

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
cmp.setup({
    keymap = {
        preset = 'default',

        ['<CR>'] = { 'accept', 'fallback' },
        ['<Tab>'] = { 'snippet_forward', 'fallback' },
        ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
    },
})

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
    'texlab',
    'marksman',
    'lua_ls',
    'bashls',
    'yamlls',
    'dockerls',
    'docker_compose_language_service',
    'alejandra'
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

-- conform
vim.pack.add({
    { src = 'https://github.com/stevearc/conform.nvim' },
})

require("conform").setup({
    formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        markdown = { "prettier" },

        c = { "clang-format" },
        cpp = { "clang-format" },
        rust = { "rustfmt" },
        nix = { "alejandra" },
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
    },
})

-- latex

vim.pack.add({
    { src = 'https://github.com/lervag/vimtex' },
})

vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_compiler_method = 'latexmk'

-- other

vim.pack.add({
    { src = 'https://github.com/stevearc/oil.nvim' },
    { src = 'https://github.com/folke/trouble.nvim' },
    { src = 'https://github.com/windwp/nvim-autopairs' },
    { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
})

require('oil').setup()
require('trouble').setup()
require('nvim-autopairs').setup()
require('nvim-web-devicons').setup()
