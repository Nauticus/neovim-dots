return {
  "nvim-telescope/telescope.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  keys = {
    { "<leader>ff", "<Cmd>Telescope find_files<CR>", desc = "Find files" },
    { "<leader>fg", "<Cmd>Telescope live_grep<CR>", desc = "Live grep" },
    { "<leader>fb", "<Cmd>Telescope buffers<CR>", desc = "Find buffers" },
    { "<leader>fw", "<Cmd>Telescope grep_string<CR>", desc = "Grep word" },
    { "<leader>fc", "<Cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Current buffer" },
    { "<leader>fh", "<Cmd>Telescope help_tags<CR>", desc = "Help tags" },
    { "<leader>fr", "<Cmd>Telescope oldfiles<CR>", desc = "Old files" },
    { "<leader>fk", "<Cmd>Telescope keymaps<CR>", desc = "Keymaps" },
    { "<leader>fs", "<Cmd>Telescope lsp_document_symbols<CR>", desc = "Document symbols" },
    { "<leader>fS", "<Cmd>Telescope lsp_workspace_symbols<CR>", desc = "Workspace symbols" },
    { "<leader>fl", "<Cmd>Telescope lsp_dynamic_workspace_symbols<CR>", desc = "LSP symbols (dynamic)" },
    { "<leader>fo", "<Cmd>Telescope colorscheme<CR>", desc = "Colorscheme" },
    { "<leader>fm", "<Cmd>Telescope man_pages<CR>", desc = "Man pages" },
    { "<leader>ft", "<Cmd>Telescope tags<CR>", desc = "Tags" },
    { "<leader>fC", "<Cmd>Telescope commands<CR>", desc = "Commands" },
    { "<leader>fH", "<Cmd>Telescope command_history<CR>", desc = "Command history" },
    { "<leader>fa", "<Cmd>Telescope registers<CR>", desc = "Registers" },
    { "<leader>fR", "<Cmd>Telescope resume<CR>", desc = "Resume" },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    -- Load fzf-native extension (overrides default sorter for better performance)
    telescope.load_extension("fzf")

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
          },
        },
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<Esc>"] = actions.close,
          },
        },
      },
    })

    -- Set Telescope as the default picker for vim.ui.select
    vim.ui.select = function(...)
      return require("telescope.ui").pick(...)
    end

    -- Command-line completions (e.g. :lua vim.ui.select(...))
    _G.telescope = telescope
  end,
}
