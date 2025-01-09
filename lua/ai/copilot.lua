--[[
THis is code is from olimorris/codecompanion.nvim repo:
  https://github.com/olimorris/codecompanion.nvim/blob/9895a4be40b018c03ab9ca17c34f4ede057b96c1/lua/codecompanion/adapters/copilot.lua#L1C1-L100C4

Check out NOTICE.md for more information about the original code.
--]]

local M = {}

---@type string|nil
local _oauth_token

---@type table|nil
local _github_token

--- Finds the configuration path
---@return string|nil
local function find_config_path()
  local path = vim.fs.normalize("$XDG_CONFIG_HOME")

  if path and vim.fn.isdirectory(path) > 0 then
    return path
  elseif vim.fn.has("win32") > 0 then
    path = vim.fs.normalize("~/AppData/Local")
    if vim.fn.isdirectory(path) > 0 then
      return path
    end
  else
    path = vim.fs.normalize("~/.config")
    if vim.fn.isdirectory(path) > 0 then
      return path
    end
  end
end

---Get the Copilot OAuth token
--- The function first attempts to load the token from the environment variables,
--- specifically for GitHub Codespaces. If not found, it then attempts to load
--- the token from configuration files located in the user's configuration path.
---@return string|nil
local function get_github_token()
  local config_path = find_config_path()
  if not config_path then
    return nil
  end

  local file_paths = {
    config_path .. "/github-copilot/hosts.json",
    config_path .. "/github-copilot/apps.json",
  }

  for _, file_path in ipairs(file_paths) do
    if vim.fn.filereadable(file_path) == 1 then
      local userdata = vim.fn.json_decode(vim.fn.readfile(file_path))
      if type(userdata) == "table" then
        for key, value in pairs(userdata) do
          if string.find(key, "github.com") then
            return value.oauth_token
          end
        end
      end
    end
  end

  return nil
end

--- Create curl command for get github_token
---@param url string: url for the request
---@return string: curl command
local function curl_command(url)
  local args = {
    "--silent",
    "--header " .. vim.fn.shellescape("Authorization: Bearer " .. _oauth_token),
    "--header " .. vim.fn.shellescape("Accept: application/json"),
    "--url " .. vim.fn.shellescape(url),
  }
  return "curl " .. table.concat(args, " ")
end

---Authorize the GitHub OAuth token
---@return table|nil
local function authorize_token()
  if _github_token and _github_token.expires_at > os.time() then
    return _github_token
  end

  local cmd = curl_command("https://api.github.com/copilot_internal/v2/token")
  local job_id = vim.fn.jobstart(cmd, {
    stderr_buffered = true,
    stdout_buffered = true,
    on_stdout = function(_, data, _)
      data = table.concat(data, "\n")
      data = string.sub(data, string.find(data, "{") or 1)
      _github_token = vim.fn.json_decode(data)
    end,
    on_stderr = function(_, data, _)
      for _, str in pairs(data) do
        if str ~= "" then
          vim.notify("Error: " .. str, vim.log.levels.ERROR)
        end
      end
    end,
    on_exit = function(_, exit_code, _)
      if exit_code ~= 0 then
        vim.notify("Error: " .. exit_code, vim.log.levels.ERROR)
        -- else
        -- vim.notify("Done.", vim.log.levels.INFO)
      end
    end,
  })
  vim.fn.jobwait({ job_id }, 10000)

  return _github_token
end

--- Get github_token (api_key) for the copilot provider
---@return boolean|table: true if the setup was successful, false otherwise
M.setup = function()
  _oauth_token = get_github_token()
  if not _oauth_token then
    vim.notify("GitHub OAuth token not found", vim.log.levels.ERROR)
    return false
  end

  _github_token = authorize_token()
  if not _github_token or vim.tbl_isempty(_github_token) then
    vim.notify("Could not authorize your GitHub Copilot token", vim.log.levels.ERROR)
    return false
  end

  return _github_token
end

return M
