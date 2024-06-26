local bufferline = require('bufferline')

local hide = {
    qf = true,
}

bufferline.setup{options = {
    mode = 'buffers',
    max_name_length = 30,
    sort_by = 'none',
    offsets = {{
        filetype = 'NvimTree',
        text = 'File Explorer',
        highlight = 'Directory',
        padding = 1,
    }},
    custom_filter = function(bufnr)
        return not hide[vim.bo[bufnr].filetype]
    end
}}
for i = 1, 9 do
    vim.keymap.set('n', '<leader>' .. i, function() bufferline.go_to_buffer(i, true) end)
end
vim.keymap.set('n', '<leader>j', '<Cmd>BufferLineCyclePrev<CR>')
vim.keymap.set('n', '<leader>k', '<Cmd>BufferLineCycleNext<CR>')
vim.keymap.set('n', 'ZZ', function()
    if vim.bo.modified then
        vim.cmd.write()
    end
    local buf = vim.fn.bufnr()
    bufferline.cycle(-1)
    vim.cmd.bdelete(buf)
end)
-- Clipboard
vim.keymap.set({'i', 'c'}, '<C-v>', '<C-r>+')
vim.keymap.set('v', '<C-v>', '"+p')
vim.keymap.set('t', '<C-v>', '<C-\\><C-n>"+pa')
vim.keymap.set('v', '<C-c>', '"+y')

