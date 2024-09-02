---@diagnostic disable: lowercase-global
local _MODREV, _SPECREV = "scm", "-1"
rockspec_format = "3.0"
package = "ai.nvim"
version = _MODREV .. _SPECREV

description = {
  summary = "OpenAI compatible API for Neovim (Experimental)",
  labels = { "neovim" },
  homepage = "https://github.com/S1M0N38/ai.nvim",
  license = "MIT",
}

test_dependencies = {
  "nlua",
}

source = {
  url = "git://github.com/S1M0N38/" .. package,
}

build = {
  type = "builtin",
}
