# Skills da Archicode para o Claude

Plugins e skills oficiais da [Archicode](https://archicode.com.br) para usar nossos produtos conversando com o Claude.

| Plugin | O que faz | Skills |
|---|---|---|
| **valora** | Avaliação de imóveis com a sua conta [Valora](https://archicode.com.br/valora): pesquisa de comparáveis, parecer de valor do corretor e laudo NBR 14653 do engenheiro ou arquiteto. Já traz o conector do Valora. | `parecer-de-valor`, `laudo-de-avaliacao` |

## Instalar

### No app do Claude (Cowork, desktop e web)

1. Abra **Personalizar → Plugins**.
2. Clique em **Adicionar marketplace** e cole `VCalazans/archicode-skills`.
3. Os plugins da Archicode aparecem na lista. Clique em **Instalar** no **valora**.
4. Quando pedir, entre com o e-mail e a senha do Valora. Ainda não tem conta? [Crie aqui](https://valora.archicode.com.br/register).

Para receber atualizações, clique em **Atualizar** no marketplace da Archicode.

### No chat do Claude (claude.ai)

O chat usa skills avulsas em vez de plugins.

1. Baixe os arquivos `.zip` na [página de versões](https://github.com/VCalazans/archicode-skills/releases/latest).
2. Em **Personalizar → Skills**, clique em **+**, **Criar skill**, **Enviar uma skill** e escolha o `.zip`. Repita para cada skill.
3. Ligue o conector do Valora: **Personalizar → Conectores → Adicionar conector personalizado**, nome `Valora`, endereço `https://mcp-valora.archicode.tech/mcp`. Ou use o botão da tela **Conectar à sua IA**, dentro do Valora.

As skills precisam de "execução de código e criação de arquivos" ligada (Configurações → Recursos). Em planos Team e Enterprise, o administrador pode liberar as skills para toda a organização.

### No Claude Code

```shell
/plugin marketplace add VCalazans/archicode-skills
/plugin install valora@archicode
```

## Experimente

- "Prepare um parecer de valor de um terreno de 400 m² no Centro de Chapecó/SC."
- "Vou fazer um laudo de um apartamento de 85 m² no Victor Konder, Blumenau. Comece pelas amostras que já tenho."

O Claude sempre diz quanto custa e pede confirmação antes de gastar créditos ou gravar dados no Valora.

> **Parecer ou laudo?** O parecer de valor do corretor (PTAM) é uma opinião de valor para negociar. Em processo judicial, financiamento ou garantia bancária, inventário e partilha ou desapropriação, o documento exigido é o laudo de engenheiro ou arquiteto, pela NBR 14653.

## Guias

- [Guia do corretor](https://archicode.com.br/blog/como-provar-valor-imovel-proprietario-guia-valora-corretores)
- [Guia do laudo para engenheiros e arquitetos](https://archicode.com.br/blog/laudo-avaliacao-regressao-valora-passo-a-passo-engenheiros-arquitetos)

## Suporte

Fale com a Archicode pelo site [archicode.com.br](https://archicode.com.br). Para contribuir ou criar um novo plugin, veja [CONTRIBUTING.md](CONTRIBUTING.md).
