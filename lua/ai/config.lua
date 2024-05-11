local config = {}

config.defaults = {
  base_url = "https://api.openai.com/v1",
}

---@class Options
---@field api_key string: enviroment variable used for API authentication.
---@field base_url? string: base url for all API requests
config.options = {}

---Setup the ai.nvim client options.
---It must be called before using other ai.nvim functions.
---@param opts Options: config table
config.setup = function(opts)
  config.options = vim.tbl_deep_extend("force", {}, config.defaults, opts or {})
end

return config
