<h1 align="center">✧&nbsp;&nbsp;ai.nvim&nbsp;&nbsp;✧</h1>

<p align="center">
  <a href="https://github.com/S1M0N38/ai.nvim/actions/workflows/run-tests.yml">
    <img alt="Tests workflow" src="https://img.shields.io/github/actions/workflow/status/S1M0N38/ai.nvim/run-tests.yml?style=for-the-badge&label=Tests"/>
  </a>
  <a href="https://luarocks.org/modules/S1M0N38/ai.nvim">
    <img alt="LuaRocks release" src="https://img.shields.io/luarocks/v/S1M0N38/ai.nvim?style=for-the-badge&color=5d2fbf"/>
  </a>
  <a href="https://github.com/S1M0N38/ai.nvim/releases">
    <img alt="GitHub release" src="https://img.shields.io/github/v/release/S1M0N38/ai.nvim?style=for-the-badge&label=GitHub"/>
  </a>
  <a href="https://www.reddit.com/r/neovim/comments/...">
    <img alt="Reddit post" src="https://img.shields.io/badge/post-reddit?style=for-the-badge&label=Reddit&color=FF5700"/>
  </a>
</p>

______________________________________________________________________

## 💡 Idea

LLM providers offer libraries for the most popular programming languages, so you can build code that interacts with their API.
Generally, those are wrappers around HTTPS requests with a mechanism to handle API responses (e.g., using callbacks).

To the best of my knowledge, if you want to build a plugin for Neovim that uses LLM, you have to explicitly make requests using a library like `curl` and take care of requests and responses parsing yourself. This results in a lot of boilerplate code that can be abstracted away.

`ai.nvim` is an experimental library that can be used to build Neovim plugins that interact with LLM providers: it crafts requests, parses responses, invokes callbacks, and handles errors.

## ⚡️ Requirements

- Neovim ≥ **0.9**
- Curl
- Access to LLM Provider

## 🚀 Usage

Read the documentation with [`:help ai-nvim`](https://github.com/S1M0N38/ai.nvim/blob/main/doc/ai.txt)

Plugins built with `ai.nvim`:

- [dante.nvim](https://github.com/S1M0N38/dante.nvim) ✎ A basic writing tool powered by LLM
- *PR your plugin here ...*

## ✨ LLM Providers

There are many providers that offer LLM models exposing OpenAI-compatible API.
The following is an incomplete list of providers that I have experimented with:

- **Local models** ([LM Studio](https://lmstudio.ai/), [Ollama](https://ollama.com/), [llama-cpp](https://github.com/ggerganov/llama.cpp), [vLLM](https://docs.vllm.ai/en/latest/), ...)
  - *base url*: `http://localhost:[PORT]`
  - *models*: every model supported by the local provider
  - *note*: free and private.

- **[Copilot](https://docs.github.com/en/copilot/using-github-copilot/asking-github-copilot-questions-in-your-ide)**
  - *base url*: `https://api.githubcopilot.com`
  - *models*: `gpt-4o-2024-08-06`, `claude-3.5-sonnet`, `o1-2024-12-17`, `o1-mini-2024-09-12`
  - *note*: access to SOTA model with GitHub Copilot subscription (free for students)

- **[OpenAI](https://platform.openai.com/docs/overview)**
  - *base url*: `https://api.openai.com/v1`
  - *models*: `gpt-4o`, `gpt-4o-mini`, `o1`, `o1-mini`
  - *note*: access to SOTA models (no free tier)

- **[Groq](https://console.groq.com/docs/quickstart)**
  - *base url*: `https://api.groq.com/openai/v1`
  - *models*: `gemma2-9b-it`, `llama-3.3-70b-versatile`, `llama-3.1-8b-instant`, `mixtral-8x7b-32768`
  - *note*: crazy fast inference for open source models (free tier)

- **[Mistral](https://docs.mistral.ai/)**
  - *base url*: `https://api.mistral.ai/v1`
  - *models*: `mistral-large-latest`, `ministral-3b-latest`, `ministral-8b-latest`, `mistral-small-latest`, `open-mistral-nemo`
  - *note*: access to Mistral models (free tier)

If you want to use other providers that do not expose OpenAI-compatible API (e.g., Anthropic, Cohere, ...), you can try [liteLLM](https://docs.litellm.ai/docs/) proxy service.

**There is no future plan to support other API standards besides OpenAI-compatible API.**

## 🙏 Acknowledgments

- base.nvim [template](https://github.com/S1M0N38/base.nvim).
- [mrcjkb's blog posts](https://mrcjkb.dev/) about Neovim, Luarocks, and Busted.
- [mrcjkb](https://github.com/mrcjkb) and [vhyrro](https://github.com/vhyrro) repos' for GitHub Actions workflows.
- [codecompanion.nvim](https://github.com/olimorris/codecompanion.nvim) for Copilot token validation logic.
