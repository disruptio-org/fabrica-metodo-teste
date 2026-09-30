---
description: "Desenvolve uma história com design aprovado (estado:pronta-dev)"
argument-hint: "<issue>"
---
Pedido: $ARGUMENTS

O primeiro número do pedido é o issue da história (<n>).

1. Lê o issue com `gh issue view <n> --json number,title,body,labels,url`. Se não tiver a etiqueta `estado:pronta-dev`, para: diz ao Iago em que estado está e qual é o comando certo.
2. `gh issue edit <n> --remove-label estado:pronta-dev --add-label estado:em-dev`
3. Lança o agente `diretor` com o issue e o design aprovado (`docs/design/<n>/`, no ramo `historia-<n>-design` se
   existir). Ele devolve o plano: o que faz o front-end, o que faz o back-end, o contrato entre os dois e os testes de
   cada critério de aceitação, e publica-o como comentário no issue. O diretor não lança agentes: és tu que os lanças.
4. Lança o agente `front-end` (ramo `historia-<n>-front`) e o agente `back-end` (ramo `historia-<n>-back`), cada um
   com a sua parte do plano. Lança os dois ao mesmo tempo, cada um no seu worktree (isolation: worktree). Os ramos partem de `historia-<n>-design` se existir, senão do principal.
5. Quando os dois acabarem, lança o agente `senior`: junta os dois ramos no ramo `historia-<n>`, revê, corre os testes
   e abre um pull request para o ramo principal com «Closes #<n>» na descrição.
6. Se o pull request abriu e os testes passam: `gh issue edit <n> --remove-label estado:em-dev --add-label estado:qa`. O QA testa com `/qa <n>`.


No fim, fala com o Iago em português de Portugal, trata-o por «você» e diz-lhe o próximo passo.
