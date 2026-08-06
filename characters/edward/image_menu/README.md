# Fundo visual do painel Edward

`build_panel.ps1` redimensiona deterministicamente a arte-fonte medieval em
`source/edward_medieval_frame.png` para o fundo `1792x1024` (`7:4`) usado pelo
Custom Tile.

A arte contem fundo de couro, moldura de aco e filigranas de bronze, mas nenhum
texto ou controle. Cabecalho, divisorias, nomes das secoes, botoes, inputs,
estados e previews pertencem exclusivamente ao `ui.xml`.

Geracao isolada:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File characters/edward/image_menu/build_panel.ps1
```

O fluxo recomendado e executar `characters/edward/build.ps1`, que tambem sincroniza a Object UI e gera o JSON de teste.
