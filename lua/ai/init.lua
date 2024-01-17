---@tag ai

---@brief [[
---This is a template for a plugin. It is meant to be copied and modified.
---The following code is a simple example to show how to use this template and how to take advantage of code
---documentation to generate plugin documentation.
---
---This simple example plugin provides a command to calculate the maximum or minimum of two numbers.
---Moreover, the result can be rounded if specified by the user in its configuration using the setup function.
---
--- <pre>
--- `:PluginName {number} {number} {max|min}`
--- </pre>
---
--- The plugin can be configured using the |ai.setup()| function.
---
---@brief ]]

local chat = require("ai.chat")
local ai = {
  chat_completion = chat.chat_completion,
  chat_completion_stream = chat.chat_completion_stream,
  -- TODO: add more endpoints
}

--- Setup the plugin
---@param options Config: config table
---@eval { ['description'] = require('ai.config').__format_keys() }
ai.setup = function(options)
  require("ai.config").__setup(options)
end

return ai
