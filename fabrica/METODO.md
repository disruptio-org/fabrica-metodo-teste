# O método da Disruptio

Este projeto segue o método da Disruptio. Cada história é um issue do GitHub criado no backoffice, com as secções
User story, Objetivo, Descrição, Requisitos funcionais, Requisitos não funcionais, Critérios de aceitação,
Cenários (Gherkin), Entrevistas às personas e Design. Um épico é um issue com a etiqueta `épico`; as histórias dele
são os sub-issues. O estado de uma história é a etiqueta `estado:*` e só muda pelos comandos abaixo.

| Etiqueta | Estado | Próximo comando |
|---|---|---|
| `estado:design` | Em design | /design |
| `estado:aprovar-design` | Design para aprovar | /aprovar-design (só o Iago) |
| `estado:pronta-dev` | Pronta para desenvolvimento | /desenvolver |
| `estado:em-dev` | Em desenvolvimento | (a equipa está a trabalhar) |
| `estado:qa` | Em QA | /qa |
| `estado:aceitacao` | Teste de aceitação | /aceitacao |
| `estado:merge` | Pronta para merge | /merge (só o Iago) |

Quando o issue fecha, a história fica Feita.

## Regras

- Escreve sempre em português de Portugal. Quando falas com o Iago, trata-o por «você».
- Para mudar de estado: `gh issue edit <n> --remove-label estado:<atual> --add-label estado:<novo>`.
- Uma falha no QA ou no teste de aceitação volta a `estado:em-dev`, com um comentário que explica o que falhou.
- Ramos: `historia-<n>-design`, `historia-<n>-front`, `historia-<n>-back` e `historia-<n>` (integração).
- O design fica em `docs/design/<n>/` e as ligações vão para a secção «Design» do issue.
- Ao editar o corpo de um issue, muda só a secção certa e mantém o resto igual (`gh issue edit <n> --body-file`).
- QA: cobertura mínima de 80% e resposta máxima de 500 ms.
- O merge só se faz com `/merge <n>`, depois do ok do Iago. O hook bloqueia `gh pr merge` e `git merge` para o ramo principal sem a etiqueta `estado:merge`.
- Não escrevas código de uma história antes de o design estar aprovado. Num ramo `historia-<n>...`, o hook bloqueia edições fora de `docs/design/` enquanto a história está em `estado:design` ou `estado:aprovar-design`.
- Os comandos `/aprovar-design` e `/merge` são do Iago. Não os corras por iniciativa própria.
