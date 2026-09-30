---
description: "O UX/UI desenha o protótipo de uma história (estado:design)"
argument-hint: "<issue>"
---
Pedido: $ARGUMENTS

O primeiro número do pedido é o issue da história (<n>).

1. Lê o issue com `gh issue view <n> --json number,title,body,labels,url`. Se não tiver a etiqueta `estado:design`, para: diz ao Iago em que estado está e qual é o comando certo.
2. Lança o agente `ux-ui` com o número, o título e o corpo do issue, e esta tarefa:
   - criar o ramo `historia-<n>-design` a partir do ramo principal;
   - fazer o protótipo em HTML em `docs/design/<n>/prototipo.html`, no estilo do projeto, com os estados vazio, de
     erro e de carregamento;
   - tirar imagens dos ecrãs principais para `docs/design/<n>/` (PNG);
   - fazer commit e push do ramo;
   - na secção «## Design» do issue, escrever `Protótipo: <ligação no GitHub para o prototipo.html no ramo>` e
     `Imagens: <ligação 1> · <ligação 2>`, sem mudar o resto do corpo;
   - comentar no issue um resumo das decisões de design.
3. `gh issue edit <n> --remove-label estado:design --add-label estado:aprovar-design`
4. Diz ao Iago o que foi desenhado e onde vê o protótipo. Ele aprova com `/aprovar-design <n>` ou devolve com
   `/aprovar-design <n> não: <motivo>`.


No fim, fala com o Iago em português de Portugal, trata-o por «você» e diz-lhe o próximo passo.
