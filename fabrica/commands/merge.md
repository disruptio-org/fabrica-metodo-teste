---
description: "O Iago dá o ok e faz-se o merge de uma história (estado:merge)"
argument-hint: "<issue>"
disable-model-invocation: true
---
Pedido: $ARGUMENTS

O primeiro número do pedido é o issue da história (<n>).

Este comando é do Iago: escrevê-lo é o ok dele para o merge.

1. Lê o issue com `gh issue view <n> --json number,title,body,labels,url`. Se não tiver a etiqueta `estado:merge`, para: diz ao Iago em que estado está e qual é o comando certo.
2. Encontra o pull request que fecha a história (o que tem «Closes #<n>»).
3. `gh pr merge <pr> --squash --delete-branch`
4. Confirma com `gh issue view <n> --json state` que o issue fechou; se não fechou, `gh issue close <n> --reason
   completed`. No backoffice a história passa a Feita.


No fim, fala com o Iago em português de Portugal, trata-o por «você» e diz-lhe o próximo passo.
