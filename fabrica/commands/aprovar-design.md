---
description: "O Iago aprova ou devolve o design de uma história"
argument-hint: "<issue> [não: motivo]"
disable-model-invocation: true
---
Pedido: $ARGUMENTS

O primeiro número do pedido é o issue da história (<n>).

Este comando é do Iago: só o corres porque ele o escreveu.

1. Lê o issue com `gh issue view <n> --json number,title,body,labels,url`. Se não tiver a etiqueta `estado:aprovar-design`, para: diz ao Iago em que estado está e qual é o comando certo.
2. Se depois do número vier «não» ou «devolver»: comenta no issue «Design devolvido pelo Iago: <motivo>», corre
   `gh issue edit <n> --remove-label estado:aprovar-design --add-label estado:design` e diz que o UX/UI refaz com `/design <n>`.
3. Senão: na secção «## Design» do corpo, troca a linha «Aprovado por …» por «Aprovado por Iago em: <data de hoje,
   AAAA-MM-DD>», sem mudar o resto; comenta «Design aprovado pelo Iago.»; corre
   `gh issue edit <n> --remove-label estado:aprovar-design --add-label estado:pronta-dev`. O desenvolvimento começa com `/desenvolver <n>`.


No fim, fala com o Iago em português de Portugal, trata-o por «você» e diz-lhe o próximo passo.
