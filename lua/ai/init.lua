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

---@class PluginNameModule
---@field setup function: setup the plugin
---@field main function: calculate the max or min of two numbers and round the result if specified by options
local ai = {}

--- Setup the plugin
---@param options Config: config table
---@eval { ['description'] = require('ai.config').__format_keys() }
ai.setup = function(options)
  require("ai.config").__setup(options)
end

---Print the result of the comparison
---@param a number: first number
---@param b number: second number
---@param func string: "max" or "min"
---@param result number: result
ai.print = function(a, b, func, result)
  local s = "The " .. func .. " of " .. a .. " and " .. b .. " is " .. result
  if require("ai.config").options.round then
    s = s .. " (rounded)"
  end
  print(s)
end

--- Calcululate the max or min of two numbers and round the result if specified by options
---@param a number: first number
---@param b number: second number
---@param func string: "max" or "min"
---@return number: result
ai.main = function(a, b, func)
  local options = require("ai.config").options
  local mymath = require("ai.math")
  local result = mymath[func](a, b)
  if options.round then
    result = mymath.round(result)
  end
  ai.print(a, b, func, result)
  return result
end

return ai
