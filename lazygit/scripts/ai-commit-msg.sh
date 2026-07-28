#!/usr/bin/env bash
# staged diff를 claude 에게 보내 한 줄짜리 커밋 메시지를 생성한다.
# lazygit customCommand의 prompts[].initialValue (runCommand)에서 호출되므로
# stdout은 반드시 한 줄이어야 한다.
#
# 프로젝트 루트에 .claude/lazygit-commit-instructions.md 가 있으면
# 그 내용을 커밋 메시지 작성 지침으로 사용하고, 없으면 기본 규칙을 사용한다.
set -euo pipefail

diff="$(git diff --staged)"

if [ -z "$diff" ]; then
  echo "chore: 변경사항 없음 (staged diff가 비어있습니다)"
  exit 0
fi

default_instructions="Conventional Commits 형식(feat/fix/refactor/docs/chore/style/test 등)으로 한국어 커밋 메시지를 작성하세요."

repo_root="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
guide_file="${repo_root}/.claude/lazygit-commit-instructions.md"

if [ -f "$guide_file" ]; then
  instructions="$(cat "$guide_file")"
else
  instructions="$default_instructions"
fi

prompt="다음은 git staged diff입니다. 아래 [지침]을 따라 커밋 메시지를 작성하세요.

[지침]
${instructions}

[출력 제약사항 - 반드시 지킬 것]
- 결과는 줄바꿈 없이 한 줄로만 출력하세요.
- 설명, 따옴표, 마크다운 코드블록 없이 커밋 메시지 텍스트만 출력하세요.

[diff]
${diff}"

claude -p "$prompt" --output-format text 2>/dev/null | tr '\n' ' ' | sed -E 's/^"|"$//g; s/[[:space:]]+$//'
