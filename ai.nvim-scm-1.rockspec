---@diagnostic disable: lowercase-global
rockspec_format = "3.0"
package = "ai.nvim"
version = "scm-1"

description = {
  summary = "OpenAI compatible API for Neovim (Experimental)",
  labels = { "neovim" },
  homepage = "https://github.com/S1M0N38/ai.nvim",
  license = "MIT",
}

test_dependencies = {
  "lua >= 5.1",
  "plenary.nvim",
  "nui.nvim",
}

source = {
  url = "git://github.com/S1M0N38/" .. package,
}

build = {
  type = "builtin",
}
