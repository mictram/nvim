-- uncomment only one colorscheme below to set it
--colorscheme = 'tokyodark'
--colorscheme = 'tokyonight'
--colorscheme = 'catppuccin'
--colorscheme = 'moonfly'
--colorscheme = 'nightfly'
colorscheme = 'citruszest'

local ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
if not ok then
  vim.cmd 'colorscheme default' -- if the above fails, then use default
end
