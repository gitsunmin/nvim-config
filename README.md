# Welcome to the My Nvim Configuration!

This is my neovim configuration.


## Setting up
1. Install neovim on your system. (brew recommended for macOS users)
2. Clone this project on `~/.config/nvim`

## key

### vim (Default)

- ^: focus on the first letter of a sentence
- $: focus on the last letter of a sentence
- d$: delete from cursor to end of line 
- ${number}G: focus on a specific line
- gg: focus on a first line
- G: focus on a last line



### Custom

- i: change mode to write mode
- jj: change mode to read mode 

### tree (nvim-tree)

#### Default

- Enter, o: open file or folder
- a: create file or folder
- d: remove file or folder
- r: rename file or folder
- I: view hidden files toggle
- q: close tree view

#### Custom

- space + e: Fold and unfold the tree view.
- space + n: focus tree view

### buffer (bufferline)

#### Custom

- Tab: next buffer
- Shift + Tab: previous buffer
