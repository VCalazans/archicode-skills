# Como manter este repositório

## Estrutura

```
.claude-plugin/marketplace.json   catálogo: lista os plugins
plugins/<produto>/
  .claude-plugin/plugin.json      nome, versão, descrição
  .mcp.json                       conector do produto (opcional)
  skills/<skill>/SKILL.md         uma pasta por skill
  skills/<skill>/references/      material de apoio lido sob demanda
scripts/build-zips.sh             gera os .zip das skills para o chat do Claude
```

## Novo plugin

1. Crie `plugins/<produto>/` com `.claude-plugin/plugin.json` e, se houver servidor MCP, `.mcp.json`.
2. Adicione a entrada em `.claude-plugin/marketplace.json` com `"source": "./plugins/<produto>"`.
3. Rode `claude plugin validate .` na raiz.

## Nova skill

- A pasta tem o mesmo nome do campo `name` do `SKILL.md`: minúsculas, números e hífen.
- O `description` diz o que a skill faz **e quando usar**, com as palavras que o cliente usaria. É o que faz o Claude escolher a skill.
- Corpo curto e direto (até ~500 linhas). Detalhe longo vai para `references/`.
- Toda skill que usa um tool pago diz o custo e exige confirmação antes da chamada.
- Sem nome de cliente, dado pessoal, senha ou chave.

## Publicar uma versão

1. Suba a `version` no `plugin.json` e na entrada do `marketplace.json`.
2. Rode `scripts/build-zips.sh` e confira os arquivos em `dist/`.
3. Publique uma versão (release) `vX.Y.Z` no GitHub. O workflow gera os `.zip` e anexa à versão.

Quem instalou pelo marketplace recebe a atualização ao clicar em **Atualizar**. Quem usa o chat precisa enviar o `.zip` novo.
