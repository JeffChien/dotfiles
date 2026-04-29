return {
  { -- autocomplete
    "saghen/blink.cmp",
    opts = {
      sources = {
        -- Define sources specifically for markdown
        per_filetype = {
          markdown = { "lsp", "path", "snippets" }, -- Exclude "buffer"
        },
      },
    },
  },

  { -- linter
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        markdown = {}, -- Setting this to an empty table disables all markdown linters
      },
    },
  },
  { -- formatter
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        markdown = { "prettier" },
      },
    },
  },
}
