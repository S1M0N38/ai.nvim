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

Read the documentation with [`:help ai.nvim`](https://github.com/S1M0N38/ai.nvim/blob/main/doc/ai.txt)

Plugins built with `ai.nvim`:

- [dante.nvim](https://github.com/S1M0N38/dante.nvim) ✎ A basic writing tool powered by LLM
- *PR your plugin here ...*

## ✨ LLM Providers

There are many providers that offer LLM models exposing OpenAI-compatible API.
The following is an incomplete list of providers that I have experimented with:

| Provider                                                                                                                | Models                                                            | Base URL                         |
| :---------------------------------------------------------------------------------------------------------------------- | :---------------------------------------------------------------- | :------------------------------- |
| [OpenAI](https://platform.openai.com/docs/overview)                                                                     | `gpt-4o`, `gpt-4o-mini`                                           | `https://api.openai.com/v1`      |
| [Mistral](https://docs.mistral.ai/)                                                                                     | `mistral-large-latest`, `open-mistral-nemo`                       | `https://api.mistral.ai/v1`      |
| [Groq](https://console.groq.com/docs/quickstart)                                                                        | `gemma2-9b-it`, `llama-3.1-70b-versatile`, `llama-3.1-8b-instant` | `https://api.groq.com/openai/v1` |
| [Copilot Chat](https://docs.github.com/en/copilot/using-github-copilot/asking-github-copilot-questions-in-your-ide)[^1] | `gpt-3.5-turbo`, `gpt-4o-mini`, `gpt-4o`, `gpt-4-0125-preview`    | `https://api.githubcopilot.com`  |

- If you want to use other providers that do not expose OpenAI-compatible API (e.g., Anthropic, Cohere, ...), you can try [liteLLM](https://docs.litellm.ai/docs/) proxy service.
- If you want to use local models, you can use [Ollama](https://ollama.com/), [llama-cpp](https://github.com/ggerganov/llama.cpp), [vLLM](https://docs.vllm.ai/en/latest/) or others.

**There is no future plan to support other API standards besides OpenAI-compatible API.**

## 🙏 Acknowledgments

- My Awesome Plugin [template](https://github.com/S1M0N38/my-awesome-plugin.nvim).
- [mrcjkb's blog posts](https://mrcjkb.dev/) about Neovim, Luarocks, and Busted.
- [mrcjkb](https://github.com/mrcjkb) and [vhyrro](https://github.com/vhyrro) repos' for GitHub Actions workflows.

[^1]: Copilot Chat is not a proper LLM provider, but a service offered with a Copilot subscription. If you use [copilot.vim](https://github.com/github/copilot.vim) or [copilot.lua](https://github.com/zbirenbaum/copilot.lua), you should have the token stored in one of these locations: `~/AppData/Local/github-copilot`, `$XDG_CONFIG_HOME/github-copilot`, or `~/.config/github-copilot` in a file named `hosts.json` or `apps.json`. That token is used for requesting another token with an expiration time. You can use that second token as `api_key` in ai.nvim configuration. No plan to implement an auto-token refresh mechanism.
