#!/usr/bin/env bash
# Fábrica: no início de cada sessão, o método e as histórias que esperam por ação.
root="${CLAUDE_PLUGIN_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}"
cat "$root/METODO.md"
echo
if command -v gh >/dev/null 2>&1 && gh repo view --json name >/dev/null 2>&1; then
  echo "## Histórias abertas neste repositório"
  for e in design aprovar-design pronta-dev em-dev qa aceitacao merge; do
    n=$(gh issue list --state open --label "estado:$e" --limit 200 --json number --jq 'length' 2>/dev/null)
    if [ -n "$n" ] && [ "$n" != "0" ]; then echo "- estado:$e: $n"; fi
  done
  a=$(gh issue list --state open --label estado:aprovar-design --limit 200 --json number --jq '[.[].number|"#\(.)"]|join(", ")' 2>/dev/null)
  m=$(gh issue list --state open --label estado:merge --limit 200 --json number --jq '[.[].number|"#\(.)"]|join(", ")' 2>/dev/null)
  if [ -n "$a$m" ]; then
    echo
    echo "À espera do Iago: ${a:+design para aprovar ($a) }${m:+merge ($m)}. Diz-lhe isto na primeira resposta."
  fi
else
  echo "(Não consegui ler os issues: o gh não está instalado, não tem sessão, ou isto não é um repositório do GitHub.)"
fi
v=$(grep -o '"version"[[:space:]]*:[[:space:]]*"[^"]*"' "$root/.claude-plugin/plugin.json" | sed -E 's/.*"([^"]*)"$/\1/')
if [ -n "$FABRICA_VERSAO" ] && [ "${v%%.*}" != "$FABRICA_VERSAO" ]; then
  echo
  echo "Nota: este projeto está ligado à versão $FABRICA_VERSAO do método e o plugin instalado é a ${v%%.*}. Se for preciso, lembra o Iago de carregar em «Atualizar» no projeto (backoffice) ou de correr /plugin marketplace update disruptio."
fi
exit 0
