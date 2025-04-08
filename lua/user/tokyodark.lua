-- tokyodark settings
vim.g.tokyodark_transparent_background = true
vim.g.tokyodark_enable_italic_comment = true
vim.g.tokyodark_enable_italic = true
vim.g.tokyodark_color_gamma = "1.0"

local ok, _ = pcall(vim.cmd, 'colorscheme tokyodark')
if not ok then
  vim.cmd 'colorscheme default' -- if the above fails, then use default
end
