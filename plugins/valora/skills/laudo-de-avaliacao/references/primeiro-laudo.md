# Um laudo do zero pela conversa — o que acontece de verdade

Registro de uma jornada completa feita em outubro de 2026 com um avaliador no primeiro contato com o Valora: terreno urbano de 315 m² em Balneário Camboriú/SC, finalidade garantia bancária, sem id nenhum em mãos, pedidos curtos ("quero começar um laudo de um terreno"). Serve de referência para conduzir o mesmo caminho e para reconhecer os tropeços antes que eles custem créditos ou tempo.

## A sequência que funcionou

| Passo | O que o avaliador disse | O que o assistente fez | Tempo típico |
|---|---|---|---|
| 1 | "Quero fazer um laudo de um terreno." | Uma rodada de perguntas: endereço com número, bairro, cidade, área do terreno, testada, finalidade, solicitante, o que ele acha que explica o preço ali. | — |
| 2 | Respondeu tudo numa mensagem. | Mostrou o resumo e pediu "sim" para criar a avaliação (comparativo). `valora-criar-avaliacao`. | segundos |
| 3 | "Pode pesquisar." | Avisou 10 créditos e até 3 min. `valora-pesquisa-mercado` com `avaliacaoId`. Veio 68 anúncios; a resposta mostra 30, o resto fica guardado (`valora-anuncios-da-pesquisa`, `de: 31`). | 1–3 min |
| 4 | Escolheu pelos números ("1 a 25 menos o 7 e o 12"). | `valora-guardar-anuncios` com `pesquisaId` + números. 23 amostras vinculadas. | segundos |
| 5 | "O que manda aqui é a distância do mar." | `valora-relocalizar-amostras` (grátis) antes da distância: 7 amostras estavam no centro do bairro. Depois `valora-variavel-distancia` com a Av. Atlântica como linha (3 endereços ao longo dela). | 1 min |
| 6 | "Roda a busca de modelos." | 15 créditos confirmados. `valora-buscar-modelos`: 1.029 combinações, nenhuma com todas as variáveis significativas. Mostrou os 5 melhores com variáveis, transformações, R² ajustado, valor e amplitude, e a leitura da IA sobre os sinais. | 1–2 min |
| 7 | "Quero área, distância do mar e mais nada." | Explicou que o Valora exige 3 variáveis e propôs opções; o avaliador escolheu "bairro Centro" (dicotômica). `valora-definir-variavel` com valor por amostra e do avaliando. | segundos |
| 8 | "E se eu tirar o anúncio 1? Está muito caro." | `valora-calcular-regressao` com `salvar=false` e `excluirAmostras`. Mostrou o que mudou. Com o "pode tirar", `valora-amostras-no-calculo` com o motivo. | 1–2 min por cálculo |
| 9 | "Grava esse." | `valora-calcular-regressao` com `salvar=true`: ln(preço) ~ ln(área do terreno) + ln(dist. orla) + Centro, 22 amostras, R$ 1,66 mi, IC 80% R$ 1,46–1,90 mi, fundamentação II, precisão III. | 1–2 min |
| 10 | "Adota R$ 1.665.000." | Valor dentro do IC: gravado com justificativa curta. (Para "o máximo do IC arredondado ao milhar", usar `posicaoAdotada` + `arredondarPara`.) | segundos |
| 11 | "Os textos podem ser da IA." | Avisou 5 créditos, `valora-sugestoes-ia`, mostrou cada texto, o avaliador aprovou, `valora-aplicar-sugestoes`. | 30 s |
| 12 | "Gera em Word." | `valora-preparar-documento` (sem pendência) e `valora-gerar-documento` tipo completo, formato Word. Link de 15 min. | 30 s |

Total: cerca de 40 minutos de conversa, 30 créditos (pesquisa 10 + busca 15 + sugestões 5).

## Tropeços conhecidos e como contornar

- **O avaliador não sabe ids.** Nunca peça "me passe o avaliacaoId". Você guarda os ids que os tools devolvem e fala por nome do imóvel e número do anúncio.
- **Só 30 anúncios aparecem na pesquisa.** Os demais ficam guardados por 2 horas: `valora-anuncios-da-pesquisa` com `{ pesquisaId, de: 31 }`. Não refaça a pesquisa para "ver o resto" (cobra 10 créditos de novo).
- **Ponto das amostras no centro do bairro.** Qualquer distância calculada com esse ponto fica errada e a renda IBGE vira a média do município. `valora-relocalizar-amostras` primeiro; o aviso de "coordenada aproximada" na variável de distância é o sinal.
- **Mínimo de 3 variáveis.** Regra do Valora (não da norma). Diga antes de o avaliador montar o modelo mental com 2 variáveis; proponha a terceira entre as que já têm dados (renda IBGE, bairro, esquina pelas fotos) e deixe-o escolher.
- **Busca de modelos × simulação não batem.** A busca ordena por R² ajustado e traz a leitura da IA, mas não traz p-valor por variável nem grau. Um modelo "coerente" na busca pode sair com p-valor alto ao aplicar. Sempre aplique ou simule antes de concluir, e confira se o Y (valor total ou R$/m² e qual área) é o mesmo nos dois.
- **Cálculo demora.** `valora-calcular-regressao` e `valora-buscar-modelos` levam de 1 a 2 minutos. Avise "vai levar um minuto" e não dispare duas chamadas seguidas sem necessidade.
- **Esquina pelas fotos.** A análise das fotos dos anúncios só marca esquina "sim" quando a foto mostra o lote no encontro de duas ruas; muitas ficam "indeterminado". Mostre a tabela e deixe o avaliador completar; não abra os portais.
- **Terreno.** A área que entra é a área do terreno (não área total/útil). O Valora já liga a variável certa numa avaliação nova de terreno; se o modelo vier com "área total" vazia, troque.
- **Modelo não enquadrável.** Não ofereça gerar o laudo. Volte às variáveis, à busca ou ao saneamento.
- **Textos vazios saem em branco.** Antes de gerar, liste o que está vazio (objetivo, solicitante, descrições, diagnóstico de mercado, data-base) e ofereça as sugestões da IA ou peça ao avaliador.
- **Valor adotado antigo.** Recalcular sem pedir valor adotado mantém o anterior se ainda couber na faixa; senão o Valora retira e avisa. Repita o aviso.
- **Permissões do conector no Claude.** Cada tool pago pede aprovação na tela; não insista se o usuário negou.

## O que dizer no fechamento

Valor estimado e intervalo de 80%; graus de fundamentação e precisão e o item que limitou; as variáveis com o sinal de cada uma; o que ficou por conta do avaliador (vistoria, ART/RRT, assinatura, revisão dos textos); o link do documento e o aviso de 15 minutos.
