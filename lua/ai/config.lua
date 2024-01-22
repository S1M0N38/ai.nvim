---@brief [[
--- Before using making API requests, you can set options with the |ai.setup()| function.
---
--- <code>
--- local ai = require("ai")
--- ai.setup({}) -- default options
--- -- you API requests here...
--- </code>
---
--- The avaialble options are define in the following table.
---@brief ]]

---@tag ai.nvim-config
---@config { ["name"] = "CONFIGS" }

local M = {}

---@class Options
---@field base_url? string: base url for all API requests
---@field env_var? string: enviroment variable used for API authentication.
M.options = {}

M.__defaults = {
  base_url = "https://api.openai.com/v1",
  env_var = "OPENAI_API_KEY",
}

--- Setup options by extending defaults with the options proveded by the user
---@param options Options: config table
M.__setup = function(options)
  M.options = vim.tbl_deep_extend("force", {}, M.__defaults, options or {})
end

---Format the defaults options table for documentation
---@return table
M.__format_keys = function()
  local tbl = vim.split(vim.inspect(M.__defaults), "\n")
  print(vim.inspect(tbl))
  table.insert(tbl, 1, "<pre>")
  table.insert(tbl, 2, "Defaults: ~")
  table.insert(tbl, #tbl, "</pre>")
  return tbl
end

return M
