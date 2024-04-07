local M = {}

M = {
  git = {
    enable = true,
  },

  actions = {
    open_file = {
      resize_window = true,
      quit_on_open = true,
    },
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

return M
