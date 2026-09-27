#!/usr/bin/env bash
# lazygit customCommand(output: terminal)에서 호출되는 AI 커밋 진입점.
#
# 1) staged diff 요약을 보여주고
# 2) claude 가 커밋 메시지를 만드는 동안 스피너 + 경과시간을 표시하고
# 3) 완료되면 `git commit -e -m "<생성된 메시지>"` 로 에디터를 열어 수정/확정한다.
#
# 메시지 생성 자체는 ai-commit-msg.sh 에 위임한다(단독으로도 사용 가능).
set -uo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
generator="${script_dir}/ai-commit-msg.sh"

# --- 터미널 표현 헬퍼 ---------------------------------------------------------
if [ -t 1 ] && [ "$(tput colors 2>/dev/null || echo 0)" -ge 8 ]; then
  dim=$'\033[2m'; bold=$'\033[1m'; red=$'\033[31m'; green=$'\033[32m'; cyan=$'\033[36m'; reset=$'\033[0m'
else
  dim=''; bold=''; red=''; green=''; cyan=''; reset=''
fi

hide_cursor() { [ -t 1 ] && printf '\033[?25l'; }
show_cursor() { [ -t 1 ] && printf '\033[?25h'; }

cleanup() {
  show_cursor
  [ -n "${gen_pid:-}" ] && kill "$gen_pid" 2>/dev/null
  [ -n "${out_file:-}" ] && rm -f "$out_file" "${out_file}.err"
}
trap cleanup EXIT
trap 'echo; echo "${red}취소되었습니다.${reset}"; exit 130' INT

die() {
  echo
  echo "${red}✖ $1${reset}" >&2
  exit 1
}

# --- 사전 확인 ---------------------------------------------------------------
command -v claude >/dev/null 2>&1 || die "claude CLI를 찾을 수 없습니다. README의 설치 안내를 참고하세요."
[ -x "$generator" ] || die "메시지 생성 스크립트를 찾을 수 없습니다: ${generator}"

if git diff --staged --quiet; then
  die "staged 변경사항이 없습니다. 먼저 파일을 스테이징하세요."
fi

stat_line="$(git diff --staged --shortstat | sed 's/^ *//')"

echo
echo "${bold}🤖 AI 커밋 메시지 생성${reset}"
echo "${dim}   ${stat_line}${reset}"
echo

# --- 백그라운드 생성 + 스피너 -------------------------------------------------
out_file="$(mktemp -t lazygit-ai-commit)"
"$generator" >"$out_file" 2>"${out_file}.err" &
gen_pid=$!

frames='⠋ ⠙ ⠹ ⠸ ⠼ ⠴ ⠦ ⠧ ⠇ ⠏'
set -- $frames
frame_count=$#
i=0
start=$(date +%s)

if [ -t 1 ]; then
  hide_cursor
  while kill -0 "$gen_pid" 2>/dev/null; do
    eval "frame=\${$(( i % frame_count + 1 ))}"
    printf '\r  %s%s%s  %sClaude가 staged diff를 분석하는 중...%s %s%ss%s ' \
      "$cyan" "$frame" "$reset" "$dim" "$reset" "$dim" "$(( $(date +%s) - start ))" "$reset"
    i=$(( i + 1 ))
    sleep 0.1
  done
  wait "$gen_pid"
  gen_status=$?
  show_cursor
  printf '\r\033[2K'
else
  # 터미널이 아니면(파이프/로그) 애니메이션 없이 한 줄만 남긴다.
  echo "  Claude가 staged diff를 분석하는 중..."
  wait "$gen_pid"
  gen_status=$?
fi

elapsed=$(( $(date +%s) - start ))
message="$(cat "$out_file")"

if [ "$gen_status" -ne 0 ] || [ -z "$message" ]; then
  err="$(cat "${out_file}.err" 2>/dev/null)"
  [ -n "$err" ] && echo "${dim}${err}${reset}" >&2
  die "커밋 메시지 생성에 실패했습니다 (exit ${gen_status})."
fi

echo "  ${green}✔${reset} 생성 완료 ${dim}(${elapsed}s)${reset}"
echo "  ${bold}${message}${reset}"
echo
echo "${dim}  에디터에서 수정 후 저장하면 커밋됩니다. 내용을 비우고 저장하면 취소됩니다.${reset}"
echo

# --- 확정 --------------------------------------------------------------------
git commit -e -m "$message"
