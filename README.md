<h1 align="center">ai.nvim</h1>

<p align="center">
  <a href="https://luarocks.org/modules/S1M0N38/ai.nvim">
    <img alt="LuaRocks release" src="https://img.shields.io/luarocks/v/S1M0N38/ai.nvim?style=for-the-badge&color=5d2fbf"/>
  </a>
  <a href="https://github.com/S1M0N38/ai.nvim/releases">
    <img alt="GitHub release" src="https://img.shields.io/github/v/release/S1M0N38/ai.nvim?style=for-the-badge"/>
  </a>
  <a href="https://www.reddit.com/r/neovim/comments/...">
    <img alt="Reddit post" src="https://img.shields.io/badge/post-reddit?style=for-the-badge&label=Reddit&color=FF5700"/>
  </a>
</p>

______________________________________________________________________

## 💡 Idea

LLM providers offers libraries for the most popular programming languages so you can build code that interacts with their API.
Generally those are wrappers around https requests with a mechanism to handle API reposes (e.g. using callbacks).

To the best of my knowledge, if you want to build a plugin for Neovim that uses LLM, you have to explicitly make requests using a library like `curl` and take care of requests and responses parsing yourself. This results in a lot of boilerplate code that can be abstracted away.

`ai.nvim` is an experimental library that can be used to build Neovim plugins that interact with LLM providers: it craft requests, parse responses, invoke callbacks and handle errors.

## ⚡️ Requirements

- Neovim ≥ **0.9**
- Curl
- Access to LLM Provider

## 🚀 Usage

Read the documentation with [`:help ai.nvim`](https://github.com/S1M0N38/ai.nvim/blob/main/doc/ai.txt)

Plugins built with `ai.nvim`:

- [dante.nvim](https://github.com/S1M0N38/dante.nvim): An unpolished writing tool powered by LLM ✍️
- *PR your plugin here ...*

## ✨ LLM Providers

There are many providers that offer LLM models exposing OpenAI compatible API.
Many more providers can be queried by using [LiteLLM proxy](https://docs.litellm.ai/).
The following is an incomplete list of providers that I have experimented with:

| Provider                                                               | Price | Models                | Type   |
| :--------------------------------------------------------------------- | :---- | :-------------------- | :----- |
| [OpenAI](https://platform.openai.com/docs/overview)                    | Paid  | GPT Family            | Hosted |
| [Mistral](https://docs.mistral.ai/api/)                                | Paid  | Mistral Family        | Hosted |
| [Cohere](https://docs.cohere.com/docs/chat-api) (with LiteLLM)         | Free  | Command Family        | Hosted |
| [Groq](https://console.groq.com/docs/quickstart)                       | Free  | LLama, Mixtral, Gemma | Hosted |
| [Ollama](https://github.com/ollama/ollama/blob/main/docs/openai.md)    | Free  | Open-source Models    | Local  |
| [llama-cpp](https://llama-cpp-python.readthedocs.io/en/stable/server/) | Free  | Open-source Models    | Local  |

At the moment of writing, I'm really enjoying using Groq due to its free tier and its next level speed.
For highly sensitive data, I use local models through Ollama.

## 🙏 Acknowledgments

- My Awesome Plugin [template](https://github.com/S1M0N38/my-awesome-plugin.nvim).
- [mrcjkb's blog posts](https://mrcjkb.dev/) about Neovim, Luarocks and Busted.
- [mrcjkb](https://github.com/mrcjkb) and [vhyrro](https://github.com/vhyrro) repos' for GitHub Actions workflows.
