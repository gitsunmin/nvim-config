# My Neovim Configuration

A personal Neovim setup built on [lazy.nvim](https://github.com/folke/lazy.nvim), focused on file
navigation, Git workflows, GitHub/PR review, LSP-powered editing, and Claude Code integration.

## Requirements

- **Neovim** 0.10+ (LSP auto-enable via `vim.lsp.enable` requires a recent build)
- **git** — used by lazy.nvim to fetch plugins
- **[Nerd Font](https://www.nerdfonts.com/)** — required for file icons (nvim-web-devicons, bufferline)
- **[ripgrep](https://github.com/BurntSushi/ripgrep)** — powers Telescope `live_grep`
- **[lazygit](https://github.com/jesseduffield/lazygit)** — `brew install lazygit`
- **[ImageMagick](https://imagemagick.org/)** and **[luarocks](https://luarocks.org/)** — required by image.nvim: `brew install imagemagick luarocks`
- A terminal that supports the **Kitty graphics protocol** (Kitty, WezTerm, etc.) for inline image previews
- **[GitHub CLI](https://cli.github.com/)**, authenticated — `brew install gh && gh auth login` (required by octo.nvim)
- **[Claude Code CLI](https://github.com/anthropics/claude-code)** — `npm install -g @anthropic-ai/claude-code`

LSP servers and formatters (e.g. `lua_ls`, `stylua`) are installed automatically by
[mason.nvim](https://github.com/williamboman/mason.nvim) on first launch — no manual setup needed.

## Setup

1. Install Neovim (macOS: `brew install neovim`).
2. Clone this repo to `~/.config/nvim`.
3. Launch `nvim`. On first run, lazy.nvim bootstraps itself and installs all plugins automatically.
4. Run `bash scripts/install-lazygit-config.sh` to enable the lazygit "AI commit message" custom
   command (see [lazygit/](#lazygit-ai-commit-message) below). Requires the `claude` CLI to be
   installed and logged in.

## Project Structure

```
init.lua                   -- entry point; loads config.options, config.keymaps, config.lazy
lua/
  config/
    options.lua             -- core vim.opt settings (indentation, clipboard, undo, search, etc.)
    keymaps.lua              -- global keymaps that don't belong to any single plugin
    lazy.lua                 -- lazy.nvim bootstrap + plugin spec loader
  plugins/
    colorscheme.lua          -- tokyonight theme
    nvim-tree.lua             -- file explorer
    telescope.lua             -- fuzzy finder
    toggleterm.lua            -- floating terminal + lazygit
    git.lua                   -- gitsigns + gitgraph
    image.lua                 -- inline image preview
    octo.lua                  -- GitHub issues/PRs
    claudecode.lua            -- Claude Code integration
    bufferline.lua            -- buffer tabs
    lsp.lua                   -- mason + mason-lspconfig + nvim-lspconfig
    cmp.lua                   -- nvim-cmp autocompletion
    conform.lua               -- code formatting
```

Every file under `lua/plugins/` is loaded automatically by lazy.nvim (`{ import = "plugins" }` in
`lua/config/lazy.lua`) — to add a plugin, drop a new spec file in that directory, no other wiring
required.

## Editor Options

Set in `lua/config/options.lua`:

| Option | Value | Why |
| --- | --- | --- |
| `number` / `relativenumber` | on | absolute + relative line numbers |
| `title` / `titlestring` | on | shows the current directory/file in the terminal title |
| `termguicolors` | on | true-color support, required for the theme and bufferline/gitsigns colors |
| `clipboard` | `unnamedplus` | `y`/`p` share the system clipboard automatically |
| `ignorecase` / `smartcase` | on | case-insensitive search unless the pattern has an uppercase letter |
| `expandtab` / `shiftwidth` / `tabstop` | 2 spaces | indentation style |
| `undofile` | on | undo history persists across restarts |
| `langmap` | Korean → QWERTY | lets normal-mode commands work even while the IME shows Hangul |

## Keymaps

`<leader>` is `<Space>`.

### Vim defaults (reference)

- `^` / `$` — jump to first / last character of the line
- `d$` — delete from cursor to end of line
- `{n}G` / `gg` / `G` — jump to line `{n}` / first line / last line
- `y`, `yy`, `yw`, `y$` — yank selection / line / word / to end of line
- `"+y` / `"+p` — yank / put via the system clipboard (not needed here since `clipboard=unnamedplus` is set, but still works explicitly)
- `p` / `P` — put after / before cursor
- `u` / `Ctrl-r` — undo / redo
- `U` — undo all latest changes on the current line

### General (`lua/config/keymaps.lua`)

- `jj` (insert mode) — switch to normal mode
- `<C-h/j/k/l>` — move focus between windows

### File Explorer — nvim-tree (`lua/plugins/nvim-tree.lua`)

- `<leader>e` — toggle the tree
- `<leader>n` — focus the tree window
- (tree defaults) `Enter`/`o` open, `a` create, `d` delete, `r` rename, `I` toggle hidden files, `q` close

### Telescope (`lua/plugins/telescope.lua`)

- `<leader>ff` — find files
- `<leader>fg` — live grep
- `<leader>fb` — list buffers
- `<leader>fh` — search help tags

### Git — gitsigns (`lua/plugins/git.lua`)

- Gutter signs (`│` add/change, `_` delete) appear automatically on changed lines
- `]h` / `[h` — jump to next / previous hunk
- `<leader>gp` — preview hunk
- `<leader>gs` / `<leader>gu` — stage / unstage hunk
- `<leader>gr` — reset hunk
- `<leader>gb` — show blame for the current line

### Git Graph — gitgraph.nvim (`lua/plugins/git.lua`)

- `<leader>gl` — draw the commit graph (all branches, up to 5000 commits)

### Lazygit — toggleterm (`lua/plugins/toggleterm.lua`)

- `<leader>lg` — open Lazygit in a floating terminal
- `q` — quit Lazygit (Lazygit's own keymap)

### Image Preview — image.nvim (`lua/plugins/image.lua`)

- Images referenced in Markdown render inline automatically (PNG, JPG, GIF, …)
- `<leader>ic` — clear all rendered images from the screen

### GitHub — octo.nvim (`lua/plugins/octo.lua`)

- `<leader>oil` / `<leader>oic` — list / create issues
- `<leader>opl` / `<leader>opc` — list / create PRs
- `<leader>opd` — view PR diff
- `<leader>opm` — merge PR
- `<leader>oca` — add comment
- `<leader>ora` / `<leader>ors` — start / submit review
- `<leader>olb` — add label
- `<leader>oas` — add assignee

### Claude Code — claudecode.nvim (`lua/plugins/claudecode.lua`)

- `<leader>ac` — toggle the Claude terminal
- `<leader>af` — focus the Claude terminal
- `<leader>ar` — resume the previous conversation (`--resume`)
- `<leader>aC` — continue the conversation (`--continue`)
- `<leader>am` — select model
- `<leader>ab` — add the current buffer to Claude's context
- `<leader>as` (visual mode) — send the selection to Claude
- `<leader>as` (in nvim-tree/neo-tree/oil/etc.) — add the selected file to Claude's context
- `<leader>aa` / `<leader>ad` — accept / deny a diff

### Buffers — bufferline.nvim (`lua/plugins/bufferline.lua`)

- `<Tab>` / `<S-Tab>` — next / previous buffer

### LSP (`lua/plugins/lsp.lua`)

Servers are installed automatically via mason.nvim (`ensure_installed` in `lua/plugins/lsp.lua`);
currently only `lua_ls`. `folke/lazydev.nvim` additionally provides accurate `vim.*` API
completion when editing Lua files in this config itself.

- `gd` — go to definition
- `gD` — go to declaration
- `gr` — list references
- `gi` — go to implementation
- `K` — hover documentation
- `<leader>cr` — rename symbol
- `<leader>ca` — code action
- `]d` / `[d` — next / previous diagnostic

To add a language: append its `lspconfig` server name to `ensure_installed` in `lua/plugins/lsp.lua`
(mason will install the binary on next launch).

### Completion — nvim-cmp (`lua/plugins/cmp.lua`)

- `<C-n>` / `<C-p>` — select next / previous completion item
- `<C-Space>` — trigger completion manually
- `<CR>` — confirm the selected item

### Formatting — conform.nvim (`lua/plugins/conform.lua`)

- `<leader>cf` (normal/visual) — format the buffer/selection (`stylua` for Lua, falls back to the LSP formatter if no formatter is configured for the filetype)

## lazy.nvim

`lua/config/lazy.lua` enables the update checker (`checker.enabled = true`), so lazy.nvim notifies
you in its UI (`:Lazy`) when a newer plugin version is available — it never updates automatically.
Run `:Lazy update` to apply updates, or `:Lazy sync` to install/update/clean in one step.

## Workflow: Project-wide Find & Replace (Telescope + quickfix)

How to replace the same phrase across many files at once.
Example: replace `ESLint plugin` with `ESLint` everywhere in the project.

### Background

The **quickfix list** is Neovim's single, built-in store of `file + line + content` entries — grep
results, LSP diagnostics, search results, etc. Once populated, `:cdo`/`:cfdo` can run a command
across every entry in bulk, which is what makes project-wide replace possible.

Telescope's `<C-q>` sends **all** current results to the quickfix list (`Enter` instead jumps to
just one and closes Telescope).

### Steps

1. **Search**

   ```
   <leader>fg        (:Telescope live_grep)
   ```

   Type `ESLint plugin` as the search term. A results list appears.

2. **Send all results to quickfix**

   ```
   Ctrl-q
   ```

   Telescope closes and the quickfix window opens with every matched location.

3. **Replace in bulk**

   ```vim
   :cfdo %s/ESLint plugin/ESLint/g | update
   ```

4. Done. Close the quickfix window with `:cclose`.

### Command breakdown

`:cfdo %s/ESLint plugin/ESLint/g | update`

| Piece | Meaning |
| --- | --- |
| `:cfdo` | run the following command once per **file** that appears in the quickfix list |
| `%s/A/B/g` | replace A with B across the whole file (`%`), all occurrences per line (`g`) |
| `\| update` | save only if the file changed. **Without this, cfdo can't move to the next file and errors out** |

### `:cdo` vs `:cfdo`

- `:cdo` — runs once per quickfix **entry**. 3 matches in one file → runs 3 times.
- `:cfdo` — runs once per **file** that appears in the quickfix list.

Since `%s/.../g` already sweeps the entire file, pair it with `:cfdo` to avoid redundant runs. If you
only want to change the matched line itself (`s/.../ ` without `%`), use `:cdo` instead.

### Safety nets

- **Preview each replacement** — use the `gc` flag instead of `g` to be prompted y/n at every match:

  ```vim
  :cfdo %s/ESLint plugin/ESLint/gc | update
  ```

- **Undo** — right after replacing, the quickfix list is still intact, so:

  ```vim
  :cfdo undo | update
  ```

- Committing before the replace makes it easy to review the result with `git diff`.

### Telescope keymaps for this workflow

| Key | Action |
| --- | --- |
| `<C-q>` | send **all** results to quickfix |
| `<M-q>` (Alt-q) | send only the **multi-selected** entries to quickfix |
| `<Tab>` | toggle multi-select on an entry |

To replace only some matches, multi-select with `<Tab>` and send with `<M-q>`.

### Quickfix commands

```vim
:copen      " open the quickfix window
:cclose     " close it
:cnext      " go to the next entry (:cn)
:cprev      " go to the previous entry (:cp)
:cfirst     " go to the first entry
:clast      " go to the last entry
```

### Without Telescope

Sometimes `<C-q>` gets intercepted by the terminal's flow control and doesn't fire (adding
`stty -ixon` to your shell config fixes this). In that case, use `:grep` instead — it populates the
quickfix list the same way.

```vim
:set grepprg=rg\ --vimgrep        " use ripgrep (put this in options.lua so you don't repeat it)
:grep "ESLint plugin" src/
:copen
:cfdo %s/ESLint plugin/ESLint/g | update
```

### Targeting files directly (argdo)

To target "files under this path" without searching first, use `:args` + `:argdo`.

```vim
:args src/content/**/*.mdx
:argdo %s/ESLint plugin/ESLint/ge | update
```

The `e` flag prevents an error abort on files that don't contain a match.

## lazygit AI commit message

`lazygit/` in this repo holds a custom lazygit command that generates a commit message from the
staged diff using the `claude` CLI:

```
lazygit/
  config.yml                   -- customCommands: Ctrl+a in the files panel
  scripts/ai-commit-msg.sh     -- builds the prompt, calls `claude -p`, prints a single line
```

lazygit itself reads its config from `~/Library/Application Support/lazygit/` (macOS) rather than
from this repo, so `scripts/install-lazygit-config.sh` symlinks the files above into that location.
Re-run it any time you edit `lazygit/config.yml` or `lazygit/scripts/ai-commit-msg.sh` to be sure —
though since they're symlinks, edits here take effect immediately without re-running the script.

Per-project commit message style can be customized by adding a
`.claude/lazygit-commit-instructions.md` file to any git repo (see this repo's own copy for an
example) — the script uses it as the instructions for `claude` if present, falling back to a
generic Conventional Commits + Korean rule otherwise.
