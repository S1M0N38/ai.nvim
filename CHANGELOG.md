# Changelog

## [1.4.1](https://github.com/S1M0N38/ai.nvim/compare/v1.4.0...v1.4.1) (2025-01-10)


### Bug Fixes

* update stream/not-stream json decoding ([f82a0e6](https://github.com/S1M0N38/ai.nvim/commit/f82a0e637e4882cb78d7c0396ab7177776b7a55c))

## [1.4.0](https://github.com/S1M0N38/ai.nvim/compare/v1.3.0...v1.4.0) (2025-01-09)


### Features

* add copilot as provider ([85ae05b](https://github.com/S1M0N38/ai.nvim/commit/85ae05b6cf7ef099458b2f75025b4156e3332865))


### Bug Fixes

* add type annotations for copilot functions ([adc1e6b](https://github.com/S1M0N38/ai.nvim/commit/adc1e6be91973ba58248b6337d22624996511c8b))
* check that copilot userdata var is a table ([a481d0c](https://github.com/S1M0N38/ai.nvim/commit/a481d0c71837ec90abfaa5a820e388cc8b62dc23))

## [1.3.0](https://github.com/S1M0N38/ai.nvim/compare/v1.2.0...v1.3.0) (2024-09-24)


### Features

* update Lua type annotations and paths ([64f7a21](https://github.com/S1M0N38/ai.nvim/commit/64f7a21a962153995deeecdbb38df005b8c6ff11))

## [1.2.0](https://github.com/S1M0N38/ai.nvim/compare/v1.1.0...v1.2.0) (2024-09-14)


### Features

* **types:** add type definitions for chat completion API ([b3ddcd8](https://github.com/S1M0N38/ai.nvim/commit/b3ddcd8f2805ad4c7b481ebf76bf377bfc8e8734))


### Bug Fixes

* correct grammar and punctuation in README.md ([02c0f14](https://github.com/S1M0N38/ai.nvim/commit/02c0f149ea9f22b7caae8e48583e881c06c1b7b3))
* **spec:** remove GitHub Copilot configuration ([4e5edc7](https://github.com/S1M0N38/ai.nvim/commit/4e5edc74325c0a8081f61ec5fdb5a4854a565a03))

## [1.1.0](https://github.com/S1M0N38/ai.nvim/compare/v1.0.1...v1.1.0) (2024-09-05)


### Features

* GitHub Copilot compatibility ([be281d9](https://github.com/S1M0N38/ai.nvim/commit/be281d9f968fc5628e709f5c449c635a3d1edf07))


### Bug Fixes

* update environment variable for Copilot API key ([dd08c50](https://github.com/S1M0N38/ai.nvim/commit/dd08c50f0f8442445811fe247ad305aa510e2ae3))

## [1.0.1](https://github.com/S1M0N38/ai.nvim/compare/v1.0.0...v1.0.1) (2024-09-04)


### Bug Fixes

* [#10](https://github.com/S1M0N38/ai.nvim/issues/10) by rewriting on_stdout function ([628fbbc](https://github.com/S1M0N38/ai.nvim/commit/628fbbcf956ad0b88d06fe354ea1e0bf4c42e76c))

## [1.0.0](https://github.com/S1M0N38/ai.nvim/compare/v0.1.1...v1.0.0) (2024-09-02)


### ⚠ BREAKING CHANGES

* remove verbose type annotation and old testing

### Features

* add Client class to init ([da37298](https://github.com/S1M0N38/ai.nvim/commit/da372989f3b8d13756f3a1bf78a3dc3d7809f921))
* check for correct requst encoding ([358c3eb](https://github.com/S1M0N38/ai.nvim/commit/358c3ebbf952f56c0c951fbf429fb0d8156ba78e))
* improve type annotations ([d35d015](https://github.com/S1M0N38/ai.nvim/commit/d35d015fbe548ac5241c1d20dd00cae895e2d2d1))
* simplify config.lua ([df80a1c](https://github.com/S1M0N38/ai.nvim/commit/df80a1c8fd56f780069c30e7669969f2972cef6d))
* updated deprecated vim.fn.json_encode/decode ([209fede](https://github.com/S1M0N38/ai.nvim/commit/209fedeb523e938f9d53b694bbc81640cbd0d374))


### Bug Fixes

* add on_exit to chat_completion_create ([e20f0cc](https://github.com/S1M0N38/ai.nvim/commit/e20f0cc2461a550a76bc210ef506d13dd1d0a3fe))
* **docs:** minor typos in ai.txt ([ffc1bd8](https://github.com/S1M0N38/ai.nvim/commit/ffc1bd85087dbec11696ce6deecba0270e429ec9))
* env var for groq api key in gh action ([fe6cc8e](https://github.com/S1M0N38/ai.nvim/commit/fe6cc8efe82964c85b59bad00b471e44b339e36f))
* regex in match for stdout ([f010441](https://github.com/S1M0N38/ai.nvim/commit/f01044159df1e3349a40d44cf0534ee0bd46c0d2))
* tutorial on_chat_completion_chunk ([67d5eab](https://github.com/S1M0N38/ai.nvim/commit/67d5eabc80a23b17f25538891589bcc24802829e))
* type checking for lua-lang-server ([6527047](https://github.com/S1M0N38/ai.nvim/commit/6527047c02be066710eb0387a6d597232ff0cd2e))


### Code Refactoring

* remove verbose type annotation and old testing ([cc5f9e3](https://github.com/S1M0N38/ai.nvim/commit/cc5f9e3b00501d768ed78b6e2dc96d98db65ecf0))

## [0.1.1](https://github.com/S1M0N38/ai.nvim/compare/v0.1.0...v0.1.1) (2024-09-02)


### Bug Fixes

* **docs:** minor typos in ai.txt ([ffc1bd8](https://github.com/S1M0N38/ai.nvim/commit/ffc1bd85087dbec11696ce6deecba0270e429ec9))
* tutorial on_chat_completion_chunk ([67d5eab](https://github.com/S1M0N38/ai.nvim/commit/67d5eabc80a23b17f25538891589bcc24802829e))
