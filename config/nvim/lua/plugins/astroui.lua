-- AstroUI provides the basis for configuring the AstroNvim User Interface
-- Configuration documentation can be found with `:h astroui`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    -- change colorscheme
    colorscheme = "astrodark",
    -- AstroUI allows you to easily modify highlight groups easily for any and all colorschemes
    highlights = {
      init = { -- this table overrides highlights in all themes
        -- Normal = { bg = "#000000" },
      },
      astrodark = { -- a table of overrides/changes when applying the astrotheme theme
        -- Normal = { bg = "#000000" },
      },
    },
    -- Icons can be configured throughout the interface
    icons = {
      -- configure the loading of the lsp in the status line
      LSPLoading1 = "⠋",
      LSPLoading2 = "⠙",
      LSPLoading3 = "⠹",
      LSPLoading4 = "⠸",
      LSPLoading5 = "⠼",
      LSPLoading6 = "⠴",
      LSPLoading7 = "⠦",
      LSPLoading8 = "⠧",
      LSPLoading9 = "⠇",
      LSPLoading10 = "⠏",
    },
    status = {
      colors = {
        fg = "none",
        bg = "none",
        section_fg = "none",
        section_bg = "none",
        git_branch_fg = "none",
        treesitter_fg = "none",
        scrollbar = "none",
        git_added = "none",
        git_changed = "none",
        git_removed = "none",
        diag_ERROR = "none",
        diag_WARN = "none",
        diag_INFO = "none",
        diag_HINT = "none",
        winbar_fg = "none",
        winbar_bg = "none",
        winbarnc_fg = "none",
        winbarnc_bg = "none",
        tabline_bg = "none",
        tabline_fg = "none",
        buffer_fg = "none",
        buffer_path_fg = "none",
        buffer_close_fg = "none",
        buffer_bg = "none",
        buffer_active_fg = "none",
        buffer_active_path_fg = "none",
        buffer_active_close_fg = "none",
        buffer_active_bg = "none",
        buffer_visible_fg = "none",
        buffer_visible_path_fg = "none",
        buffer_visible_close_fg = "none",
        buffer_visible_bg = "none",
        buffer_overflow_fg = "none",
        buffer_overflow_bg = "none",
        buffer_picker_fg = "none",
        tab_close_fg = "none",
        tab_close_bg = "none",
        tab_fg = "none",
        tab_bg = "none",
        tab_active_fg = "none",
        tab_active_bg = "none",
        inactive = "none",
        normal = "none",
        insert = "none",
        visual = "none",
        replace = "none",
        command = "none",
        terminal = "none",
      },
    },
  },
}
