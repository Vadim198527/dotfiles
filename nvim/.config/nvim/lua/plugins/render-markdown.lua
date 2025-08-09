return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },

  opts = {
    render_modes = { "n", "i", "c", "t" },

    anti_conceal = {
      enabled = true,
      disabled_modes = { "n" },
      above = 0,
      below = 0,
    },

    -- ВЫКЛ (toggle off) -> raw markdown: conceallevel=0, concealcursor=''
    -- ВКЛ (render)     -> красивый рендер: conceallevel=3, concealcursor='n'
    win_options = {
      conceallevel  = { default = 0, rendered = 3 },
      concealcursor = { default = "", rendered = "n" },
    },
  },

  config = function(_, opts)
    require("render-markdown").setup(opts)
  end,

  keys = {
    { ",mt", "<Cmd>RenderMarkdown toggle<CR>", desc = "Toggle render-markdown", silent = true },
  },
}
