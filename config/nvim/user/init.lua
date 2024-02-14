return {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "stable", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "nightly", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false, -- automatically quit the current session after a successful update
    remotes = { -- easily add new remotes to track
      --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
      --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
      --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    },
  },

  -- Set colorscheme to use
  colorscheme = "astrodark",

  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },

  lsp = {
    config = {
      clangd = {
        capabilities = { offsetEncoding = "utf-8" },
      },
    },
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        -- "lua_ls",
      },
      timeout_ms = 1000, -- default format timeout
      filter = function(client) -- fully override the default formatting function
        if vim.fn.expand "%:t" == "AsciiArt.java" then
          return false
        else
          return true
        end
      end,
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
  },

  -- Configure require("lazy").setup() options
  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin" },
      },
    },
  },

  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    -- Set up custom filetypes
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }
    local M = {}

    local augroup = vim.api.nvim_create_augroup("deferClip", {})

    local entries = {
      first = 1,
      last = 1,
    }
    local active_entry = {}

    local function add_entry(entry)
      entries[entries.last] = entry
      entries.last = entries.last + 1
    end

    local function pop_entry()
      if entries.first < entries.last then
        local entry = entries[entries.first]
        entries[entries.first] = nil
        entries.first = entries.first + 1
        return entry
      end
    end

    local function sync_from()
      vim.fn.jobstart({ "win32yank.exe", "-o", "--lf" }, {
        stdout_buffered = true,
        on_stdout = function(_, data) active_entry = { lines = data, regtype = "v" } end,
      })
    end

    local sync_to
    do
      local cur_sync_job
      local function sync_next(entry)
        local chan = vim.fn.jobstart({ "win32yank.exe", "-i" }, {
          on_exit = function(_)
            local next_entry = pop_entry()
            if next_entry then
              sync_next(next_entry)
            else
              cur_sync_job = nil
            end
          end,
        })
        cur_sync_job = chan
        vim.fn.chansend(chan, entry.lines)
        vim.fn.chanclose(chan, "stdin")
      end

      sync_to = function()
        if cur_sync_job then
          return
        else
          local entry = pop_entry()
          if entry then sync_next(entry) end
        end
      end
    end

    function M.copy(lines, regtype)
      add_entry { lines = lines, regtype = regtype }
      active_entry = { lines = lines, regtype = regtype }
      sync_to()
    end

    function M.get_active() return { active_entry.lines, active_entry.regtype } end

    function M.setup()
      vim.api.nvim_exec(
        [[
    function s:copy(lines, regtype)
      call luaeval('require("core.vim.deferclip").copy(_A[1], _A[2])', [a:lines, a:regtype])
    endfunction
    function s:get_active()
      call luaeval('require("core.vim.deferclip").get_active()')
    endfunction

    let g:clipboard = {
          \   'name': 'deferClip',
          \   'copy': {
          \      '+': {lines, regtype -> s:copy(lines, regtype)},
          \      '*': {lines, regtype -> s:copy(lines, regtype)},
          \    },
          \   'paste': {
          \      '+': {-> s:get_active()},
          \      '*': {-> s:get_active()},
          \   },
          \ }
  ]],
        false
      )
      vim.api.nvim_create_autocmd({ "FocusGained", "VimEnter" }, {
        group = augroup,
        callback = sync_from,
      })
    end

    return M
  end,
}
