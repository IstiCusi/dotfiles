require("oil").setup({
  default_file_explorer = true,
  columns = {
    "icon",
    "permissions",
    -- "size",
    -- "mtime",
  },
  buf_options = {
    buflisted = false,
    bufhidden = "hide",
  },
  win_options = {
    wrap = false,
    signcolumn = "no",
    cursorcolumn = false,
    foldcolumn = "0",
    spell = false,
    list = false,
    conceallevel = 3,
    concealcursor = "nvic",
  },
  delete_to_trash = true,
  skip_confirm_for_simple_edits = false,
  prompt_save_on_select_new_entry = true,
  cleanup_delay_ms = 2000,
  lsp_file_methods = {
    enabled = true,
    timeout_ms = 1000,
    autosave_changes = false,
  },
  constrain_cursor = "editable",
  watch_for_changes = false,
  keymaps = Phonon.oilKeys,
  use_default_keymaps = true,
  view_options = {
    show_hidden = false,
    is_hidden_file = function(name, bufnr)
      return vim.startswith(name, ".")
    end,
    is_always_hidden = function(name, bufnr)
      return false
    end,
    natural_order = true,
    case_insensitive = false,
    sort = {
      { "type", "asc" },
      { "name", "asc" },
    },
  },
  extra_scp_args = {},
  git = {
    add = function(path)
      return false
    end,
    mv = function(src_path, dest_path)
      return false
    end,
    rm = function(path)
      return false
    end,
  },
  float = {
    padding = 2,
    max_width = 0,
    max_height = 0,
    border = "rounded",
    win_options = {
      winblend = 0,
    },
    -- preview_split: Split direction: "auto", "left", "right", "above", "below".
    preview_split = "auto",
    -- This is the config that will be passed to nvim_open_win.
    -- Change values here to customize the layout
    override = function(conf)
      return conf
    end,
  },
  preview = {
    max_width = 0.9,
    min_width = { 40, 0.4 },
    width = nil,
    max_height = 0.9,
    min_height = { 5, 0.1 },
    height = nil,
    border = "rounded",
    win_options = {
      winblend = 0,
    },
    update_on_cursor_moved = true,
  },
  progress = {
    max_width = 0.9,
    min_width = { 40, 0.4 },
    width = nil,
    max_height = { 10, 0.9 },
    min_height = { 5, 0.1 },
    height = nil,
    border = "rounded",
    minimized_border = "none",
    win_options = {
      winblend = 0,
    },
  },
  ssh = {
    border = "rounded",
  },
  keymaps_help = {
    border = "rounded",
  },
})

