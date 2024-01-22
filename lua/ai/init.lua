---@brief [[
---
--- ai.nvim is a minimal Neovim library for creating AI plugins.
--- It exposes a set of functions to interact with OpenAI alike API.
---
--- 1. CONFIGS .................................................. |ai.nvim-config|
--- 2. API ......................................................... |ai.nvim-api|
--- 3. PROXIES ................................................... |ai.nvim-proxy|
---
---@brief ]]

---@tag ai.nvim
---@config { ["name"] = "INTRODUCTION", ["module"] = "ai"}

---@class ai
---@field setup function: setup the plugin
---@field api table: api entrypoint. See |ai.nvim-api|
local ai = {}

--- Setup the plugin
---@param options Options: config table. See |ai.nvim-config|
---@eval { ['description'] = require('ai.config').__format_keys() }
ai.setup = function(options)
  require("ai.config").__setup(options)
end

ai.api = require("ai.api")

return ai
