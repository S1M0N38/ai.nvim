local M = {}

---Initialize ai.nvim client with options
---@param opts options: The options to initialize client with
M.setup = function(opts)
  require("ai.config").setup(opts)
end

--- Create curl command to send request to the server
---@param url string: url for the request
---@param api_key string: enviroment variable used for API authentication.
---@param request table: The request to send to the server
local function curl_command(url, api_key, request)
  local args = {
    "--silent",
    "--no-buffer",
    "--header " .. vim.fn.shellescape("Authorization: Bearer " .. api_key),
    "--header " .. vim.fn.shellescape("content-type: application/json"),
    "--url " .. vim.fn.shellescape(url),
    "--data " .. vim.fn.shellescape(vim.fn.json_encode(request)),
  }
  return "curl " .. table.concat(args, " ")
end

---@class Client
---@field base_url string The base URL for all API requests.
---@field api_key string The API key used for authentication.
local Client = {}

---Client constructor
---@param base_url string?: base url for all API requests
---@param api_key string?: enviroment variable used for API authentication.
---@return Client: client object
function Client:new(base_url, api_key)
  local instance = setmetatable({}, { __index = Client })
  local config = require("ai.config")
  instance.base_url = base_url or config.options.base_url or config.defaults.base_url
  instance.api_key = api_key or config.options.api_key
  if not instance.api_key then
    error("API key is required.")
  end
  return instance
end

---@param request table: request for chat completion create
---@param on_chat_completion? fun(table) callback for job exit
---@param on_chat_completion_chunk? fun(table) callback for job stdout
---@return number: job id
function Client:chat_completion_create(request, on_chat_completion, on_chat_completion_chunk, on_exit)
  local cmd = curl_command(self.base_url .. "/chat/completions", self.api_key, request)
  local job_id = vim.fn.jobstart(cmd, {
    -- This callback parse the reponse data to:
    --  - chat completion object (if stream = false) and call the respective callback
    --  - chat completion chunk object (if stream = true) all call the respective callback.
    on_stdout = function(_, data, _)
      for _, str in pairs(data) do
        if str ~= "" then
          if str:match("data:*") then -- stream == true
            str = str:sub(7)
            if str ~= "[DONE]" then
              local obj = vim.fn.json_decode(str)
              if on_chat_completion_chunk then
                on_chat_completion_chunk(obj)
              end
            end
          else -- stream = false
            local obj = vim.fn.json_decode(str)
            if on_chat_completion then
              on_chat_completion(obj)
            end
          end
        end
      end
    end,
    on_stderr = function(_, data, _)
      for _, str in pairs(data) do
        if str ~= "" then
          vim.notify("Error: " .. str, vim.log.levels.ERROR)
        end
      end
    end,
    on_exit = on_exit,
  }) -- I cannot use vim.system because stdout is buffered
  return job_id
end

M.Client = Client

return M
