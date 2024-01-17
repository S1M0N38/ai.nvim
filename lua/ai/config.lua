local M = {}

---@class Config
---@field base_url? string: base url for all requests
---@field env_var? string: API key for authentication
M.options = {}

M.__defaults = {
  base_url = "https://api.openai.com/v1",
  env_var = "OPENAI_API_KEY",
}

--- Setup options by extending defaults with the options proveded by the user
---@param options Config: config table
M.__setup = function(options)
  M.options = vim.tbl_deep_extend("force", {}, M.__defaults, options or {})
end

---Format the defaults options table for documentation
---@return table
M.__format_keys = function()
  local tbl = vim.split(vim.inspect(M.__defaults), "\n")
  table.insert(tbl, 1, "<pre>")
  table.insert(tbl, 2, "Defaults: ~")
  table.insert(tbl, #tbl, "</pre>")
  return tbl
end

return M
