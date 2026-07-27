-- nvim-cmp: completion plugin
return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-cmdline",
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
    "folke/lazydev.nvim",
  },
  event = "InsertEnter",
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    require("lazydev.integrations.cmp")

    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      preselect = cmp.PreselectMode.None,
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-n>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          elseif require("sidekick").nes_jump_or_apply() then
            return
          else
            vim.lsp.inline_completion.get()
            fallback()
          end
        end, { "i", "s" }),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-p>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "lazydev", priority = 1000 },
        { name = "nvim_lsp", max_item_count = 50 },
        { name = "luasnip", priority = 800 },
        { name = "path", priority = 500 },
      }, {
        { name = "buffer", keyword_length = 3 },
      }),
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
      window = {
        documentation = cmp.config.window.bordered(),
      },
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          -- Kind icons
          local kind_icons = {
            Text = "󰉿",
            Method = "󰆧",
            Function = "󰊕",
            Constructor = "󰒏",
            Field = "󰇽",
            Variable = "󰆓",
            Class = "󰠱",
            Interface = "󰡴",
            Property = "󰜢",
            Unit = "󰑚",
            Value = "󰎠",
            Enum = "󰕘",
            Keyword = "󰌋",
            Snippet = "󰘋",
            Color = "󰏘",
            File = "󰈔",
            Reference = "󰈇",
            Folder = "󰉋",
            EnumMember = "󰕘",
            Constant = "󰏿",
            Struct = "󰙅",
            Event = "󰣙",
            Operator = "󰪚",
            TypeParameter = "󰊱",
          }
          vim_item.kind = kind_icons[vim_item.kind] or vim_item.kind
          -- Source
          vim_item.menu = ({
            lazydev = "[LazyDev]",
            nvim_lsp = "[LSP]",
            luasnip = "[Snippet]",
            path = "[Path]",
            buffer = "[Buffer]",
            cmdline = "[Cmdline]",
          })[entry.source.name]
          return vim_item
        end,
      },
    })

    -- Set configuration for specific filetypes
    cmp.setup.filetype("gitcommit", {
      sources = {
        { name = "cmp_buffer" },
        { name = "luasnip" },
      },
    })

    -- Use cmdline source and configure completion for cmdline
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "path" },
        { name = "cmdline" },
      },
    })
  end,
}
