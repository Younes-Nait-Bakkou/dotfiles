# Gemini Project: Dotfiles

This document provides a comprehensive overview of the dotfiles repository, its structure, and how to use it.

## Project Overview

This is a dotfiles repository that uses Ansible to automate the setup of a development environment on a local machine. The project is designed to be modular and extensible, allowing users to easily add or remove software and configurations.

## Technologies

The project is built around the following technologies:

*   **Ansible:** For automation and configuration management.
*   **Jinja2:** For templating configuration files.
*   **YAML:** For defining Ansible playbooks and variables.
*   **Shell Scripting:** For various installation and configuration scripts.

## Installation and Usage

The main entry point for the project is the `playbooks/setup.yml` playbook. This playbook is designed to be run on a local machine and will set up the environment according to the roles defined in the `group_vars/all/default_roles.yml` file.

To run the playbook, you can use the following command:

```bash
ansible-playbook playbooks/setup.yml
```

You can also run specific roles by using tags:

```bash
ansible-playbook playbooks/setup.yml --tags <role_name>
```

For example, to run only the `neovim` role, you would use the following command:

```bash
ansible-playbook playbooks/setup.yml --tags neovim
```

## Roles

The following Ansible roles are available in this repository:

*   **system:** Configures system-level settings and installs essential packages.
*   **fonts:** Installs a collection of fonts for the terminal and GUI applications.
*   **lua:** Installs Lua and Luarocks.
*   **fzf:** Installs fzf, a command-line fuzzy finder.
*   **nvm:** Installs nvm, a version manager for Node.js.
*   **node:** Installs Node.js.
*   **npm:** Installs npm packages.
*   **ssh:** Configures SSH and deploys SSH keys.
*   **tmux:** Installs and configures tmux, a terminal multiplexer.
*   **docker:** Installs and configures Docker.
*   **kitty:** Installs and configures kitty, a GPU-based terminal emulator.
*   **glab:** Installs glab, a GitLab command-line tool.
*   **picom:** Installs and configures picom, a compositor for X11.
*   **rofi:** Installs and configures rofi, a window switcher, application launcher, and dmenu replacement.
*   **polybar:** Installs and configures polybar, a fast and easy-to-use status bar.
*   **zsh:** Installs and configures Zsh and Oh My Zsh.
*   **neovim:** Installs and configures Neovim.
*   **i3:** Installs and configures the i3 window manager.

Each role is self-contained and can be run independently. The roles are located in the `roles` directory.

## Development Conventions

The project follows a set of conventions to ensure consistency and maintainability:

*   **Ansible Best Practices:** The project follows the official Ansible best practices for writing playbooks and roles.
*   **YAML Linting:** The `.yamllint` file in the root of the repository defines the YAML linting rules.
*   **Jinja2 Templating:** Jinja2 templates are used for configuration files to allow for dynamic values.
*   **Modular Roles:** Each role is self-contained and can be run independently.
*   **Variable Naming:** Variables are named using a consistent and descriptive naming scheme.
