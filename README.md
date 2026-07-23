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
- y: copy selected text
- yy: copy current line
- yw: cpoy word
- y$: cpoy to end of line
- "+y: cpoy to system clipboard
- p: put after cursor
- P: put before cursor
- "+p: put from system clipboard
- u: undo last change
- ctrl + r: redo last undone change
- U: undo all recent changes on current line

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

### Telescope

#### Custom

- space + ff: 파일 찾기 (find_files)
- space + fg: 텍스트 검색 (live_grep)
- space + fb: 버퍼 목록 (buffers)
- space + fh: 도움말 검색 (help_tags)

### Git (gitsigns)

#### Default

- 파일 변경 시 줄 번호 옆에 추가(│), 수정(│), 삭제(\_) 표시가 자동으로 나타남

#### Custom

- ]h: 다음 변경 사항으로 이동
- [h: 이전 변경 사항으로 이동
- space + gp: 변경 사항 미리보기 (팝업)
- space + gs: 변경 사항 스테이지 (git add)
- space + gu: 스테이지 취소
- space + gr: 변경 사항 되돌리기 (reset)
- space + gb: 현재 줄의 마지막 커밋 정보 보기 (blame)

### Lazygit (toggleterm)

#### 사전 요구사항

- lazygit 설치 필요: `brew install lazygit`

#### Custom

- space + lg: Lazygit 열기 (플로팅 터미널)
- q: Lazygit 종료 (lazygit 내부 단축키)

### Git Graph (gitgraph.nvim)

#### Custom

- space + gl: Git 그래프 보기 (커밋 히스토리를 그래프로 시각화)

### buffer (bufferline)

#### Custom

- Tab: next buffer
- Shift + Tab: previous buffer
