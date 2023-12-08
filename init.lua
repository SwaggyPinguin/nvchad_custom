local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

-- Auto save files when focus is lost 
autocmd("FocusLost", {
    pattern = "*",
    command = "silent! wa",
})

-- Run php-cs-fixer on save - NOT WORKING
-- autocmd("BufWrite", {
--     pattern = "php",
--     command = "lua vim.lsp.buf.format()"
-- })

-- -- set tab width for specific filetype 
autocmd("FileType", {
    pattern = "php, javascript",
    command = "setlocal tabstop=4 shiftwidth=4 softtabstop=4"
})


-- OPTIONS
local opt = vim.opt

-- Indenting
-- opt.shiftwidth = 4
-- opt.tabstop = 4
-- opt.softtabstop = 4
opt.expandtab = false

