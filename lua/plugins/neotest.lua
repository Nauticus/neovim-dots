return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "marilari88/neotest-vitest",
  },
  opts = {
    adapters = {
      ["neotest-vitest"] = {
        -- Filter directories when searching for test files
        filter_dir = function(name)
          return name ~= "node_modules"
        end,
      },
    },
  },
  config = function(_, opts)
    require("neotest").setup(opts)
  end,
  keys = {
    ---@diagnostic disable-next-line: param-type-mismatch
    { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Test File" },
    { "<leader>tr", function() require("neotest").run.run() end, desc = "Test Nearest" },
    ---@diagnostic disable-next-line: missing-fields
    { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Test Debug Nearest" },
    { "<leader>ts", function() require("neotest").run.stop() end, desc = "Test Stop" },
    ---@diagnostic disable-next-line: missing-fields
    { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Test Last" },
    { "<leader>tS", function() require("neotest").summary.toggle() end, desc = "Test Summary" },
    { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Test Output" },
    { "<leader>tp", function() require("neotest").output_panel.toggle() end, desc = "Test Output Panel" },
  },
}
