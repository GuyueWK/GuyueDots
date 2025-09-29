-- Disable or customize noice.nvim command line behavior
-- This will restore the traditional command line at the bottom

return {
  -- Option 1: Completely disable noice.nvim
  {
    "folke/noice.nvim",
    enabled = false, -- This will disable the entire noice plugin
  },

  -- Option 2: Keep noice but customize to use bottom cmdline (uncomment if you prefer this)
  --[[ {
    "folke/noice.nvim",
    opts = {
      cmdline = {
        enabled = true,
        view = "cmdline", -- Use traditional bottom command line instead of popup
        opts = {}, -- cmdline options
        format = {
          cmdline = { pattern = "^:", icon = "", lang = "vim" },
          search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
          filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
          lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
          help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
          input = {}, -- Used by input()
        },
      },
      messages = {
        enabled = true,
        view = "notify", -- default view for messages
        view_error = "notify", -- view for errors
        view_warn = "notify", -- view for warnings
        view_history = "messages", -- view for :messages
        view_search = "virtualtext", -- view for search count messages
      },
      popupmenu = {
        enabled = true,
        backend = "nui", -- backend to use to show regular cmdline completions
      },
      redirect = {
        view = "popup",
        filter = { event = "msg_show" },
      },
      commands = {
        history = {
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {
            any = {
              { event = "notify" },
              { error = true },
              { warning = true },
              { event = "msg_show", kind = { "" } },
              { event = "lsp", kind = "message" },
            },
          },
        },
      },
      notify = {
        enabled = true,
        view = "notify",
      },
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      health = {
        checker = false, -- Disable if you don't want health checks for noice
      },
      smart_move = {
        enabled = true, -- you can disable this behaviour here
        excluded_filetypes = { "cmp_menu", "cmp_docs", "notify" },
      },
      presets = {
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = false, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    },
  }, ]]
}