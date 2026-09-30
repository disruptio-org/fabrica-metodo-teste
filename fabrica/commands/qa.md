---
description: "O QA testa uma história (estado:qa)"
argument-hint: "<issue>"
---
Pedido: $ARGUMENTS

O primeiro número do pedido é o issue da história (<n>).

1. Lê o issue com `gh issue view <n> --json number,title,body,labels,url`. Se não tiver a etiqueta `estado:qa`, para: diz ao Iago em que estado está e qual é o comando certo.
2. Encontra o pull request da história (`gh pr list --state open --search "#<n>" --json number,headRefName,body` e o
   que tiver «Closes #<n>»).
3. Lança o agente `qa` com o issue e o ramo do pull request. Ele:
   - corre os testes e a cobertura (mínimo 80%);
   - mede os tempos de resposta das rotas da história (máximo 500 ms);
   - experimenta cada cenário em Gherkin, no browser se houver um ligado;
   - marca no corpo do issue os critérios de aceitação que passam (`- [x] CA…`), sem mudar o resto;
   - comenta um relatório: o que passou, o que falhou e como reproduzir.
4. Se tudo passou: `gh issue edit <n> --remove-label estado:qa --add-label estado:aceitacao`. As personas testam com `/aceitacao <n>`.
   Se algo falhou: comenta «Voltou do QA: <o que falhou>» e corre `gh issue edit <n> --remove-label estado:qa --add-label estado:em-dev`.


No fim, fala com o Iago em português de Portugal, trata-o por «você» e diz-lhe o próximo passo.
