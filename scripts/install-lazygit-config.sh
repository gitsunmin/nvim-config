#!/usr/bin/env bash
# 이 저장소의 lazygit/ 설정을 실제 lazygit 설정 디렉터리에 심볼릭 링크로 연결한다.
# 새 PC에서 이 nvim-config 저장소를 clone한 뒤 한 번 실행하면
# lazygit의 "AI 커밋 메시지 생성" 커스텀 커맨드를 그대로 사용할 수 있다.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC_DIR="${REPO_DIR}/lazygit"

case "$(uname -s)" in
  Darwin) LAZYGIT_CONFIG_DIR="${HOME}/Library/Application Support/lazygit" ;;
  *) LAZYGIT_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/lazygit" ;;
esac

mkdir -p "${LAZYGIT_CONFIG_DIR}/scripts"

link() {
  local src="$1" dest="$2"
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    mv "$dest" "${dest}.bak.$(date +%s)"
    echo "기존 파일을 백업했습니다: ${dest} -> ${dest}.bak.*"
  fi
  ln -sf "$src" "$dest"
  echo "linked: ${dest} -> ${src}"
}

link "${SRC_DIR}/config.yml" "${LAZYGIT_CONFIG_DIR}/config.yml"
link "${SRC_DIR}/scripts/ai-commit-msg.sh" "${LAZYGIT_CONFIG_DIR}/scripts/ai-commit-msg.sh"

echo "완료. lazygit을 열어 files 패널에서 Ctrl+a 로 AI 커밋 메시지 생성 기능을 사용할 수 있습니다."
echo "(사전 요구사항: claude CLI 설치 및 로그인 - README 참고)"
