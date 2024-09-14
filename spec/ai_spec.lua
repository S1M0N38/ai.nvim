---@diagnostic disable: undefined-global
local ai = require("ai")

local opts_table = {
  groq = {
    -- Using groq.com as testing provider: it's free, fast and online.
    base_url = "https://api.groq.com/openai/v1",
    api_key = vim.fn.getenv("GROQ_API_KEY_AI_NVIM"),
  },
  copilot = {
    -- GitHub Copilot
    base_url = "https://api.githubcopilot.com",
    api_key = vim.fn.getenv("COPILOT_API_KEY_AI_NVIM"),
  },
}

local requests_table = {
  groq = {
    { model = "llama3-8b-8192", messages = { { role = "user", content = "what's 2+2 and 2+3?" } } },
    { model = "llama3-8b-8192", messages = { { role = "user", content = "what's 2+2 and 2+3?" } }, stream = true },
  },
  copilot = {
    { model = "gpt-4o-mini", messages = { { role = "user", content = "what's 2+2 and 2+3?" } } },
    { model = "gpt-4o-mini", messages = { { role = "user", content = "what's 2+2 and 2+3?" } }, stream = true },
  },
}

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

describe("Make request with ai.Client", function()
  for provider, opts in pairs(opts_table) do
    local requests = requests_table[provider]
    describe("Provider: " .. provider, function()
      it("can create a chat completion with stream false", function()
        ai.setup(opts)
        local client = ai.Client:new()
        local text = ""
        local function on_chat_completion(obj)
          text = text .. obj["choices"][1]["message"]["content"]
        end
        local job_id = client:chat_completion_create(requests[1], on_chat_completion)
        vim.fn.jobwait({ job_id }, 10000)
        assert(text:match("4"))
        assert(text:match("5"))
      end)
      it("can create a chat completion with stream true", function()
        ai.setup(opts)
        local client = ai.Client:new()
        local text = ""
        local function on_chat_completion_chunk(obj)
          text = text .. (obj["choices"][1]["delta"]["content"] or "")
        end
        local job_id = client:chat_completion_create(requests[2], nil, on_chat_completion_chunk)
        vim.fn.jobwait({ job_id }, 10000)
        assert(text:match("4"))
        assert(text:match("5"))
      end)
    end)
  end
end)
