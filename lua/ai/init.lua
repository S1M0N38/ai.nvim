local M = {}

---Initialize ai.nvim with global options.
---These options will be used by all clients if not overriden in the :new() method.
---@param opts AiOptions: The options to initialize client with
M.setup = function(opts)
  require("ai.config").setup(opts)
end

--- Create curl command to send request to the server
---@param url string: url for the request
---@param api_key string: enviroment variable used for API authentication.
---@param request table: The request to send to the server. This will be encoded as JSON and used as the request body.
local function curl_command(url, api_key, request)
  local json_request = vim.json.encode(request)
  if type(json_request) ~= "string" then
    error("Error while parsing the request")
  end

  -- create temporary file for JSON data
  local tmpfile = vim.fn.tempname()
  local ok = vim.fn.writefile({ json_request }, tmpfile)
  if ok ~= 0 then
    error("Failed to write request to temp file")
  end

  local args = {
    "--silent",
    "--no-buffer",
    "--header " .. vim.fn.shellescape("Authorization: Bearer " .. api_key),
    "--header " .. vim.fn.shellescape("Content-Type: application/json"),
    "--url " .. vim.fn.shellescape(url),
    "--data-binary " .. vim.fn.shellescape("@" .. tmpfile),
  }

  -- hack for GitHub Copilot compatibility
  if url:find("githubcopilot") then
    local version = "Neovim/" .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch
    table.insert(args, "--header " .. vim.fn.shellescape("Copilot-Integration-Id: vscode-chat"))
    table.insert(args, "--header " .. vim.fn.shellescape("editor-version: " .. version))
  end

  return "curl " .. table.concat(args, " ")
end

---@class AiClient
local Client = {}

---Client constructor
---@param base_url string?: base url for all API requests
---@param api_key string?: enviroment variable used for API authentication.
---@return AiClient: client object
function Client:new(base_url, api_key)
  local instance = setmetatable({}, { __index = Client })
  local config = require("ai.config")
  instance.base_url = base_url or config.options.base_url or config.defaults.base_url
  if config.options.copilot then
    instance.api_key = require("ai.copilot").setup().token
  else
    instance.api_key = api_key or config.options.api_key
  end
  if not instance.api_key then
    error("API key is required.")
  end
  return instance
end

---@param request RequestObject: request for chat completion create
---@param on_chat_completion? fun(ChatCompletionObject) callback for job stdout when stream = false
---@param on_chat_completion_chunk? fun(ChatCompletionChunkObject) callback for job stdout when stream = true
---@param on_stdout? function: override default callback for job stdout. See `:h on_stdout`.
---@param on_stderr? function: override default callback for job stderr. See `:h on_stderr`.
---@param on_exit? function: override default callback for job exit. See `:h on_exit`.
---@return number: job id
function Client:chat_completion_create(
  request,
  on_chat_completion,
  on_chat_completion_chunk,
  on_stdout,
  on_stderr,
  on_exit
)
  local cmd = curl_command(self.base_url .. "/chat/completions", self.api_key, request)

  if request.stream then
    if not on_chat_completion_chunk then
      error("on_chat_completion_chunk is required for stream=true")
    end
    local buffer = ""
    on_stdout = on_stdout
      or function(_, data, _)
        for _, raw_str in ipairs(data) do
          if raw_str and raw_str ~= "" then
            -- if buffer ~= "" then
            --   print("buffer is not empty: " .. buffer .. raw_str)
            -- end
            buffer = buffer .. raw_str
            local str = buffer:match("^data: (.+)")
            if str and str ~= "[DONE]" then
              local ok, obj = pcall(vim.json.decode, str, { luanil = { object = true, array = true } })
              if ok then
                buffer = ""
                if obj then
                  if obj.choices and #obj.choices > 0 then
                    on_chat_completion_chunk(obj)
                    -- else
                    -- print("obj.choices is empty: " .. str)
                  end
                  -- else
                  -- print("obj is nil: " .. str)
                end
                -- else
                -- print("partial str: " .. str)
              end
            end
          end
        end
      end
  else
    if not on_chat_completion then
      error("on_chat_completion is required for stream=false")
    end
    local buffer = ""
    on_stdout = on_stdout
      or function(_, data, _)
        local raw_str = table.concat(data)
        if raw_str and raw_str ~= "" then
          -- if buffer ~= "" then
          --   print("buffer is not empty: " .. buffer .. raw_str)
          -- end
          buffer = buffer .. raw_str
          local str = buffer
          if str and str ~= "" then
            local ok, obj = pcall(vim.json.decode, str, { luanil = { object = true, array = true } })
            if ok then
              buffer = ""
              if obj then
                if obj.choices and #obj.choices > 0 then
                  on_chat_completion(obj)
                  -- else
                  -- print("obj.choices is empty: " .. str)
                end
                -- else
                -- print("obj is nil: " .. str)
              end
              -- else
              -- print("partial str: " .. str)
            end
          end
        end
      end
  end

  local job_id = vim.fn.jobstart(cmd, {
    on_stdout = on_stdout,
    on_stderr = on_stderr or function(_, data, _)
      for _, str in pairs(data) do
        if str ~= "" then
          vim.notify("Error: " .. str, vim.log.levels.ERROR)
        end
      end
    end,
    on_exit = on_exit or function(_, exit_code, _)
      if exit_code ~= 0 then
        vim.notify("Error: " .. exit_code, vim.log.levels.ERROR)
        -- else
        -- vim.notify("Done.", vim.log.levels.INFO)
      end
    end,
  })
  return job_id
end

M.Client = Client

return M
