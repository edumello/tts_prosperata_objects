# Fundo visual do painel Edward

`build_panel.ps1` gera o fundo `1792x1024` (`7:4`) usado pelo Custom Tile.

O PNG deve conter somente o fundo e a moldura. Cabecalho, divisorias, nomes das
secoes, botoes, inputs, estados, previews e textos pertencem exclusivamente ao
`ui.xml`, evitando que a textura e os controles usem grades diferentes.

Geracao isolada:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File characters/edward/image_menu/build_panel.ps1
```

O fluxo recomendado e executar `characters/edward/build.ps1`, que tambem sincroniza a Object UI e gera o JSON de teste.
