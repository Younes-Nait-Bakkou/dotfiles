# Gemini Project: Neovim Configuration

This document provides a comprehensive overview of this Neovim configuration, its structure, and how to use it.

## Project Overview

This is a Neovim configuration based on [NvChad](https://nvchad.com/). It's designed to be a personal, highly customized development environment. The configuration is written in Lua and uses `lazy.nvim` for plugin management.

## Technologies

The project is built around the following technologies:

*   **Neovim:** The text editor.
*   **Lua:** The primary configuration language.
*   **NvChad:** The base framework for the configuration.
*   **lazy.nvim:** The plugin manager.

## Installation and Usage

This configuration is intended to be used as a user's Neovim configuration. To use it, you would typically clone this repository to `~/.config/nvim`.

The main entry point for the configuration is `init.lua`. This file bootstraps `lazy.nvim` and loads the plugins.

### Key Files

*   **`init.lua`**: The main entry point for the Neovim configuration. It bootstraps `lazy.nvim` and loads the rest of the configuration.
*   **`lua/plugins/init.lua`**: This file contains the list of all the plugins that are installed and their configurations. It's the central place to manage plugins.
*   **`lua/options.lua`**: This file sets the main Neovim options, such as `shiftwidth`, `tabstop`, and `relativenumber`.
*   **`lua/mappings.lua`**: This file defines all the custom key mappings. It uses the `which-key` plugin to provide hints for the mappings.
*   **`lua/chadrc.lua`**: This file is for configuring NvChad-specific settings.

## Development Conventions

The project follows a set of conventions to ensure consistency and maintainability:

*   **Modular Configuration:** Plugin configurations are stored in separate files under the `lua/configs` directory. This makes it easy to manage the settings for each plugin.
*   **Plugin Management:** Plugins are managed using `lazy.nvim`. The list of plugins is in `lua/plugins/init.lua`.
*   **Key Mappings:** Key mappings are defined in `lua/mappings.lua` and are organized with the help of the `which-key` plugin.
*   **Customization:** The configuration is designed to be highly customizable. Users can add their own plugins, options, and mappings to tailor the editor to their needs.
