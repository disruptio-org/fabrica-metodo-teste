---
description: "Mostra as histórias deste repositório por estado e o que espera pelo Iago"
---
Mostra ao Iago o quadro das histórias deste repositório.

1. Corre `gh issue list --state open --limit 200 --json number,title,labels,url`.
2. Agrupa as histórias pela etiqueta `estado:*`, pela ordem do método. Mostra os épicos (etiqueta `épico`) à parte.
3. Para cada estado, uma lista curta: número e título.
4. No fim, diz o que espera pelo Iago: as histórias em `estado:aprovar-design` (`/aprovar-design <n>`) e em
   `estado:merge` (`/merge <n>`). Para as outras, diz o próximo comando: design → `/design <n>`,
   pronta-dev → `/desenvolver <n>`, qa → `/qa <n>`, aceitacao → `/aceitacao <n>`.


No fim, fala com o Iago em português de Portugal, trata-o por «você» e diz-lhe o próximo passo.
