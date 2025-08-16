-- Markdown Preview settings in Lua for Neovim
vim.g.mkdp_auto_start = 0         -- open preview window automatically when entering Markdown buffer (default: 0)
vim.g.mkdp_auto_close = 1         -- automatically close preview when switching from Markdown (default: 1)
vim.g.mkdp_refresh_slow = 0       -- refresh preview when saving or leaving insert mode (default: 0)
vim.g.mkdp_command_for_global = 0 -- allow MarkdownPreview for all file types (default: 0)
vim.g.mkdp_open_to_the_world = 0  -- preview server available on network (default: 0)
vim.g.mkdp_open_ip = ''           -- custom IP address for preview
vim.g.mkdp_browser = ''           -- browser for preview
vim.g.mkdp_echo_preview_url = 0   -- echo URL in command line (default: 0)
vim.g.mkdp_browserfunc = ''       -- function to open preview

-- Markdown rendering options
vim.g.mkdp_preview_options = {
    mkit = {},
    katex = {},
    uml = {},
    maid = {},
    disable_sync_scroll = 0,
    sync_scroll_type = 'middle',
    hide_yaml_meta = 1,
    sequence_diagrams = {},
    flowchart_diagrams = {},
    content_editable = false,
    disable_filename = 0,
    toc = {}
}

vim.g.mkdp_markdown_css = '' -- custom CSS file for Markdown
vim.g.mkdp_highlight_css = '' -- custom CSS file for syntax highlighting
vim.g.mkdp_port = '' -- custom preview server port
vim.g.mkdp_page_title = '「${name}」' -- preview page title
vim.g.mkdp_images_path = '/home/user/.markdown_images' -- image path
vim.g.mkdp_filetypes = { 'markdown' } -- supported filetypes
vim.g.mkdp_theme = 'dark' -- default theme
vim.g.mkdp_combine_preview = 0 -- combine preview windows (default: 0)
vim.g.mkdp_combine_preview_auto_refresh = 1 -- auto-refresh combined preview
