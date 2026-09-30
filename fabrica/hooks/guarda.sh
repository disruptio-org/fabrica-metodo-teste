#!/usr/bin/env bash
# Fábrica: trava do merge e do desenvolvimento. Lê o pedido do Claude Code (JSON) e sai com 2 para o bloquear.
MERGE_LOCK=1
DEV_LOCK=1
input="$(cat)"
pick() { printf '%s' "$input" | grep -o "\"$1\"[[:space:]]*:[[:space:]]*\"[^\"]*" | head -n 1 | sed -E "s/^\"$1\"[[:space:]]*:[[:space:]]*\"//"; }
tool=$(pick tool_name)
block() { echo "$1" >&2; exit 2; }
labels_of() {
  dir=$(git rev-parse --git-dir 2>/dev/null) || dir=""
  cache="${dir:+$dir/fabrica-estado-$1}"
  if [ -n "$cache" ] && [ -n "$(find "$cache" -mmin -2 2>/dev/null)" ]; then cat "$cache"; return; fi
  out=$(gh issue view "$1" --json labels --jq '.labels[].name' 2>/dev/null)
  [ -n "$cache" ] && printf '%s\n' "$out" > "$cache"
  printf '%s\n' "$out"
}
has_label() { labels_of "$1" | grep -qx "$2"; }

if [ "$tool" = "Bash" ] && [ "$MERGE_LOCK" = 1 ]; then
  cmd=$(pick command)
  if printf '%s' "$cmd" | grep -Eq '(^|[;&|[:space:]])gh[[:space:]]+pr[[:space:]]+merge'; then
    pr=$(printf '%s' "$cmd" | sed -nE 's/.*gh[[:space:]]+pr[[:space:]]+merge[[:space:]]+([0-9]+).*/\1/p')
    issues=$(gh pr view $pr --json closingIssuesReferences --jq '.closingIssuesReferences[].number' 2>/dev/null)
    [ -z "$issues" ] && block "Merge bloqueado pelo método da Disruptio: este pull request não fecha nenhuma história (falta «Closes #<n>»). O merge faz-se com /merge <n>, depois do ok do Iago."
    for n in $issues; do
      has_label "$n" "estado:merge" || block "Merge bloqueado: a história #$n não está em estado:merge. O merge só se faz com /merge $n, depois do teste de aceitação e do ok do Iago."
    done
  fi
  if printf '%s' "$cmd" | grep -Eq '(^|[;&|[:space:]])git[[:space:]]+merge([[:space:]]|$)' && ! printf '%s' "$cmd" | grep -Eq 'merge[[:space:]]+--(abort|continue)'; then
    cur=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    main=$(git symbolic-ref --short refs/remotes/origin/HEAD 2>/dev/null | sed 's#^origin/##')
    if [ "$cur" = "${main:-main}" ] || [ "$cur" = main ] || [ "$cur" = master ]; then
      n=$(printf '%s' "$cmd" | grep -oE 'historia-[0-9]+' | head -n 1 | sed 's/historia-//')
      [ -z "$n" ] && block "Merge para $cur bloqueado pelo método da Disruptio. O merge de uma história faz-se com /merge <n>, depois do ok do Iago."
      has_label "$n" "estado:merge" || block "Merge bloqueado: a história #$n não está em estado:merge. O merge só se faz com /merge $n."
    fi
  fi
fi

if [ "$DEV_LOCK" = 1 ] && [ "$tool" != "Bash" ]; then
  n=$(git rev-parse --abbrev-ref HEAD 2>/dev/null | sed -nE 's/^historia-([0-9]+).*/\1/p')
  if [ -n "$n" ]; then
    path="$(pick file_path)$(pick notebook_path)"
    case "$path" in *docs/design/*|*docs\\\\design\\\\*) exit 0 ;; esac
    if labels_of "$n" | grep -Eqx 'estado:(design|aprovar-design)'; then
      block "Edição bloqueada: a história #$n ainda está em design. Até o Iago aprovar com /aprovar-design $n, só se edita docs/design/$n/."
    fi
  fi
fi
exit 0
