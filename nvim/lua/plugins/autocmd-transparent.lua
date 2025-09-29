-- Simple transparency using autocmds
-- This approach is more reliable and doesn't interfere with theme internals

return {
  -- Use default tokyonight but override with autocmds
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    opts = {
      style = "night",
      terminal_colors = true,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd("colorscheme tokyonight-night")
      
      -- Set transparent background after colorscheme loads
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          local hl_groups = {
            "Normal",
            "NormalNC",
            "NormalFloat",
            "SignColumn",
            "LineNr",
            "CursorLineNr",
            "StatusLine",
            "StatusLineNC",
            "TabLine",
            "TabLineFill",
            "TabLineSel",
            "Pmenu",
            "PmenuSbar",
            "PmenuThumb",
            "FloatBorder",
            "WinSeparator",
            "VertSplit",
            "WinBar",
            "WinBarNC",
            "TelescopeNormal",
            "TelescopeBorder",
            "NeoTreeNormal",
            "NeoTreeNormalNC",
            "WhichKeyFloat",
          }
          
          for _, group in ipairs(hl_groups) do
            vim.cmd(string.format("highlight %s guibg=NONE ctermbg=NONE", group))
          end
          
          -- Special handling for CursorLine - use underline instead of background
          vim.cmd("highlight CursorLine guibg=NONE ctermbg=NONE gui=underline cterm=underline")
        end,
      })
      
      -- Apply immediately
      vim.schedule(function()
        vim.cmd("doautocmd ColorScheme")
      end)
    end,
  },

  -- Configure LazyVim to use tokyonight
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-night",
    },
  },
}