# AGENTS.md - Agentic Coding Guidelines

This file contains essential information for AI coding agents working in this Neovim configuration repository. Follow these guidelines to maintain consistency with the codebase.

## Build/Lint/Test Commands

### Formatting and Linting
- **Format Lua code**: Run stylua automatically via conform.nvim (`:ConformInfo` to check status)
- **Manual formatting**: `stylua --config-path .stylua.toml .` (requires stylua to be installed)
- **Check formatting**: `stylua --check --config-path .stylua.toml .` (CI command)
- **Linting**: nvim-lint plugin handles linting (markdownlint for markdown files)
- **Health check**: `:checkhealth` to verify Neovim and plugin setup

### Testing
- **No traditional test suite** - This is a configuration repository, not an application
- **Plugin validation**: `:Lazy` to check plugin loading status
- **LSP validation**: `:Mason` to verify LSP server installations
- **Configuration validation**: Open files and check for syntax errors/LSP diagnostics

### Single Test Execution
Since this is a configuration repo, "testing" means:
- **Syntax validation**: `nvim --headless -c "luafile lua/init.lua" -c "qall"` to check for syntax errors
- **Plugin loading**: `:Lazy sync` to ensure plugins install correctly
- **Health verification**: `:checkhealth kickstart` for configuration health

## Code Style Guidelines

### Lua Formatting (.stylua.toml)
```toml
column_width = 160
line_endings = "Unix"
indent_type = "Spaces"
indent_width = 2
quote_style = "AutoPreferSingle"
call_parentheses = "None"
```

### Naming Conventions
- **Variables**: `snake_case` (e.g., `local config_path`, `vim.g.have_nerd_font`)
- **Functions**: `camelCase` for local functions, `PascalCase` for module functions
- **Constants**: `UPPER_SNAKE_CASE` for global constants
- **Modules**: `require 'module.name'` with single quotes

### Imports and Dependencies
```lua
-- Lazy plugin imports (in init.lua)
{ 'owner/repo', opts = {} }

-- Standard Lua requires
local module = require 'module'
local function_name = require('module').function_name

-- Conditional imports
local has_plugin, plugin = pcall(require, 'plugin_name')
```

### Error Handling
```lua
-- Safe plugin loading
pcall(require, 'optional_plugin')

-- Executable checking
if vim.fn.executable('command') == 1 then
  -- command is available
end

-- Graceful failures
local ok, result = pcall(some_function)
if not ok then
  vim.notify('Error message', vim.log.levels.ERROR)
end
```

### Key Mappings
```lua
-- Standard keymap pattern
vim.keymap.set('n', '<leader>key', function() ... end, { desc = 'Description' })

-- Mode-specific mappings
vim.keymap.set({'n', 'v'}, '<leader>key', command, { desc = 'Description' })

-- Buffer-local mappings
vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'Description' })
```

### Autocommands
```lua
-- Standard autocommand pattern
vim.api.nvim_create_autocmd('EventName', {
  group = vim.api.nvim_create_augroup('group_name', { clear = true }),
  callback = function() ... end,
})

-- Multiple events
vim.api.nvim_create_autocmd({ 'Event1', 'Event2' }, {
  group = group,
  callback = callback,
})
```

### Plugin Configuration Patterns

#### Lazy Plugin Spec
```lua
{
  'owner/repo',
  event = 'VeryLazy',  -- or specific events
  dependencies = { 'dep1', 'dep2' },
  keys = {
    { '<leader>key', '<cmd>Command<cr>', desc = 'Description' },
  },
  opts = {
    -- configuration options
  },
  config = function()
    -- custom setup code
  end,
}
```

#### LSP Configuration
```lua
-- Server setup
local servers = {
  lua_ls = {
    settings = {
      Lua = {
        -- lua_ls specific settings
      },
    },
  },
}

-- Attach behavior
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
    end
    -- LSP keymaps
  end,
})
```

### Documentation and Comments
```lua
-- Section headers
-- [[ Section Name ]]

-- Inline comments explaining complex logic
-- NOTE: Important implementation details

-- Type annotations
---@type string
---@param param_name param_type
---@return return_type

-- Extensive file headers in init.lua explaining configuration sections
```

### File Organization
- **init.lua**: Main configuration file (937 lines, single-file design)
- **lua/kickstart/plugins/**: Core plugin configurations
- **lua/custom/plugins/**: User-added plugins
- **lua/kickstart/health.lua**: Health check utilities

### Common Patterns
- **Conditional logic**: `if vim.g.have_nerd_font then ... end`
- **Version checking**: `if vim.version.ge(vim.version(), '0.10-dev') then`
- **Platform detection**: `vim.fn.has 'win32'`, `vim.uv.os_uname()`
- **Option setting**: `vim.o.option = value` or `vim.opt.option = value`
- **Global variables**: `vim.g.variable = value`

### Security Considerations
- **No secrets in code**: Never commit API keys, tokens, or credentials
- **Safe command execution**: Use `vim.fn.system()` with caution
- **Path handling**: Use `vim.fn.stdpath()` for Neovim paths
- **User input validation**: Validate all user-provided paths and commands

### Performance Guidelines
- **Lazy loading**: Use `event`, `keys`, `cmd` to defer plugin loading
- **Efficient autocommands**: Use specific events and buffer-local when possible
- **Table operations**: Prefer functional programming with `vim.tbl_*` utilities
- **String operations**: Use Lua string methods efficiently

### Git and Version Control
- **Commit messages**: Follow conventional commits (feat, fix, docs, refactor, etc.)
- **Branch naming**: `feature/`, `fix/`, `docs/` prefixes
- **Pull requests**: Include descriptions and link to issues
- **Ignore patterns**: Follow `.gitignore` for build artifacts and cache files

## External Tooling

### Mason-managed tools
- **LSP servers**: lua_ls, pyright, gopls (configured in init.lua)
- **Formatters**: stylua (configured in conform)
- **Linters**: markdownlint (configured in nvim-lint)

### Required External Dependencies
- **git, make, unzip**: Basic development tools
- **ripgrep (rg)**: Fast text search
- **C compiler**: For native plugin compilation
- **Node.js/npm**: For TypeScript/JavaScript development
- **Go**: For Go development

## Development Workflow

1. **Make changes** to Lua files
2. **Format code**: Auto-formats on save via conform.nvim
3. **Check syntax**: Open files in Neovim to verify LSP diagnostics
4. **Test changes**: Restart Neovim or `:source` files
5. **Commit**: Use conventional commit messages
6. **PR**: CI will check formatting with stylua

## No Cursor/Copilot Rules Found

This repository does not have Cursor rules (`.cursor/rules/` or `.cursorrules`) or Copilot instructions (`.github/copilot-instructions.md`).</content>
<parameter name="filePath">/Users/kaanyalti/.config/nvim/AGENTS.md