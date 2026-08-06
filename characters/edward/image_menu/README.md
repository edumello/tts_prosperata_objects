# Fundo visual do painel Edward

`build_panel.ps1` gera o fundo `2048x640` usado pelo Custom Tile.

O PNG deve conter apenas elementos estaticos: fundo, moldura, cabecalho, divisorias e nomes das secoes. Botoes, inputs, estados, previews e textos de acao pertencem exclusivamente ao `ui.xml`.

Geracao isolada:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File characters/edward/image_menu/build_panel.ps1
```

O fluxo recomendado e executar `characters/edward/build.ps1`, que tambem sincroniza a Object UI e gera o JSON de teste.
