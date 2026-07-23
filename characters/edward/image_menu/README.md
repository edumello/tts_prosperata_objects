# Painel visual Edward V1

Esta pasta contem o gerador e os metadados do painel visual usado no Tabletop Simulator.

Todos os caminhos deste arquivo sao relativos a `characters/edward/`, salvo quando indicado o contrario.

## Arquivos oficiais

```text
image_menu/build_panel.ps1
image_menu/manifest.json
image_menu/exports/edward_attack_panel_v1.png
../assets/edward_attack_panel.png
```

## Gerar o painel

Execute a partir da pasta `characters/edward/`:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File image_menu\build_panel.ps1
```

Ou a partir da raiz do repo:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File characters\edward\image_menu\build_panel.ps1
```

O comando atualiza:

```text
image_menu/exports/edward_attack_panel_v1.png
assets/edward_attack_panel.png
```

## Canvas

```text
2048x640
```

Esse tamanho deve ser mantido para preservar o alinhamento com os botoes e inputs do Lua.

## Conteudo do PNG

O PNG desenha:

- moldura;
- cabecalho;
- colunas `ATAQUES`, `MOD. EXTRAS` e `PREVIA`;
- icones;
- nomes fixos dos ataques;
- caixas vazias para valores dinamicos;
- botoes visuais de acao.

O Lua desenha:

- `ON` / `OFF`;
- modo do Ataque Especial;
- PM do Ataque Especial;
- nomes editaveis dos modificadores extras;
- valores dos modificadores extras;
- previews numericos;
- labels dos botoes de acao.

## Mod. Extras

Cada uma das quatro linhas tem:

- um icone de `+`;
- um campo visual para input de nome;
- um campo visual separado para valor.

O tamanho clicavel e a fonte dos inputs ficam em `ataque_edward.lua`, na funcao `criarInput`.

## Sincronizacao com Lua

Se uma caixa visual for movida no PNG, atualizar tambem a posicao correspondente em:

```text
ataque_edward.lua
image_menu/manifest.json
CONTEXT.md
```

Se mudar a ordem dos botoes, atualizar:

```text
BUTTON
BUTTON_ORDER
CONTROLES
image_menu/manifest.json
```
