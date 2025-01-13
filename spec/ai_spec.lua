local ai = require("ai")

local providers = {
  groq = {
    opts = {
      base_url = "https://api.groq.com/openai/v1",
      api_key = vim.fn.getenv("GROQ_API_KEY_AI_NVIM"),
    },
    data = require("spec.data.groq"),
  },
  copilot = {
    opts = {
      base_url = "https://api.githubcopilot.com",
      copilot = true,
    },
    data = require("spec.data.copilot"),
  },
  lmstudio = {
    opts = {
      base_url = "http://127.0.0.1:1234/v1",
      api_key = "dummy-API-key",
    },
    data = require("spec.data.lmstudio"),
  },
  codestral = {
    opts = {
      base_url = "https://codestral.mistral.ai/v1",
      api_key = vim.fn.getenv("CODESTRAL_API_KEY"),
    },
    data = require("spec.data.codestral"),
  },
}

describe("[#config] Create ai.Client", function()
  local opts = providers.groq.opts
  it("[#groq] raise an error if the api_key is not provided", function()
    local status, err = pcall(function()
      ai.Client:new()
    end)
    assert(not status and err)
    assert(err:match("API key is required"))
  end)

  it("[#groq] can use default options (api_key provided)", function()
    local client = ai.Client:new(nil, opts.api_key)
    assert(client.base_url == "https://api.openai.com/v1")
    assert(client.api_key == opts.api_key)
  end)

  it("[#groq] can use global option set with ai.setup()", function()
    ai.setup(opts)
    local client = ai.Client:new()
    assert(client.base_url == opts.base_url)
    assert(client.api_key == opts.api_key)
  end)

  it("[#groq] can use local option set with ai.Client:new()", function()
    ai.setup(opts)
    local client = ai.Client:new(opts.base_url, opts.api_key)
    assert(client.base_url == opts.base_url)
    assert(client.api_key == opts.api_key)
  end)
end)

describe("[#requests] Make requests with ai.Client", function()
  for provider, opts_data in pairs(providers) do
    local opts = opts_data.opts
    for i, req_res in ipairs(opts_data.data) do
      local req, res = req_res.req, req_res.res
      req.stream = false
      it("[#" .. provider .. "] (#" .. tostring(i) .. "/" .. #opts_data.data .. ")", function()
        ai.setup(opts)
        local client = ai.Client:new()
        local text = ""
        local function on_chat_completion(obj)
          text = text .. obj["choices"][1]["message"]["content"]
        end
        local job_id = client:chat_completion_create(req, on_chat_completion)
        vim.fn.jobwait({ job_id }, 10000)
        assert(text:match(res))
      end)
    end
  end
end)

describe("[#stream-requests] Make stream request with ai.Client", function()
  for provider, opts_data in pairs(providers) do
    local opts = opts_data.opts
    for i, req_res in ipairs(opts_data.data) do
      local req, res = req_res.req, req_res.res
      req.stream = true
      it("[#" .. provider .. "] (#" .. tostring(i) .. "/" .. #opts_data.data .. ")", function()
        ai.setup(opts)
        local client = ai.Client:new()
        local text = ""
        local function on_chat_completion_chunk(obj)
          local content = obj["choices"][1]["delta"]["content"]
          text = text .. (content or "")
        end
        local job_id = client:chat_completion_create(req, nil, on_chat_completion_chunk)
        vim.fn.jobwait({ job_id }, 10000)
        assert(text:match(res))
      end)
    end
  end
end)
