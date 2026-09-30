---
description: "As personas fazem o teste de aceitação (estado:aceitacao)"
argument-hint: "<issue>"
---
Pedido: $ARGUMENTS

O primeiro número do pedido é o issue da história (<n>).

1. Lê o issue com `gh issue view <n> --json number,title,body,labels,url`. Se não tiver a etiqueta `estado:aceitacao`, para: diz ao Iago em que estado está e qual é o comando certo.
2. Lê a linha «Personas:» no topo do issue. As personas com agente de aceitação são:
   - (ainda não há personas com teste de aceitação ligado no backoffice)
   Uma persona do issue sem agente fica de fora; diz isso ao Iago.
3. Põe a aplicação a correr no ramo do pull request da história. Lança os agentes das personas (podem correr ao
   mesmo tempo), cada um com o issue e a forma de abrir a aplicação. Cada um comenta no issue o seu parecer, a
   começar por «**Parecer de <nome>:** Positivo» ou «**Parecer de <nome>:** Negativo».
4. Se todos os pareceres forem positivos: `gh issue edit <n> --remove-label estado:aceitacao --add-label estado:merge`. A história espera pelo ok do Iago
   (`/merge <n>`).
   Se algum for negativo: comenta «Voltou do teste de aceitação: <resumo>» e corre
   `gh issue edit <n> --remove-label estado:aceitacao --add-label estado:em-dev`.


No fim, fala com o Iago em português de Portugal, trata-o por «você» e diz-lhe o próximo passo.
