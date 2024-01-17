local ai = require("ai")

---@type CreateChatCompletionRequest[]
local reqs = {
  single_line_res = {
    model = nil,
    seed = 0,
    temperature = 0,
    messages = {
      { role = "system", content = "You are a helpful assistant." },
      { role = "user", content = "What's 2+2?" },
    },
  },
}

local queries = {
  single_line_res = function(req)
    local buf = vim.api.nvim_create_buf(false, true)
    local job = ai.chat_completion(req, buf)
    vim.fn.jobwait({ job }, 30000)
    return vim.api.nvim_buf_get_lines(buf, 0, -1, false)[1]
  end,
}

describe("OpenAI", function()
  it("chat_completion with single line res", function()
    ai.setup({ env_var = "OPENAI_API_KEY_AI_NVIM" })
    local req = reqs.single_line_res
    req.model = "gpt-3.5-turbo"
    local result = queries.single_line_res(req)
    assert.truthy(string.find(result, "4"))
  end)
end)

describe("Ollama", function()
  it("chat_completion with single line res", function()
    ai.setup({ base_url = "http://localhost:8000" })
    local req = reqs.single_line_res
    req.model = "phi"
    local result = queries.single_line_res(req)
    assert.truthy(string.find(result, "4"))
  end)
end)

describe("Copilot", function()
  it("chat_completion with single line res", function()
    ai.setup({ base_url = "http://localhost:8080" })
    local req = reqs.single_line_res
    req.model = "gpt-3.5-turbo"
    local result = queries.single_line_res(req)
    assert.truthy(string.find(result, "4"))
  end)
end)
