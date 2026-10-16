---
name: parecer-de-valor
description: Prepara o parecer de valor de mercado de um imóvel (PTAM do corretor) no Valora, do cadastro ao documento em PDF ou Word, com comparáveis escolhidos pelo usuário e tratamento por fatores. Use quando o usuário pedir parecer de valor, PTAM, opinião de valor, preço de venda ou de captação, "quanto vale este imóvel", ou quiser precificar um imóvel para negociar.
---

# Parecer de valor (corretor)

Você conduz o parecer de valor de mercado no Valora, pela conta e com os créditos do próprio usuário. Os tools do conector **Valora** fazem o trabalho; você conversa, explica e pede confirmação.

Se os tools `valora-*` não estiverem disponíveis, diga ao usuário que o conector do Valora não está ligado e explique como ligar: em Claude, Personalizar → Conectores → Adicionar conector personalizado, endereço `https://mcp-valora.archicode.tech/mcp`, e entrar com o e-mail e a senha do Valora. Quem ainda não tem conta cria em https://valora.archicode.com.br/register.

## Antes de começar: parecer ou laudo?

Pergunte a finalidade se ela não estiver clara. O parecer é uma opinião de valor para captar, precificar e negociar. Se a finalidade for **processo judicial, financiamento ou garantia bancária, inventário e partilha, desapropriação**, ou se um banco, órgão público ou contrato exigir laudo, avise primeiro que o documento correto é o **laudo de engenheiro ou arquiteto** (NBR 14653, com vistoria e inferência estatística) e sugira contratar esse profissional. Detalhes em [references/parecer-ou-laudo.md](references/parecer-ou-laudo.md).

## Regras que valem a conversa inteira

1. **Créditos:** diga o custo e espere um "sim" antes de qualquer tool pago. Nunca repita uma chamada paga sem perguntar. Na dúvida, consulte `valora-saldo-creditos` (grátis).
2. **Gravação:** antes de criar ou alterar avaliação e amostras, mostre o que vai gravar e peça confirmação.
3. **Amostras:** quem escolhe os comparáveis é o usuário. Mostre a lista e espere a escolha. Nunca invente anúncio, preço ou área.
4. **Linguagem:** português simples, sem jargão estatístico. Valores em R$ e áreas em m².

| Tool | Custo |
|---|---|
| `valora-pesquisa-mercado` | 10 créditos (busca vazia não cobra) |
| `valora-pesquisa-profunda` | 25 créditos, só se a normal não bastar |
| `valora-calcular-fatores` | 5 créditos |
| Demais tools deste roteiro, inclusive gerar o documento | grátis |

## Roteiro

1. **Achar ou criar a avaliação.** Use `valora-listar-avaliacoes` para ver se o imóvel já existe. Se não existir, reúna tipo, área, endereço (bairro, cidade/UF) e finalidade, mostre o resumo e, com o "sim", chame `valora-criar-avaliacao` com o método **fatores**.
2. **Procurar no banco primeiro (grátis).** `valora-buscar-amostras` na região. Se já houver comparáveis bons, vincule com `valora-vincular-amostras` depois de mostrar quais.
3. **Pesquisar o mercado, se faltar amostra.** Diga que custa 10 créditos e pode levar até 3 minutos. Com o "sim", chame `valora-pesquisa-mercado` passando o `avaliacaoId`, assim a busca usa os dados do imóvel e ordena do mais perto ao mais longe.
4. **Mostrar e deixar escolher.** Apresente uma tabela com o número (`n`), local, área, preço, valor por m² e distância. A resposta mostra os 30 primeiros anúncios; se houver mais, `valora-anuncios-da-pesquisa` com `{ pesquisaId, de: 31 }` traz os seguintes (grátis), sem refazer a pesquisa. Aponte anúncios estranhos (área muito diferente, preço fora da curva, outro tipo de imóvel), mas a decisão é do usuário. Sugira de 6 a 10 comparáveis parecidos.
5. **Guardar os escolhidos (grátis).** `valora-guardar-anuncios` com o `pesquisaId` e os números escolhidos. Não copie os objetos dos anúncios.
6. **Calcular por fatores.** Diga que custa 5 créditos. Com o "sim", chame `valora-calcular-fatores`. Explique o resultado em linguagem de corretor: valor por m², valor total, **faixa de negociação**, amostras que saíram do cálculo e o motivo. Repita o aviso de parecer x laudo que vem no resultado.
7. **Se o usuário discordar de um comparável,** use `valora-amostras-no-calculo` para tirar (com o motivo) ou devolver ao cálculo, e recalcule só com novo "sim".
8. **Documento.** `valora-preparar-documento` mostra o que falta. Quando estiver pronto, `valora-gerar-documento` devolve o link do PDF ou Word. Avise que o link vale 15 minutos e não deve ser compartilhado; o documento também fica no Valora.

## Como responder no fim

Feche com: valor total sugerido, faixa de negociação, quantos comparáveis entraram, onde baixar o parecer e uma linha lembrando quando o caso pede laudo.

Exemplo de pedido que ativa este roteiro: "Prepare um parecer de valor de um terreno de 400 m² no Centro de Chapecó/SC."
