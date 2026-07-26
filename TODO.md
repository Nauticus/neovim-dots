# Neovim Config — TODO

## 🔴 High Priority

- [x] **treesitter-textobjects** — Add textobjects module to nvim-treesitter
  - Gives `vaf` (select function), `daf` (delete function), `vac` (select class), etc.
  - Installed as standalone plugin `nvim-treesitter-textobjects`
  - Config: `lua/plugins/treesitter.lua`
  - Docs: `~/.local/share/nvim/lazy/nvim-treesitter-textobjects/README.md`
  - [https://github.com/nvim-treesitter/nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)

- [ ] **nvim-dap + nvim-dap-ui** — Debug adapter protocol integration
  - Breakpoints, step-through debugging, variable inspection
  - Would cover Python, JS, Rust, etc. (depends on debug adapters)
  - [https://github.com/mfussenegger/nvim-dap](https://github.com/mfussenegger/nvim-dap)
  - [https://github.com/rcarriga/nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)

- [ ] **Comment plugin** — `gcc` to toggle line comments
  - Option A: Built-in `nc` (Neovim 0.10+)
  - Option B: `ts-comments` (treesitter-aware, respects language syntax)
  - [https://github.com/folke/ts-comments.nvim](https://github.com/folke/ts-comments.nvim)

- [ ] **Session management** — Save/restore workspace on restart
  - Preserves open buffers, splits, cwd
  - Option A: `possession.nvim` (lightweight)
  - Option B: `persistent-session.nvim`
  - [https://github.com/natecraddock/possession.nvim](https://github.com/natecraddock/possession.nvim)

## 🟡 Medium Priority

- [ ] **lazygit.nvim** — Terminal git UI for advanced operations
  - Interactive rebasing, stashing, branching (beyond gitsigns/diffview)
  - Requires `lazygit` binary installed
  - [https://github.com/kdheepak/lazygit.nvim](https://github.com/kdheepak/lazygit.nvim)

- [ ] **mini-surround** — Enable surround module in mini.nvim
  - `s"` to change quotes, `ds` to delete surrounds, `yta(...)` to wrap text
  - Already have mini.nvim — just need to enable the module

- [ ] **nvim-spectre** — Visual find-and-replace with preview
  - Like VS Code's search-and-replace panel
  - [https://github.com/nvim-pack/nvim-spectre](https://github.com/nvim-pack/nvim-spectre)

- [ ] **nvim-navbuddy / glance.nvim** — Breadcrumb navigation
  - See functions, classes, loops as a navigable tree
  - Glance.nvim also previews LSP references/definitions
  - [https://github.com/SmiteshP/nvim-navbuddy](https://github.com/SmiteshP/nvim-navbuddy)
  - [https://github.com/DNLHC/glance.nvim](https://github.com/DNLHC/glance.nvim)

## 🟢 Low Priority

- [ ] **zen-mode.nvim** — Distraction-free coding mode
  - Hides UI chrome, centers buffer
  - [https://github.com/folke/zen-mode.nvim](https://github.com/folke/zen-mode.nvim)

- [ ] **neotest** — Run/debug tests from within Neovim
  - Tree view of test results, run by file/function/test
  - [https://github.com/nvim-neotest/neotest](https://github.com/nvim-neotest/neotest)

- [ ] **mini.indentscope** — Visual indentation guides
  - Highlight indent of current code block
  - Module included in mini.nvim — just enable it

- [ ] **Colorscheme** — Dedicated color theme
  - Consider: catppuccin, tokyonight, kanagawa, etc.
  - Currently using default?

## 🗑️ Cleanup

- [ ] **undotree + undofile mismatch** — Fix or remove
  - `undofile` is `false` in options.lua, making undotree useless
  - Either set `undofile = true` or remove the undotree plugin
  - Comment in undotree.lua already flags this
