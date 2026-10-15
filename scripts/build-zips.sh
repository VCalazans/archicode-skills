#!/usr/bin/env sh
# Gera um .zip por skill em dist/, no formato aceito por claude.ai (Personalizar → Skills → Enviar uma skill):
# o zip contém a pasta da skill, cujo nome é igual ao campo `name` do SKILL.md.
set -eu
cd "$(dirname "$0")/.."
rm -rf dist && mkdir -p dist
for dir in plugins/*/skills/*/; do
  skill=$(basename "$dir")
  name=$(sed -n 's/^name:[[:space:]]*//p' "$dir/SKILL.md" | head -n1)
  if [ "$name" != "$skill" ]; then
    echo "erro: pasta '$skill' e name '$name' diferentes em $dir" >&2
    exit 1
  fi
  (cd "$(dirname "$dir")" && zip -qr "../../../dist/$skill.zip" "$skill" -x '*.DS_Store')
  echo "dist/$skill.zip"
done
