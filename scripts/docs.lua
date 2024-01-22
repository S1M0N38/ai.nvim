local docgen = require("docgen")

local docs = {}

docs.test = function()
  -- Filepaths that should generate docs
  local input_files = {
    "./lua/ai/init.lua",
    "./lua/ai/config.lua",
    "./lua/ai/api.lua",
  }

  -- Output file
  local output_file = "./doc/ai.nvim.txt"
  local output_file_handle = io.open(output_file, "w")
  assert(output_file_handle, "Could not open " .. output_file)

  for _, input_file in ipairs(input_files) do
    docgen.write(input_file, output_file_handle)
  end

  output_file_handle:write(" vim:tw=78:ts=8:ft=help:norl:\n")
  output_file_handle:close()
  vim.cmd([[checktime]])
end

docs.test()

return docs
