local config = {}

config.defaults = {
  base_url = "https://api.openai.com/v1",
  api_key = nil,
}

---@class AiOptions
config.options = {}

---Setup the ai.nvim client options.
---It must be called before using other ai.nvim functions.
---@param opts AiOptions: config table
config.setup = function(opts)
  config.options = vim.tbl_deep_extend("force", {}, config.defaults, opts or {})
end

return config
