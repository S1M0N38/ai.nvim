---@diagnostic disable: undefined-global
local ai = require("ai")

local active_provider = {
  "groq", -- used for local testing and CI
  -- "copilot", -- only used in local testing
  -- "lmstudio", -- only used in local testing
}

local opts_table = {
  groq = {
    base_url = "https://api.groq.com/openai/v1",
    api_key = vim.fn.getenv("GROQ_API_KEY_AI_NVIM"),
  },
  copilot = {
    base_url = "https://api.githubcopilot.com",
    copilot = true,
  },
  lmstudio = {
    base_url = "http://127.0.0.1:1234/v1",
    api_key = "put-a-dummy-key",
  },
  -- add other providers here ...
}

local requests_table = {
  groq = {
    {
      model = "llama3-8b-8192",
      messages = { { role = "user", content = "what's 2+2 and 2+3?" } },
    },
  },
  copilot = {
    {
      model = "claude-3.5-sonnet",
      messages = { { role = "user", content = "what's 2+2 and 2+3?" } },
    },
  },
  lmstudio = {
    {
      model = "llama-3.2-3b-instruct",
      messages = { { role = "user", content = "what's 2+2 and 2+3?" } },
    },
  },
  -- add other providers here ...
}

local stream_requests_table = {
  groq = {
    {
      model = "llama3-8b-8192",
      messages = { { role = "user", content = "what's 2+2 and 2+3?" } },
      stream = true,
    },
  },
  copilot = {
    {
      model = "claude-3.5-sonnet",
      messages = { { role = "user", content = "what's 2+2 and 2+3?" } },
      stream = true,
    },
  },
  lmstudio = {
    {
      model = "llama-3.2-3b-instruct",
      messages = { { role = "user", content = "what's 2+2 and 2+3?" } },
      stream = true,
    },
  },
  -- add other providers here ...
}

-- remove not acteive prorvider from the table opts_table, requests_table and stream_requests_table
for provider, _ in pairs(opts_table) do
  if not vim.tbl_contains(active_provider, provider) then
    opts_table[provider] = nil
    requests_table[provider] = nil
    stream_requests_table[provider] = nil
  end
end

describe("Create ai.Client", function()
  local opts = opts_table.groq
  it("raise an error if the api_key is not provided", function()
    local status, err = pcall(function()
      ai.Client:new()
    end)
    assert(not status and err)
    assert(err:match("API key is required"))
  end)

  it("can use default options (api_key provided)", function()
    local client = ai.Client:new(nil, opts.api_key)
    assert(client.base_url == "https://api.openai.com/v1")
    assert(client.api_key == opts.api_key)
  end)

  it("can use global option set with ai.setup()", function()
    ai.setup(opts)
    local client = ai.Client:new()
    assert(client.base_url == opts.base_url)
    assert(client.api_key == opts.api_key)
  end)

  it("can use local option set with ai.Client:new()", function()
    ai.setup(opts)
    local client = ai.Client:new(opts.base_url, opts.api_key)
    assert(client.base_url == opts.base_url)
    assert(client.api_key == opts.api_key)
  end)
end)

describe("Make non-stream request with ai.Client", function()
  for provider, opts in pairs(opts_table) do
    local requests = requests_table[provider] or {}
    for _, request in ipairs(requests) do
      describe("Provider: " .. provider, function()
        it("can create a chat completion with stream false", function()
          ai.setup(opts)
          local client = ai.Client:new()
          local text = ""
          local function on_chat_completion(obj)
            text = text .. obj["choices"][1]["message"]["content"]
          end
          local job_id = client:chat_completion_create(request, on_chat_completion)
          vim.fn.jobwait({ job_id }, 10000)
          assert(text:match("4"))
          assert(text:match("5"))
        end)
      end)
    end
  end
end)

describe("Make stream request with ai.Client", function()
  for provider, opts in pairs(opts_table) do
    local requests = stream_requests_table[provider] or {}
    for _, request in ipairs(requests) do
      describe("Provider: " .. provider, function()
        it("can create a chat completion with stream true", function()
          ai.setup(opts)
          local client = ai.Client:new()
          local text = ""
          local function on_chat_completion_chunk(obj)
            local content = obj["choices"][1]["delta"]["content"]
            if content == vim.NIL or content == nil then
              content = ""
            end
            text = text .. content
          end
          local job_id = client:chat_completion_create(request, nil, on_chat_completion_chunk)
          vim.fn.jobwait({ job_id }, 10000)
          assert(text:match("4"))
          assert(text:match("5"))
        end)
      end)
    end
  end
end)
