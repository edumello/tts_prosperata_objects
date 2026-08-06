# Edward Attack Panel

Painel/script de Tabletop Simulator para automatizar ataques do personagem Edward em Tormenta20.

## Arquivos principais

- `ataque_edward.lua`: script do objeto no Tabletop Simulator.
- `ui.xml`: referencia legada do antigo popup de resultado (nao e mais usada pelo script).
- `assets/edward_attack_panel.png`: imagem oficial usada no painel.
- `image_menu/build_panel.ps1`: gerador da imagem do painel.
- `image_menu/manifest.json`: posicoes e metadados da UI.
- `CONTEXT.md`: contexto tecnico e decisoes oficiais do projeto.
- `UI_PLAN.md`: plano de manutencao da UI.

## Fluxo de update

1. Edite `ataque_edward.lua` e os arquivos necessarios.
2. Se alterar a imagem, rode a partir desta pasta:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File image_menu\build_panel.ps1
```

Ou a partir da raiz do repo:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File characters\edward\image_menu\build_panel.ps1
```

3. Atualize o objeto salvo no Tabletop Simulator ou use o updater futuro.
4. Teste `ROLAR ATAQUE`, `ROLAR DANO` e `ROLAR ATAQUE CRITICO`.

## Observacoes

Resultados de ataque e dano aparecem somente no chat, usando o verde original do Edward. O script converte os colchetes dos dados para caracteres Unicode antes de publicar, evitando que o parser de BBCode do TTS corrompa o chat.
